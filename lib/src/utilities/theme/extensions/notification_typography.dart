import 'package:flutter/material.dart';

import '../text/text_style_factory.dart';
import '../tokens/app_palette.dart';

TextStyle _i(double size, double weight, double height, Color color) => inter(
  size: size,
  weight: weight,
  height: height,
  color: color,
).copyWith(letterSpacing: 0);

/// Type for a notification card, measured from the Final page's
/// "App notifications" frame (`1629:2132`): the OS-style card used by the
/// in-app banner and the inbox rows. Light only.
@immutable
class NotificationTypography extends ThemeExtension<NotificationTypography> {
  const NotificationTypography({
    required this.appName,
    required this.time,
    required this.title,
    required this.body,
    required this.empty,
  });

  /// "FINSKOOL21" — Inter 600 · 11 at +3% tracking.
  final TextStyle appName;
  final TextStyle time;
  final TextStyle title;
  final TextStyle body;
  final TextStyle empty;

  static final NotificationTypography light = NotificationTypography(
    appName: _i(
      11,
      600,
      13 / 11,
      AppPalette.notificationMeta,
    ).copyWith(letterSpacing: 0.33),
    time: _i(11.5, 400, 14 / 11.5, AppPalette.notificationTime),
    title: _i(14, 600, 19 / 14, AppPalette.notificationTitle),
    body: _i(13, 400, 18 / 13, AppPalette.notificationBody),
    empty: _i(13, 400, 19 / 13, AppPalette.perfMuted),
  );

  static NotificationTypography of(Brightness _) => light;

  @override
  NotificationTypography copyWith() => this;

  @override
  NotificationTypography lerp(
    ThemeExtension<NotificationTypography>? other,
    double t,
  ) => this;
}

extension NotificationTypographyX on BuildContext {
  NotificationTypography get notificationType =>
      Theme.of(this).extension<NotificationTypography>()!;
}
