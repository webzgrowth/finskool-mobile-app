import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/widgets/teal_sheet_scaffold.dart';
import 'package:finskool/src/domain/model/auth/user_model.dart';
import 'package:finskool/src/presentation/bloc/authentication/authenticator_watcher/authenticator_watcher_bloc.dart';
import 'package:finskool/src/presentation/bloc/profile/edit_profile/edit_profile_bloc.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_form_listener.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'widgets/edit_profile_actions.dart';
import 'widgets/edit_profile_avatar.dart';
import 'widgets/phone_change_notice.dart';
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
    // still be in state. Seed from the watcher's cached user. The controllers
    // are filled right here from the same pure function: `add` only queues,
    // and a state-change listener never fires when a revisit re-seeds the
    // same values — which is what left the fields blank "sometimes".
    final user = _cachedUser;
    _fill(EditProfileState.fromUser(user));
    context.read<EditProfileBloc>().add(EditProfileEvent.prefill(user));
  }

  void _fill(EditProfileState s) {
    _name.text = s.name;
    _email.text = s.email;
    _phone.text = s.phone;
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
        context.read<AuthenticatorWatcherBloc>().add(
          const AuthenticatorWatcherEvent.authCheckRequest(),
        );
      },
      child: BlocListener<AuthenticatorWatcherBloc, AuthenticatorWatcherState>(
        // The session refresh can land after this screen opened (or deliver
        // the user for the first time); re-seed unless the member is typing.
        listenWhen: (p, c) => c.mapOrNull(authenticated: (_) => true) ?? false,
        listener: (context, _) {
          final bloc = context.read<EditProfileBloc>();
          final user = _cachedUser;
          if (bloc.state.isEditing || user == null) return;
          bloc.add(EditProfileEvent.prefill(user));
        },
        child: BlocListener<EditProfileBloc, EditProfileState>(
          // Push bloc values into the controllers only while not editing —
          // that covers the prefill landing and a successful save, and never
          // fights the cursor mid-type (typing happens with isEditing true).
          listenWhen: (p, c) =>
              !c.isEditing &&
              (p.name != c.name || p.email != c.email || p.phone != c.phone),
          listener: (context, state) {
            _fill(state);
          },
          child: BlocBuilder<EditProfileBloc, EditProfileState>(
            builder: (context, state) {
              return TealSheetScaffold(
                children: [
                  SheetBackArrow(onTap: () => context.pop()),
                  const SizedBox(height: AppSpacing.sm),
                  EditProfileAvatar(
                    user: state.user ?? _cachedUser,
                    name: state.name,
                    busy: state.avatarBusy,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  PersonalDetailsSection(
                    state: state,
                    nameController: _name,
                    emailController: _email,
                    phoneController: _phone,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  if (state.isEditing) ...[
                    EditProfileActions(state: state),
                    const SizedBox(height: AppSpacing.lg),
                  ],
                  const SebiDetailsSection(),
                  if (state.isEditing) ...[
                    const SizedBox(height: AppSpacing.lg),
                    const PhoneChangeNotice(),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
