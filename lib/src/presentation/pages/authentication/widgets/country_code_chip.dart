import 'package:flutter/material.dart';
import 'package:finskool/src/comman/country_codes.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'country_picker_sheet.dart';

/// The tappable flag + dial-code segment of [PhoneField]. Opens
/// [showCountryPicker] rather than being a hardcoded "+91" label.
class CountryCodeChip extends StatelessWidget {
  const CountryCodeChip({
    super.key,
    required this.country,
    required this.onCountryChanged,
  });

  final Country country;
  final ValueChanged<String> onCountryChanged;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () async {
        final picked = await showCountryPicker(context);
        if (picked != null) onCountryChanged(picked.dialCode);
      },
      child: Container(
        width: 72,
        color: AppPalette.headerGradientEnd,
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(country.flag, style: const TextStyle(fontSize: 14)),
            const SizedBox(width: 2),
            Text(country.dialCode,
                style: tt.labelSmall?.copyWith(color: cs.onPrimary)),
            Icon(Icons.arrow_drop_down, size: 14, color: cs.onPrimary),
          ],
        ),
      ),
    );
  }
}
