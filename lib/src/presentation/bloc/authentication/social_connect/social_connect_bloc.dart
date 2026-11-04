import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/auth/social_models.dart';
import 'package:finskool/src/domain/usecases/social/connect_social_account.dart';

part 'social_connect_event.dart';
part 'social_connect_state.dart';
part 'social_connect_bloc.freezed.dart';

/// Profile → Connect Google / Apple: links a provider to the account the
/// member is **already logged in to** (`POST /me/social/link`).
///
/// Its own bloc, not part of [SocialAuthBloc]: that one is the logged-out
/// sign-in journey and is wiped at sign-out; this is a one-shot action on a
/// signed-in screen. `@injectable`, provided where the Profile's rows are
/// built, and it holds no account data — the result is just "it worked" or the
/// server's reason, and the screen re-reads `/me` for the new
/// `linkedProviders` rather than this bloc keeping a second copy.
@injectable
class SocialConnectBloc extends Bloc<SocialConnectEvent, SocialConnectState> {
  SocialConnectBloc(this._connect) : super(SocialConnectState.initial()) {
    on<SocialConnectEvent>((event, emit) async {
      await event.map(
        requested: (e) => _request(e.provider, emit),
        reset: (_) async => emit(SocialConnectState.initial()),
      );
    });
  }

  final ConnectSocialAccount _connect;

  Future<void> _request(
    SocialProvider provider,
    Emitter<SocialConnectState> emit,
  ) async {
    // One at a time: a second tap while a provider sheet is up asks for nothing.
    if (state.state.isLoading) return;
    emit(SocialConnectState(state: RequestState.loading, provider: provider));
    final result = await _connect.execute(provider);
    emit(
      result.fold(
        // Closing the provider's sheet is not an error and says nothing.
        (failure) => failure is CancelledFailure
            ? SocialConnectState.initial()
            : SocialConnectState(
                state: RequestState.error,
                message: failure.message,
                provider: provider,
              ),
        (_) =>
            SocialConnectState(state: RequestState.loaded, provider: provider),
      ),
    );
  }
}
