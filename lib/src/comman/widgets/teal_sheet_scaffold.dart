import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The teal-grid-behind-a-white-sheet chrome shared by the Subscription
/// Detail and Edit Profile screens.
///
/// Deliberately not a Material `AppBar`: the grid bleeds behind the status
/// bar and the content rides a white sheet with rounded top corners, so
/// each screen puts its own back arrow inside [children] rather than in a
/// leading slot. Same reason `AuthHeader`/`AuthCard` avoid `SafeArea` —
/// insetting here would cut the gradient short.
class TealSheetScaffold extends StatelessWidget {
  const TealSheetScaffold({super.key, required this.children});

  final List<Widget> children;

  /// How far the white sheet starts below the status bar.
  static const double _sheetTop = 40;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final topInset = MediaQuery.paddingOf(context).top;
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppPalette.secondary,
        body: Stack(
          children: [
            SizedBox(
              height: topInset + 160,
              width: double.infinity,
              child: Image.asset(
                'assets/images/auth_header_bg.png',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: topInset + _sheetTop),
              child: Container(
                decoration: BoxDecoration(
                  color: cs.surface,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(AppRadii.lg),
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: ListView(
                      padding: EdgeInsets.fromLTRB(
                        AppSpacing.lg,
                        AppSpacing.md,
                        AppSpacing.lg,
                        AppSpacing.xl + bottomInset,
                      ),
                      children: children,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The back arrow both sheet screens put at the top of their content.
class SheetBackArrow extends StatelessWidget {
  const SheetBackArrow({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: AppSpacing.xs),
          child: Icon(Icons.arrow_back, size: 20, color: AppPalette.primary),
        ),
      ),
    );
  }
}
