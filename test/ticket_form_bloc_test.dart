import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/ticket/ticket_enums.dart';
import 'package:finskool/src/domain/model/ticket/ticket_page_model.dart';
import 'package:finskool/src/domain/usecases/tickets/create_ticket.dart';
import 'package:finskool/src/domain/usecases/tickets/get_ticket_communities.dart';
import 'package:finskool/src/domain/usecases/tickets/upload_ticket_attachment.dart';
import 'package:finskool/src/presentation/bloc/tickets/form/ticket_attachment_draft.dart';
import 'package:finskool/src/presentation/bloc/tickets/form/ticket_form_bloc.dart';
import 'package:finskool/src/presentation/bloc/tickets/form/ticket_form_validation.dart';

import 'support/ticket_fakes.dart';

void main() {
  late FakeTicketsRepository repo;
  late TicketFormBloc bloc;

  Future<void> settle() =>
      Future<void>.delayed(const Duration(milliseconds: 20));

  /// Fills every required field, leaving the form ready to submit.
  Future<void> fill() async {
    bloc.add(const TicketFormEvent.started());
    await settle();
    bloc
      ..add(
        const TicketFormEvent.communityChanged(
          TicketCommunityModel(id: 'c1', name: 'Intraday Community'),
        ),
      )
      ..add(const TicketFormEvent.categoryChanged(TicketCategory.payments))
      ..add(const TicketFormEvent.typeChanged(TicketType.issue))
      ..add(const TicketFormEvent.subjectChanged('Payment failed'))
      ..add(const TicketFormEvent.descriptionChanged('Money deducted'));
    await settle();
  }

  setUp(() {
    repo = FakeTicketsRepository();
    bloc = TicketFormBloc(
      GetTicketCommunities(repo),
      UploadTicketAttachment(repo),
      CreateTicket(repo),
    );
  });

  tearDown(() => bloc.close());

  group('idempotency key', () {
    test('a key exists from the moment the form is built', () {
      expect(bloc.state.idempotencyKey, isNotEmpty);
    });

    test('a plain retry after a failure REUSES the key', () async {
      await fill();
      repo.createFailure = const ServerFailure('Could not reach the server.');

      bloc.add(const TicketFormEvent.submitted());
      await settle();
      expect(bloc.state.submit.isError, isTrue);

      repo.createFailure = null;
      bloc.add(const TicketFormEvent.submitted());
      await settle();

      // Same submission, same key: if the first attempt did reach the
      // server, the repeat returns that ticket rather than raising another.
      expect(repo.createdKeys, hasLength(2));
      expect(repo.createdKeys.first, repo.createdKeys.last);
    });

    test('an EDIT after a failure rotates the key', () async {
      await fill();
      repo.createFailure = const ServerFailure('Timed out.');
      bloc.add(const TicketFormEvent.submitted());
      await settle();

      bloc.add(const TicketFormEvent.subjectChanged('Payment failed twice'));
      repo.createFailure = null;
      bloc.add(const TicketFormEvent.submitted());
      await settle();

      // An edited form is a different submission. Reusing the key would
      // hand back the first, stale ticket.
      expect(repo.createdKeys.first, isNot(repo.createdKeys.last));
    });

    test('a successful submit exposes the created ticket', () async {
      await fill();
      bloc.add(const TicketFormEvent.submitted());
      await settle();
      expect(bloc.state.submit.isLoaded, isTrue);
      expect(bloc.state.created!.label, 'FS-2041');
    });
  });

  group('validation', () {
    test('runs on submit, marking the missing required fields', () async {
      bloc.add(const TicketFormEvent.started());
      await settle();
      bloc.add(const TicketFormEvent.submitted());
      await settle();

      expect(repo.createdKeys, isEmpty, reason: 'no request when invalid');
      // Subscription is optional and Type has no field: neither can block.
      expect(bloc.state.communityError, isNull);
      expect(bloc.state.typeError, isNull);
      expect(bloc.state.categoryError, isNotNull);
      expect(bloc.state.subjectError, isNotNull);
      expect(bloc.state.descriptionError, isNotNull);
    });

    test("an edit clears that field's own error and no other", () async {
      bloc.add(const TicketFormEvent.started());
      await settle();
      bloc.add(const TicketFormEvent.submitted());
      await settle();

      bloc.add(const TicketFormEvent.subjectChanged('Something'));
      await settle();
      expect(bloc.state.subjectError, isNull);
      expect(bloc.state.descriptionError, isNotNull);
    });

    test('the description cap is the design\'s 500, not the API\'s 2000', () {
      expect(TicketFormValidation.descriptionMax, 500);
      final over = TicketFormState.initial().copyWith(
        subject: 'ok',
        description: 'x' * 501,
      );
      expect(over.validated().descriptionError, contains('500'));
    });

    test('a 422 from the server lands on its own field', () async {
      await fill();
      repo.createFailure = const ValidationFailure(
        'Validation failed',
        errors: {
          'subject': ['Subject is required'],
        },
      );
      bloc.add(const TicketFormEvent.submitted());
      await settle();
      expect(bloc.state.subjectError, 'Subject is required');
    });
  });

  group('communities', () {
    test('a single community is preselected', () async {
      repo.communities = const [TicketCommunityModel(id: 'only', name: 'Free')];
      bloc.add(const TicketFormEvent.started());
      await settle();
      expect(bloc.state.community!.id, 'only');
    });

    test('an empty list means the member cannot raise a ticket', () async {
      repo.communities = const [];
      bloc.add(const TicketFormEvent.started());
      await settle();
      expect(bloc.state.cannotRaise, isTrue);
      expect(bloc.state.canSubmit, isFalse);
    });
  });

  group('attachments', () {
    test('the local rules reject what the server would', () {
      expect(
        UploadRules.check(fileName: 'a.png', sizeBytes: 1000, currentCount: 0),
        isNull,
      );
      expect(
        UploadRules.check(fileName: 'a.exe', sizeBytes: 1000, currentCount: 0),
        contains('PNG'),
      );
      expect(
        UploadRules.check(
          fileName: 'a.pdf',
          sizeBytes: 6 * 1024 * 1024,
          currentCount: 0,
        ),
        contains('5 MB'),
      );
      expect(
        UploadRules.check(fileName: 'a.png', sizeBytes: 1, currentCount: 5),
        contains('5 files'),
      );
    });

    test('the extension check is case-insensitive', () {
      expect(
        UploadRules.check(fileName: 'SCAN.PNG', sizeBytes: 1, currentCount: 0),
        isNull,
      );
    });

    test('a bad attachment on submit clears the files and re-keys', () async {
      await fill();
      final before = bloc.state.idempotencyKey;
      repo.createFailure = const ServerFailure(
        'Bad file',
        code: 'ATTACHMENT_INVALID',
      );
      bloc.add(const TicketFormEvent.submitted());
      await settle();

      expect(bloc.state.files, isEmpty);
      expect(bloc.state.message, contains('attach'));
      expect(bloc.state.idempotencyKey, isNot(before));
    });
  });
}
