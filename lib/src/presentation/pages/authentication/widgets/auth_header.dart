import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:finskool/src/utilities/theme/theme.dart';
import 'auth_header_glow.dart';
import 'auth_header_subtitle.dart';

/// Gradient hero header shared by the Login and Sign up screens.
class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitleSpans,
  });

  final String title;
  final List<TextSpan> subtitleSpans;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    // Status bar height differs across iOS (notch/Dynamic Island) and
    // Android devices, so read it from MediaQuery instead of a fixed value.
    final topInset = MediaQuery.paddingOf(context).top;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        topInset + AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.xxl + AppSpacing.xl,
      ),
      decoration: const BoxDecoration(
        // Exact Figma "Star" layer (gradient + grid + stars baked in) —
        // exported straight from the design rather than hand-approximated,
        // so the grid matches pixel-for-pixel.
        image: DecorationImage(
          image: AssetImage('assets/images/auth_header_bg.png'),
          fit: BoxFit.cover,
          // Anchor to the top of the source image — the default `center`
          // alignment was cropping into the middle of the gradient and
          // skipping the darker green Figma shows at the very top.
          alignment: Alignment.topCenter,
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: -40,
            top: -60,
            child: AuthHeaderGlow(color: Colors.white.withValues(alpha: 0.12)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                clipBehavior: Clip.antiAlias,
                child:
                    Image.asset('assets/images/logo.png', fit: BoxFit.cover),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                title,
                style: tt.headlineLarge?.copyWith(color: Colors.white),
              ),
              const SizedBox(height: AppSpacing.xs),
              AuthHeaderSubtitle(spans: subtitleSpans),
            ],
          ),
        ],
      ),
    );
  }
}
