import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/widgets/teal_sheet_scaffold.dart';
import 'package:finskool/src/domain/model/auth/user_model.dart';
import 'package:finskool/src/presentation/bloc/authentication/authenticator_watcher/authenticator_watcher_bloc.dart';
import 'package:finskool/src/presentation/bloc/profile/edit_profile/edit_profile_bloc.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_form_listener.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'widgets/edit_profile_avatar.dart';
import 'widgets/personal_details_section.dart';
import 'widgets/sebi_details_section.dart';

/// Figma `Frame 2121453561`. Reached from the Profile tab's "Edit Profile"
/// row.
///
/// Stateful only to own the three `TextEditingController`s: `EditProfileBloc`
/// stays the source of truth for values, errors and edit mode, and the
/// controllers are seeded once from the cached user rather than driven from
/// state on every build (which would fight the cursor).
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();

  @override
  void initState() {
    super.initState();
    // The bloc is a singleton, so a previous visit's edits would otherwise
    // still be in state. Seed from the watcher's cached user.
    //
    // The controllers are filled by the listener in `build`, not here:
    // `add` only queues the event, so reading `state` back on the next
    // line would return the pre-prefill values.
    context.read<EditProfileBloc>().add(EditProfileEvent.prefill(_cachedUser));
  }

  UserModel? get _cachedUser => context
      .read<AuthenticatorWatcherBloc>()
      .state
      .mapOrNull(authenticated: (s) => s.user);

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthFormListener<EditProfileBloc, EditProfileState>(
      status: (s) => s.state,
      message: (s) => s.message,
      onSuccess: (context, _) {
        // Blocs don't talk to each other — the widget layer refreshes the
        // Profile tab's header, which reads the same cached user this save
        // just rewrote.
        context
            .read<AuthenticatorWatcherBloc>()
            .add(const AuthenticatorWatcherEvent.authCheckRequest());
      },
      child: BlocListener<EditProfileBloc, EditProfileState>(
        // Push bloc values into the controllers only while not editing —
        // that covers the prefill landing and a successful save, and never
        // fights the cursor mid-type (typing happens with isEditing true).
        listenWhen: (p, c) =>
            !c.isEditing &&
            (p.name != c.name || p.email != c.email || p.phone != c.phone),
        listener: (context, state) {
          _name.text = state.name;
          _email.text = state.email;
          _phone.text = state.phone;
        },
        child: BlocBuilder<EditProfileBloc, EditProfileState>(
          builder: (context, state) {
            return TealSheetScaffold(
              children: [
                SheetBackArrow(onTap: () => context.pop()),
                const SizedBox(height: AppSpacing.sm),
                EditProfileAvatar(user: _cachedUser, name: state.name),
                const SizedBox(height: AppSpacing.lg),
                PersonalDetailsSection(
                  state: state,
                  nameController: _name,
                  emailController: _email,
                  phoneController: _phone,
                ),
                const SizedBox(height: AppSpacing.lg),
                const SebiDetailsSection(),
              ],
            );
          },
        ),
      ),
    );
  }
}
