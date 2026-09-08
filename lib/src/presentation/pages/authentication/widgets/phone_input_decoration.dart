import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The borderless decoration for the digits half of [PhoneField].
///
/// The global input theme separately defines enabledBorder/focusedBorder/
/// errorBorder, which override a plain `border: InputBorder.none` in their
/// own states — so each must be cleared explicitly, or the field draws its
/// own rounded outline right where it meets the country chip.
InputDecoration phoneInputDecoration(TextTheme tt) => InputDecoration(
      hintText: 'Enter your phone number',
      hintStyle: tt.bodySmall,
      filled: false,
      counterText: '',
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: 12,
      ),
    );
