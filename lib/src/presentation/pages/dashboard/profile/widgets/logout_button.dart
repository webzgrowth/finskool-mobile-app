import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// Sign-out control, drawn like the Profile cards around it rather than as a
/// stock Material outlined button: a 48px `r14` plate in the danger tint with
/// a red icon tile and a red Inter 600 label — the same red the "Expires in N
/// days" row uses. Disabled while the request is in flight so a double tap
/// can't fire two logouts. The tap opens `showLogoutDialog`'s confirmation
/// first; this widget only reports it.
class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
    required this.loading,
    required this.onPressed,
  });

  final bool loading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final type = context.profileType;
    return Semantics(
      button: true,
      enabled: !loading,
      label: 'Log out',
      child: Material(
        color: AppPalette.ticketOpenSurface,
        borderRadius: BorderRadius.circular(AppRadii.md),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: loading ? null : onPressed,
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadii.md),
              border: Border.all(
                color: AppPalette.ticketRequired.withValues(alpha: 0.22),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (loading)
                  const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppPalette.ticketRequired,
                    ),
                  )
                else
                  SvgPicture.asset(
                    'assets/icons/profile_logout.svg',
                    height: 18,
                    width: 18,
                    colorFilter: const ColorFilter.mode(
                      AppPalette.ticketRequired,
                      BlendMode.srcIn,
                    ),
                  ),
                const SizedBox(width: 10),
                Text(
                  loading ? 'Signing out…' : 'Log out',
                  style: type.rowTitle.copyWith(
                    color: AppPalette.ticketRequired,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
