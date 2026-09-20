import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:finskool/src/comman/widgets/user_avatar.dart';
import 'package:finskool/src/domain/model/auth/user_model.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'profile_icons.dart';

/// The teal grid-star hero — background image, avatar, camera badge.
///
/// A fixed-height widget on purpose: it's the `SliverAppBar.flexibleSpace`
/// in `ProfileScreen`'s `CustomScrollView`, the same floating/snap
/// `SliverAppBar` technique `SearchTopBar` uses on Feed/Communities (see
/// `communities_screen.dart`) — a sliver app bar needs its content's height
/// known ahead of layout, so [height] is exposed for the screen to pass as
/// `toolbarHeight`. Name/email/phone/member-since live in
/// `ProfileIdentityInfo` instead, as ordinary scrolling content below it —
/// their height varies (wrapped names, an absent pill), which a sliver app
/// bar can't accommodate.
///
/// The background reuses `assets/images/feed_top_bar_bg.png` — the same
/// asset `SearchTopBar` uses for the Feed/Communities top bar.
///
/// The avatar bridges the hero and the white body below it, same technique
/// as `CommunityCover`'s badge: a `Stack` sized to the hero's own height
/// plus the avatar's overhang, with the avatar `Positioned` straddling the
/// seam.
class ProfileHeroBanner extends StatelessWidget {
  const ProfileHeroBanner({super.key, required this.user});

  final UserModel? user;

  static const double avatarRadius = 53.5;
  static const double heroHeight = 120;

  static double height(BuildContext context) =>
      MediaQuery.paddingOf(context).top + heroHeight + avatarRadius;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final topInset = MediaQuery.paddingOf(context).top;

    // Same treatment as `SearchTopBar`: the image bleeds behind the status
    // bar (no `SafeArea` here — see `ProfileScreen`), so the status-bar
    // icons need to switch to light/white to stay visible over the dark
    // background, exactly as Feed/Communities do.
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: SizedBox(
        height: height(context),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: double.infinity,
              height: topInset + heroHeight,
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(AppRadii.lg)),
                image: DecorationImage(
                  image: AssetImage('assets/images/feed_top_bar_bg.png'),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
            Positioned(
              top: topInset + heroHeight - avatarRadius,
              left: 0,
              right: 0,
              // `Positioned` ignores the Stack's own `alignment` once a
              // child is wrapped in it — has to be centered explicitly.
              child: Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    UserAvatar(user: user, radius: avatarRadius),
                    Positioned(
                      right: -2,
                      bottom: -2,
                      child: Container(
                        height: 25,
                        width: 25,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppPalette.secondary,
                          shape: BoxShape.circle,
                          border: Border.all(color: cs.surface, width: 2),
                        ),
                        child: Icon(ProfileIcons.camera,
                            size: 13, color: cs.onPrimary),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
