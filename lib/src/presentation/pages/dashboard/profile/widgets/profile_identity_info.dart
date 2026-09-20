import 'package:flutter/material.dart';
import 'package:finskool/src/domain/model/auth/user_model.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// Name, email, phone and the "Member since…" pill — sits directly below
/// `ProfileHeroBanner` as ordinary scrolling content (not inside the
/// `SliverAppBar`, since this block's height varies with a wrapped name or
/// an absent member-since pill, which a sliver app bar's fixed extent can't
/// accommodate).
class ProfileIdentityInfo extends StatelessWidget {
  const ProfileIdentityInfo({super.key, required this.user});

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    final type = context.profileType;

    return Column(
      children: [
        const SizedBox(height: AppSpacing.md),
        Text(user?.name ?? 'Signed in', style: type.name),
        if (user != null) ...[
          const SizedBox(height: 4),
          Text(user!.email, style: type.contact),
          Text(user!.phone, style: type.contact),
        ],
        // The backend doesn't supply a join date yet, so this pill is
        // absent rather than showing an invented one — see UserModel
        // .memberSince.
        if (user?.memberSince != null) ...[
          const SizedBox(height: AppSpacing.sm),
          _MemberSincePill(since: user!.memberSince!),
        ],
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}

class _MemberSincePill extends StatelessWidget {
  const _MemberSincePill({required this.since});

  final DateTime since;

  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 6),
      decoration: BoxDecoration(
        color: AppPalette.secondary,
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 6,
            width: 6,
            decoration: BoxDecoration(color: cs.onPrimary, shape: BoxShape.circle),
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            'Member since ${_months[since.month - 1]} ${since.year}',
            style: context.profileType.memberSince.copyWith(color: cs.onPrimary),
          ),
        ],
      ),
    );
  }
}
