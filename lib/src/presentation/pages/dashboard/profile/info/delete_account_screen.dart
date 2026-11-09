import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/injections/injection.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/domain/model/auth/user_model.dart';
import 'package:finskool/src/domain/model/profile/profile_info.dart';
import 'package:finskool/src/domain/repository/profile_info_repository.dart';
import 'package:finskool/src/presentation/bloc/authentication/authenticator_watcher/authenticator_watcher_bloc.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'delete_account_request.dart';
import 'widgets/delete_account_dialog.dart';
import 'widgets/info_actions.dart';
import 'widgets/info_blocks.dart';
import 'widgets/info_page.dart';
import 'widgets/policy_blocks.dart';

/// Profile → Account → Delete account. Reads the signed-in user from
/// [AuthenticatorWatcherBloc]; [DeleteAccountView] is the screen without it.
class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthenticatorWatcherBloc>().state.mapOrNull(
      authenticated: (s) => s.user,
    );
    return DeleteAccountView(user: user);
  }
}

/// What deleting means, in the Privacy policy's and Terms' own words, then the
/// one action: a confirmed, prefilled email to support.
class DeleteAccountView extends StatelessWidget {
  const DeleteAccountView({super.key, this.user});

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    final email = locator<ProfileInfoRepository>().sebi.email;
    return InfoPage(
      title: 'Delete account',
      subtitle: 'What happens to your data',
      children: [
        const InfoSectionLabel('What happens'),
        InfoPlate(
          child: PolicyBlocks(
            blocks: const [
              PolicyBullets([
                'We will delete your personal information, except records we '
                    'must keep by law.',
                'Records that SEBI regulations require us to maintain (such '
                    'as KYC, subscription and communication records) are kept '
                    'for the period those regulations require, even after '
                    'your account is closed.',
              ]),
            ],
          ),
        ),
        const InfoSectionLabel('Subscriptions'),
        InfoPlate(
          child: PolicyBlocks(
            blocks: const [
              PolicyParagraph(
                'All payments are final. Once a subscription is purchased, it '
                'cannot be cancelled and no refund will be issued.',
              ),
            ],
          ),
        ),
        const InfoSectionLabel('How to delete'),
        InfoPlate(
          child: PolicyBlocks(
            blocks: [
              const PolicyBullets([
                'Tap Request account deletion below.',
                'Your email app opens with a message to support that already '
                    'has your name, email and phone. Check it and send it.',
              ]),
              PolicyParagraph('You can also write to $email yourself.'),
            ],
          ),
        ),
        const SizedBox(height: 22),
        _RequestButton(
          onTap: () async {
            if (!await showDeleteAccountDialog(context) || !context.mounted) {
              return;
            }
            final opened = await tryOpenExternal(
              deleteAccountMailto(to: email, user: user),
            );
            // No email app (an emulator, or a phone with none set up): say
            // so and hand over the address instead of a dead tap.
            if (!opened && context.mounted) {
              await copyToClipboard(
                context,
                email,
                'No email app found. Support email copied — write to us '
                'there to delete your account.',
              );
            }
          },
        ),
        const SizedBox(height: 14),
        Center(
          child: GestureDetector(
            onTap: () =>
                context.push(AppRoutes.policyDocument(PolicyKind.privacy.slug)),
            child: Text(
              'Read the Privacy policy →',
              style: context.infoType.link,
            ),
          ),
        ),
      ],
    );
  }
}

class _RequestButton extends StatelessWidget {
  const _RequestButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: 'Request account deletion',
    child: Material(
      color: AppPalette.ticketOpenSurface,
      borderRadius: BorderRadius.circular(AppRadii.md),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadii.md),
            border: Border.all(
              color: AppPalette.ticketRequired.withValues(alpha: 0.22),
            ),
          ),
          child: Text(
            'Request account deletion',
            style: context.profileType.rowTitle.copyWith(
              color: AppPalette.ticketRequired,
              fontSize: 14,
            ),
          ),
        ),
      ),
    ),
  );
}
