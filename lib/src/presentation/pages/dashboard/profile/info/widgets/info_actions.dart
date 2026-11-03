import 'package:finskool/src/comman/widgets/app_snack.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens [uri] outside the app (`tel:`, `mailto:`, maps, a web page); says so
/// in a snackbar when the device has nothing to handle it — an emulator with
/// no dialer, say — rather than a silent dead tap.
Future<void> openExternal(BuildContext context, String uri) async {
  var opened = false;
  try {
    opened = await launchUrl(
      Uri.parse(uri),
      mode: LaunchMode.externalApplication,
    );
  } catch (_) {}
  if (!opened) {
    AppSnack.show('Could not open that.');
  }
}

Future<void> copyToClipboard(
  BuildContext context,
  String text,
  String confirmation,
) async {
  await Clipboard.setData(ClipboardData(text: text));
  HapticFeedback.selectionClick();
  AppSnack.show(confirmation);
}
