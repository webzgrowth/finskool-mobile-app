import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The input surface: the card's own `#F6F6F6`, a 1px `#7D7D91` @60% border, r=4.
///
/// The border turns `#108B8B` when focused (Figma shows it on Description)
/// and red when the field has an error. It is drawn **here**, around a
/// borderless `TextField`, rather than through `InputDecoration`: the global
/// input theme defines a border per state, and each one overrides a plain
/// `border: InputBorder.none` (CLAUDE.md, "wrapping a TextField").
class TicketFieldShell extends StatelessWidget {
  const TicketFieldShell({
    super.key,
    required this.child,
    this.focused = false,
    this.hasError = false,
    this.height,
    this.padding = const EdgeInsets.symmetric(horizontal: 10),
  });

  final Widget child;
  final bool focused;
  final bool hasError;
  final double? height;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final border = hasError
        ? AppPalette.ticketRed
        : focused
        ? AppPalette.badgeTeal
        : AppPalette.ticketFieldBorder;
    return Container(
      height: height,
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: AppPalette.ticketCard,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: border),
      ),
      child: child,
    );
  }
}

/// The error line under a field. Not in the design — Figma draws the
/// success state only — so it borrows the asterisk's red at hint size.
class TicketFieldError extends StatelessWidget {
  const TicketFieldError(this.message, {super.key});

  final String? message;

  @override
  Widget build(BuildContext context) {
    if (message == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Text(message!, style: context.ticketType.fieldError),
    );
  }
}

/// A `TextField` stripped of every per-state border, for use inside
/// [TicketFieldShell].
InputDecoration ticketBareDecoration(String? hint, TextStyle hintStyle) =>
    InputDecoration(
      isCollapsed: true,
      // `isCollapsed` alone does NOT zero this: the global input theme sets
      // `contentPadding: 16`, and `InputDecoration.applyDefaults` merges it
      // over a collapsed decoration, silently adding 16pt of padding to
      // every side of the field.
      contentPadding: EdgeInsets.zero,
      hintText: hint,
      hintStyle: hintStyle,
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      filled: false,
    );
