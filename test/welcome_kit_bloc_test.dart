import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/community/welcome_kit.dart';
import 'package:finskool/src/domain/repository/communities_repository.dart';
import 'package:finskool/src/domain/usecases/community/get_welcome_kit.dart';
import 'package:finskool/src/presentation/bloc/communities/welcome_kit/welcome_kit_bloc.dart';

class _Repo implements CommunitiesRepository {
  _Repo(this.result);

  final Either<Failure, WelcomeKit?> result;
  final asked = <String>[];

  @override
  Future<Either<Failure, WelcomeKit?>> getWelcomeKit(String id) async {
    asked.add(id);
    return result;
  }

  @override
  dynamic noSuchMethod(Invocation i) => throw UnimplementedError();
}

Future<WelcomeKitState> _settled(WelcomeKitBloc bloc) =>
    bloc.stream.firstWhere((s) => !s.state.isLoading);

void main() {
  test('a published kit loads', () async {
    final repo = _Repo(const Right(WelcomeKit(whatYouGet: ['x'])));
    final bloc = WelcomeKitBloc(GetWelcomeKit(repo))
      ..add(const WelcomeKitEvent.load('c1'));
    final s = await _settled(bloc);
    expect(s.state.isLoaded, isTrue);
    expect(s.kit!.whatYouGet, ['x']);
    expect(repo.asked, ['c1']);
  });

  test('"no kit" is loaded-with-nothing, not an error', () async {
    final bloc = WelcomeKitBloc(GetWelcomeKit(_Repo(const Right(null))))
      ..add(const WelcomeKitEvent.load('c1'));
    final s = await _settled(bloc);
    expect(s.state.isLoaded, isTrue);
    expect(s.kit, isNull);
  });

  test(
    'a failure is an error, and retry asks for the same community',
    () async {
      final repo = _Repo(Left(ServerFailure('boom')));
      final bloc = WelcomeKitBloc(GetWelcomeKit(repo))
        ..add(const WelcomeKitEvent.load('c9'));
      expect((await _settled(bloc)).state.isError, isTrue);
      bloc.add(const WelcomeKitEvent.retried());
      await _settled(bloc);
      expect(repo.asked, ['c9', 'c9']);
    },
  );
}
