import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finskool/src/comman/widgets/user_avatar.dart';
import 'package:finskool/src/presentation/bloc/authentication/authenticator_watcher/authenticator_watcher_bloc.dart';

/// The signed-in member's own avatar beside their bubbles: the real photo, or
/// their initials. Figma draws an illustration there; a chat showing someone
/// else's face as "you" would be wrong, so it uses [UserAvatar].
class MemberAvatar extends StatelessWidget {
  const MemberAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticatorWatcherBloc, AuthenticatorWatcherState>(
      builder: (context, state) => UserAvatar(
        user: state.maybeMap(authenticated: (s) => s.user, orElse: () => null),
        radius: 14,
      ),
    );
  }
}
