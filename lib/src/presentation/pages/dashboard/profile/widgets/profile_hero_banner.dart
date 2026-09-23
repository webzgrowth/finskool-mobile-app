import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:finskool/src/comman/widgets/user_avatar.dart';
import 'package:finskool/src/domain/model/auth/user_model.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'profile_icons.dart';

/// The teal grid-star hero — background image, avatar, camera badge.
///
/// A separate widget from the name/email/phone/member-since block
/// (`ProfileIdentityInfo`) purely for file-size reasons (CLAUDE.md's
/// ~100-line rule) — both are plain, normally-scrolling `ListView`
/// children in `ProfileScreen`, not a sliver app bar (an earlier pass
/// tried that for a floating/snap effect like `SearchTopBar`'s, but that
/// made the banner hide-then-pop-back mid-scroll, which is wrong for a
/// tall identity header — see CLAUDE.md "Profile").
///
/// The background is `assets/images/auth_header_bg.png` — confirmed
/// against a Figma screenshot of this exact screen. An earlier pass used
/// `feed_top_bar_bg.png` (Feed/Communities' `SearchTopBar` asset) on the
/// assumption Profile should match that chrome, but that image is short
/// and bright/saturated throughout (built for a 92px-tall search bar);
/// stretched to this banner's ~230dp height it reads far more vivid teal
/// than the design. `auth_header_bg.png` is a *tall* image and only its
/// top slice is ever visible here (`BoxFit.cover` + `alignment.topCenter`
/// crop to the container's height) — that slice is the dark, muted
/// forest-green with the same dot/grid texture the Figma reference shows.
///
/// The avatar bridges the hero and the white body below it, same technique
/// as `CommunityCover`'s badge: a `Stack` sized to the hero's own height
/// plus the avatar's overhang, with the avatar `Positioned` straddling the
/// seam.
class ProfileHeroBanner extends StatelessWidget {
  const ProfileHeroBanner({super.key, required this.user});

  final UserModel? user;

  static const double avatarRadius = 53.5;
  static const double heroHeight = 150;

  static double height(BuildContext context) =>
      heroHeight + avatarRadius;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final topInset =0;

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
                  image: AssetImage('assets/images/auth_header_bg.png'),
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
