import 'package:flutter/material.dart';
import 'package:finskool/src/comman/country_codes.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// Searchable bottom sheet for picking a country dial code.
Future<Country?> showCountryPicker(BuildContext context) {
  return showModalBottomSheet<Country>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const _CountryPickerSheet(),
  );
}

class _CountryPickerSheet extends StatefulWidget {
  const _CountryPickerSheet();

  @override
  State<_CountryPickerSheet> createState() => _CountryPickerSheetState();
}

class _CountryPickerSheetState extends State<_CountryPickerSheet> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final results = CountryCodes.all
        .where((c) =>
            c.name.toLowerCase().contains(_query.toLowerCase()) ||
            c.dialCode.contains(_query))
        .toList();

    return Container(
      height: MediaQuery.sizeOf(context).height * 0.7,
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: AppRadii.sheet,
      ),
      // SafeArea goes around the content, not the whole sheet — wrapping
      // the Container itself shrinks it away from the true bottom edge.
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.sm),
            Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: cs.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: TextField(
                autofocus: true,
                onChanged: (v) => setState(() => _query = v),
                decoration: const InputDecoration(
                  hintText: 'Search country or code',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: results.length,
                separatorBuilder: (_, _) => Divider(
                  height: 1,
                  color: cs.outlineVariant,
                ),
                itemBuilder: (context, index) {
                  final country = results[index];
                  return ListTile(
                    leading: Text(country.flag,
                        style: const TextStyle(fontSize: 22)),
                    title: Text(country.name, style: tt.bodyLarge),
                    trailing: Text(country.dialCode, style: tt.titleSmall),
                    onTap: () => Navigator.of(context).pop(country),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
