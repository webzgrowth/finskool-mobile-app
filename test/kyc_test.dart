import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/kyc/kyc_details.dart';
import 'package:finskool/src/domain/model/kyc/kyc_status.dart';
import 'package:finskool/src/domain/usecases/kyc/get_kyc_status.dart';
import 'package:finskool/src/domain/usecases/kyc/submit_kyc.dart';
import 'package:finskool/src/presentation/bloc/communities/compliance/compliance_bloc.dart';
import 'package:finskool/src/presentation/bloc/kyc/status/kyc_bloc.dart';

import 'support/purchase_fakes.dart';

Future<void> pump([int ms = 30]) =>
    Future<void>.delayed(Duration(milliseconds: ms));

void main() {
  group('KycDetails → the API\'s shape', () {
    test('DD/MM/YYYY becomes YYYY-MM-DD, the PAN is upper-cased', () {
      const d = KycDetails(
        dateOfBirth: '05/04/1995',
        panNumber: ' abcde1234f ',
      );
      expect(d.toJson(), {
        'dateOfBirth': '1995-04-05',
        'panNumber': 'ABCDE1234F',
      });
    });

    test('anything that is not a complete real date has no ISO form', () {
      for (final bad in ['31/02/2000', '05/04/95', '', 'x/y/z', '05/04']) {
        expect(
          KycDetails(dateOfBirth: bad, panNumber: '').isoDateOfBirth,
          isNull,
          reason: bad,
        );
      }
    });
  });

  test('KycStatus reads the flag, a calendar date and the masked PAN', () {
    final s = KycStatus.fromJson({
      'completed': true,
      'dateOfBirth': '1995-04-12',
      'panMasked': 'XXXXXX234F',
    });
    expect(s.completed, isTrue);
    expect(s.dateOfBirth, DateTime(1995, 4, 12));
    expect(s.panMasked, 'XXXXXX234F');
    final none = KycStatus.fromJson({'completed': false});
    expect(none.completed, isFalse);
    expect(none.dateOfBirth, isNull);
    expect(none.panMasked, isNull);
  });

  group('KycBloc', () {
    late FakeKycRepository repo;
    late KycBloc bloc;
    setUp(() {
      repo = FakeKycRepository();
      bloc = KycBloc(GetKycStatus(repo));
    });
    tearDown(() => bloc.close());

    test('load puts the server\'s answer in memory', () async {
      repo.status = Right(
        KycStatus(
          completed: true,
          dateOfBirth: DateTime(1995, 4, 12),
          panMasked: 'XXXXXX234F',
        ),
      );
      bloc.add(const KycEvent.load());
      await pump();
      expect(bloc.state.state, RequestState.loaded);
      expect(bloc.state.status!.panMasked, 'XXXXXX234F');
    });

    test(
      'a failed first load is an error; a failed re-check keeps what it had',
      () async {
        repo.status = const Left(ConnectionFailure('No internet connection.'));
        bloc.add(const KycEvent.load());
        await pump();
        expect(bloc.state.state, RequestState.error);

        repo.status = const Right(
          KycStatus(completed: true, panMasked: 'XXXXXX234F'),
        );
        bloc.add(const KycEvent.load());
        await pump();
        repo.status = const Left(ConnectionFailure('No internet connection.'));
        bloc.add(const KycEvent.load());
        await pump();
        expect(bloc.state.state, RequestState.loaded);
        expect(bloc.state.status!.panMasked, 'XXXXXX234F');
      },
    );

    test(
      'reset forgets the member, and a late answer cannot bring them back',
      () async {
        repo.status = const Right(
          KycStatus(completed: true, panMasked: 'XXXXXX234F'),
        );
        bloc.add(const KycEvent.load());
        await pump();
        bloc.add(const KycEvent.reset());
        await pump();
        expect(bloc.state.status, isNull);
      },
    );
  });

  group('ComplianceBloc (the form)', () {
    late FakeKycRepository repo;
    late ComplianceBloc bloc;
    setUp(() {
      repo = FakeKycRepository();
      bloc = ComplianceBloc(SubmitKyc(repo));
    });
    tearDown(() => bloc.close());

    void fill({String dob = '05/04/1995', String pan = 'ABCPE1234F'}) {
      bloc
        ..add(ComplianceEvent.dateOfBirthChanged(dob))
        ..add(ComplianceEvent.panChanged(pan))
        ..add(const ComplianceEvent.confirmationToggled());
    }

    test(
      'sends ISO date + PAN, and wipes both from memory once saved',
      () async {
        fill();
        bloc.add(const ComplianceEvent.submit());
        await pump();
        expect(repo.submitted.single.toJson(), {
          'dateOfBirth': '1995-04-05',
          'panNumber': 'ABCPE1234F',
        });
        expect(bloc.state.state, RequestState.loaded);
        expect(bloc.state.pan, isEmpty);
        expect(bloc.state.dateOfBirth, isEmpty);
      },
    );

    test(
      'a two-digit year, an impossible or a future date never reach the API',
      () async {
        for (final dob in [
          '05/04/95',
          '31/02/2000',
          '01/01/2999',
          '01/01/1800',
        ]) {
          fill(dob: dob);
          bloc.add(const ComplianceEvent.submit());
          await pump();
          expect(bloc.state.dateOfBirthError, isNotNull, reason: dob);
          bloc.add(const ComplianceEvent.initial());
          await pump();
        }
        expect(repo.submitted, isEmpty);
      },
    );

    test(
      'the contract\'s sample PANs and today\'s date are accepted',
      () async {
        final n = DateTime.now();
        final today = '${n.day}/${n.month}/${n.year}';
        for (final pan in ['ABCDE1234F', 'PQRST6789U']) {
          fill(dob: today, pan: pan);
          bloc.add(const ComplianceEvent.confirmationToggled());
          bloc.add(const ComplianceEvent.submit());
          await pump();
          expect(bloc.state.panError, isNull, reason: pan);
          expect(bloc.state.dateOfBirthError, isNull, reason: today);
          bloc.add(const ComplianceEvent.initial());
          await pump();
        }
      },
    );

    test(
      'a PAN that is not 5 letters + 4 digits + 1 letter is refused',
      () async {
        for (final pan in [
          'ABCDE1234',
          'ABCDE12345',
          '1BCDE1234F',
          'ABC DE1234F',
        ]) {
          fill(pan: pan);
          bloc.add(const ComplianceEvent.submit());
          await pump();
          expect(bloc.state.panError, isNotNull, reason: pan);
          bloc.add(const ComplianceEvent.initial());
          await pump();
        }
      },
    );

    test(
      'a complete date is judged as it is typed; a partial one is not',
      () async {
        bloc.add(const ComplianceEvent.dateOfBirthChanged('31/02/2000'));
        await pump();
        expect(bloc.state.dateOfBirthError, isNotNull);
        bloc.add(const ComplianceEvent.dateOfBirthChanged('01/01/2999'));
        await pump();
        expect(bloc.state.dateOfBirthError, isNotNull);
        bloc.add(const ComplianceEvent.dateOfBirthChanged('31/0'));
        await pump();
        expect(bloc.state.dateOfBirthError, isNull, reason: 'still typing');
        bloc.add(const ComplianceEvent.dateOfBirthChanged('05/04/1995'));
        await pump();
        expect(bloc.state.dateOfBirthError, isNull);
      },
    );

    test('409 KYC_ALREADY_SUBMITTED counts as done', () async {
      repo.submitResult = const Left(
        ServerFailure('Already submitted.', code: 'KYC_ALREADY_SUBMITTED'),
      );
      fill();
      bloc.add(const ComplianceEvent.submit());
      await pump();
      expect(bloc.state.state, RequestState.loaded);
    });

    test('a 422 lands under its own field', () async {
      repo.submitResult = const Left(
        ValidationFailure(
          'Validation failed.',
          errors: {
            'panNumber': ['Invalid PAN.'],
          },
        ),
      );
      fill();
      bloc.add(const ComplianceEvent.submit());
      await pump();
      expect(bloc.state.state, RequestState.error);
      expect(bloc.state.panError, 'Invalid PAN.');
      expect(bloc.state.dateOfBirthError, isNull);
    });

    test(
      'any other failure shows the server\'s words and keeps what was typed',
      () async {
        repo.submitResult = const Left(
          ConnectionFailure('No internet connection.'),
        );
        fill();
        bloc.add(const ComplianceEvent.submit());
        await pump();
        expect(bloc.state.message, 'No internet connection.');
        expect(bloc.state.pan, 'ABCPE1234F');
      },
    );
  });
}
