import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/domain/model/profile/profile_info.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'info_actions.dart';
import 'info_blocks.dart';

/// The registration card at the top of About & SEBI info — brand, the SEBI
/// number with a Verified pill and a copy button, then who holds it.
class SebiHeroCard extends StatelessWidget {
  const SebiHeroCard({super.key, required this.info});

  final SebiInfo info;

  @override
  Widget build(BuildContext context) {
    final type = context.infoType;
    return InfoPlate(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 48,
                width: 48,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: AppPalette.white,
                  shape: BoxShape.circle,
                ),
                child: Image.asset('assets/images/logo.png', fit: BoxFit.cover),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(info.brandName, style: type.brandName),
                    Text(info.role, style: type.brandMeta),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Text(
                  'SEBI REGISTRATION NO.',
                  style: type.eyebrow.copyWith(letterSpacing: 0.6),
                ),
              ),
              const _VerifiedPill(),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(child: Text(info.registrationNo, style: type.regNumber)),
              _CopyButton(
                onTap: () => copyToClipboard(
                  context,
                  info.registrationNo,
                  'Registration number copied',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const InfoHairline(),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _Detail(
                  label: 'Research analyst',
                  value: info.analystName,
                ),
              ),
              Expanded(
                child: _Detail(label: 'Designation', value: info.designation),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Detail extends StatelessWidget {
  const _Detail({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final type = context.infoType;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: type.detailLabel),
        const SizedBox(height: 4),
        Text(value, style: type.detailValue),
      ],
    );
  }
}

class _VerifiedPill extends StatelessWidget {
  const _VerifiedPill();

  @override
  Widget build(BuildContext context) => Container(
    height: 23,
    padding: const EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
      color: AppPalette.infoVerifiedPlate,
      borderRadius: BorderRadius.circular(AppRadii.pill),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          'assets/icons/info_verified.svg',
          height: 12,
          width: 12,
        ),
        const SizedBox(width: 5),
        Text('Verified', style: context.infoType.verified),
      ],
    ),
  );
}

class _CopyButton extends StatelessWidget {
  const _CopyButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: 'Copy registration number',
    child: GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 34,
        width: 34,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppPalette.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SvgPicture.asset(
          'assets/icons/sub_copy.svg',
          height: 14,
          width: 14,
          colorFilter: const ColorFilter.mode(
            AppPalette.cardTitle,
            BlendMode.srcIn,
          ),
        ),
      ),
    ),
  );
}
