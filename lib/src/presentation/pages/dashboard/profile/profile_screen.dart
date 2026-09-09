import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/presentation/bloc/authentication/authenticator_watcher/authenticator_watcher_bloc.dart';
import 'widgets/profile_identity_card.dart';
import 'widgets/logout_button.dart';

/// No design provided yet. This is deliberately minimal — enough to show who
/// is signed in (which doubles as proof that login and session restore
/// worked) and to sign out again, since without a logout the app can't be
/// returned to the login screen once a session is stored.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticatorWatcherBloc, AuthenticatorWatcherState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        state.mapOrNull(
          unauthenticated: (_) => context.go(AppRoutes.LOGIN_ROUTE_PATH),
        );
      },
      builder: (context, state) {
        final user = state.mapOrNull(authenticated: (s) => s.user);
        return Scaffold(
          appBar: AppBar(title: const Text('Profile')),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ProfileIdentityCard(user: user),
                  const Spacer(),
                  LogoutButton(
                    loading: state.maybeMap(
                        authenticating: (_) => true, orElse: () => false),
                    onPressed: () => context
                        .read<AuthenticatorWatcherBloc>()
                        .add(const AuthenticatorWatcherEvent.signOut()),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
