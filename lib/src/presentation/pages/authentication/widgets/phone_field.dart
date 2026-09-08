import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter;
import 'package:finskool/src/comman/country_codes.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'field_label.dart';
import 'auth_field_icons.dart';
import 'country_code_chip.dart';
import 'phone_input_decoration.dart';

/// Phone number field with a working country-code segment: the teal block
/// spans the full field height and shares the field's own border/radius,
/// matching the Sign up screen design.
class PhoneField extends StatelessWidget {
  const PhoneField({
    super.key,
    required this.countryCode,
    required this.onChanged,
    required this.onCountryChanged,
    this.errorText,
  });

  static const double _fieldHeight = 44;

  final String countryCode;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onCountryChanged;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    final borderColor = errorText == null ? cs.outlineVariant : cs.error;
    final country = CountryCodes.byDialCode(countryCode);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FieldLabel(iconAsset: AuthFieldIcons.phone, label: 'Phone Number'),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: _fieldHeight,
          child: Stack(
            children: [
              // Fill goes edge-to-edge with the clip so there's no inset
              // gap at the corners (a Container that clips its own
              // bordered decoration leaves a thin rounded sliver there).
              ClipRRect(
                borderRadius: AppRadii.medium,
                child: Row(
                  children: [
                    CountryCodeChip(
                      country: country,
                      onCountryChanged: onCountryChanged,
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: onChanged,
                        keyboardType: TextInputType.phone,
                        style: tt.bodyLarge,
                        maxLength: country.digits,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: phoneInputDecoration(tt),
                      ),
                    ),
                  ],
                ),
              ),
              // Border drawn on top, so it isn't affected by the clip inset.
              Positioned.fill(
                child: IgnorePointer(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: borderColor),
                      borderRadius: AppRadii.medium,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(errorText!, style: tt.bodySmall?.copyWith(color: cs.error)),
        ],
      ],
    );
  }
}
