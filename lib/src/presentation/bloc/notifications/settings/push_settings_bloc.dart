import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/domain/usecases/notifications/get_push_enabled.dart';
import 'package:finskool/src/domain/usecases/notifications/set_push_enabled.dart';

part 'push_settings_event.dart';
part 'push_settings_state.dart';
part 'push_settings_bloc.freezed.dart';

/// The Profile → Settings "Notifications" switch: the **master** push switch
/// (`/mobile/push-settings`). Inbox, socket and email are unaffected by it.
/// Separate from the post-alerts toggle, which lives on the user
/// (`postNotificationsEnabled`) — they do different things.
///
/// Optimistic: the switch flips at once and snaps back, with the server's
/// message, if the request fails.
@singleton
class PushSettingsBloc extends Bloc<PushSettingsEvent, PushSettingsState> {
  PushSettingsBloc(this._get, this._set) : super(PushSettingsState.initial()) {
    on<PushSettingsEvent>((event, emit) async {
      await event.map(
        load: (_) async {
          final r = await _get.execute();
          r.fold((_) {}, (v) => emit(state.copyWith(enabled: v)));
        },
        toggled: (v) async {
          final before = state.enabled;
          emit(state.copyWith(enabled: v.enabled, saving: true, message: ''));
          final r = await _set.execute(v.enabled);
          emit(
            r.fold(
              (f) => state.copyWith(
                enabled: before,
                saving: false,
                message: f.message,
              ),
              (server) => state.copyWith(enabled: server, saving: false),
            ),
          );
        },
        reset: (_) async => emit(PushSettingsState.initial()),
      );
    });
  }

  final GetPushEnabled _get;
  final SetPushEnabled _set;
}
