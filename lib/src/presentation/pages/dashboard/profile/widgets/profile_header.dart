import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/comman/widgets/user_avatar.dart';
import 'package:finskool/src/domain/model/auth/user_model.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'profile_glyphs.dart';

/// The Final page's profile header: the dark teal hero, a white sheet riding
/// up over it (radius 16), and the 107px avatar straddling the seam, with the
/// name, email, phone and "Member since" pill centred beneath.
///
/// Positions are Figma's, measured from the sheet's top: avatar from -57,
/// name at 57, email at 92, phone at 112, pill at 134, body at 184. The sheet
/// itself sits 61 below the status bar, read from `MediaQuery` rather than a
/// fixed 44 — same rule and same hero image as the ticket screens
/// (`ticket_hero_bg.png`, cut from this design's own render).
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.user});

  final UserModel? user;

  static const double _avatar = 107;

  @override
  Widget build(BuildContext context) {
    final type = context.profileType;
    final sheetTop = MediaQuery.paddingOf(context).top + 61;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: sheetTop + 32,
            child: Image.asset(
              'assets/images/ticket_hero_bg.png',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: sheetTop),
            padding: const EdgeInsets.only(top: 57, bottom: 25),
            decoration: const BoxDecoration(
              color: AppPalette.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              children: [
                Text(
                  user?.name ?? 'Signed in',
                  textAlign: TextAlign.center,
                  style: type.name,
                ),
                if (user != null) ...[
                  const SizedBox(height: 5),
                  Text(user!.email, style: type.contact),
                  const SizedBox(height: 5),
                  Text(user!.phone, style: type.contact),
                ],
                // The backend supplies no join date yet, so the pill is
                // absent rather than carrying an invented one.
                if (user?.memberSince != null) ...[
                  const SizedBox(height: 7),
                  _MemberPill(since: user!.memberSince!),
                ],
              ],
            ),
          ),
          Positioned(
            top: sheetTop - 57,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                height: _avatar,
                width: _avatar,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    UserAvatar(user: user, radius: _avatar / 2),
                    Positioned(
                      right: 3,
                      bottom: 3,
                      child: Container(
                        height: 25,
                        width: 25,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: AppPalette.reactionRing,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(ProfileGlyphs.camera),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MemberPill extends StatelessWidget {
  const _MemberPill({required this.since});

  final DateTime since;

  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec', //
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      padding: const EdgeInsets.only(left: 11, right: 11),
      decoration: BoxDecoration(
        color: AppPalette.badgeTeal,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0x33FFFFFF)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 6,
            width: 6,
            decoration: const BoxDecoration(
              color: AppPalette.white,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            'Member since ${_months[since.month - 1]} ${since.year}',
            style: context.profileType.memberSince,
          ),
        ],
      ),
    );
  }
}
