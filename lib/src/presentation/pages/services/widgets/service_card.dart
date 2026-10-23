import 'package:flutter/material.dart';
import 'package:finskool/src/domain/model/service/service_model.dart';
import 'package:finskool/src/presentation/pages/communities/widgets/announcement_tag.dart';
import 'package:finskool/src/presentation/pages/communities/widgets/community_cta_button.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'service_cover.dart';

/// One service in the catalog — Figma's card (`Services Screen`), built on
/// the Communities card's chrome: white, r20, the same soft shadow.
///
/// A service has no price: "Pricing on request" is true of every one, because
/// the support team quotes in chat. The category line, price chips and "What
/// You Get" panel Figma draws have no backing field — see [ServiceModel].
class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
    required this.service,
    required this.onEnquire,
    this.loading = false,
    this.hasOpenRequest = false,
  });

  final ServiceModel service;

  /// Either starts a new enquiry or opens the existing one — which, is the
  /// caller's call based on [hasOpenRequest]. Kept as one callback rather
  /// than two so the button itself stays a single tap target either way.
  final VoidCallback onEnquire;
  final bool loading;

  /// True once the member already has an open request for this service —
  /// the CTA then reads "View request" and reopens that conversation
  /// instead of starting a second one (the backend would 409 anyway; this
  /// just means the member never has to find that out).
  final bool hasOpenRequest;

  @override
  Widget build(BuildContext context) {
    final type = context.communityType;
    return Container(
      margin: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        0,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: context.gradients.feedCard,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ServiceCover(imageUrl: service.imageUrl, id: service.id),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.sm,
                AppSpacing.md,
                AppSpacing.md,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.centerRight,
                    child: AnnouncementTag(label: 'Pricing on request'),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(service.title, style: type.title),
                  if (service.description.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Text(service.description, style: type.description),
                  ],
                  const SizedBox(height: AppSpacing.lg),
                  CommunityCtaButton(
                    label: hasOpenRequest ? 'View request' : 'Enquire now',
                    loading: loading,
                    onPressed: onEnquire,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
