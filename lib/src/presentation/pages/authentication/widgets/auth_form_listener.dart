import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finskool/src/comman/enum.dart';

/// Shared "wait for the API, then move" wiring for the auth forms.
///
/// Every auth submit button used to dispatch its event and navigate in the
/// same synchronous call, because there was no backend. Now navigation is
/// gated: it happens only once the bloc reaches [RequestState.loaded], and a
/// failure surfaces the server's own message as a snackbar.
///
/// Generic over the bloc because each auth bloc has its own state type but
/// the same `RequestState` + `message` shape; [status] and [message] pull
/// those two fields out.
class AuthFormListener<B extends StateStreamable<S>, S> extends StatelessWidget {
  const AuthFormListener({
    super.key,
    required this.status,
    required this.message,
    required this.onSuccess,
    required this.child,
    this.isMine,
  });

  final RequestState Function(S state) status;
  final String Function(S state) message;
  final void Function(BuildContext context, S state) onSuccess;
  final Widget child;

  /// Ignore state changes that aren't this screen's business.
  ///
  /// Needed where several stacked screens share one bloc — the four
  /// password-reset screens all stay mounted, so without this, finishing
  /// step 3 would also fire step 1's listener and push a duplicate route.
  final bool Function(S state)? isMine;

  @override
  Widget build(BuildContext context) {
    return BlocListener<B, S>(
      listenWhen: (previous, current) => status(previous) != status(current),
      listener: (context, state) {
        if (isMine != null && !isMine!(state)) return;
        final current = status(state);
        if (current.isLoaded) {
          onSuccess(context, state);
          return;
        }
        if (!current.isError) return;

        // Local validation failures also land on `error`, but they carry no
        // message — those render inline under their own field instead.
        final text = message(state);
        if (text.isEmpty) return;
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(text)));
      },
      child: child,
    );
  }
}
