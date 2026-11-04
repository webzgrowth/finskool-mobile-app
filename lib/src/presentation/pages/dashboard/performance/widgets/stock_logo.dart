import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// A stock's mark: its **logo** when the server has one ([logoUrl]), otherwise
/// the pale plate, same-hue ink and 12% hairline behind its initials (Figma
/// `Logo / …`, 38px, r12; the design tints each stock its own hue — eight,
/// picked by [_toneFor]).
///
/// Same 38px footprint either way. The logo is scaled to fit (`contain`) on a
/// white plate so a wide one isn't cropped, and the initials show while it
/// loads and if it fails — a broken URL must never draw a broken image. A null
/// [logoUrl] is normal (the stock isn't in the server's table), not an error.
class StockLogo extends StatelessWidget {
  const StockLogo({
    super.key,
    required this.stock,
    required this.initials,
    this.logoUrl,
  });

  final String stock;
  final String initials;
  final String? logoUrl;

  @override
  Widget build(BuildContext context) {
    final tone = _toneFor(stock);
    final fallback = Text(
      initials,
      style: context.performanceType.logo.copyWith(color: tone.ink),
    );
    final url = logoUrl;
    final hasLogo = url != null && url.isNotEmpty;
    return Container(
      height: 38,
      width: 38,
      alignment: Alignment.center,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: hasLogo ? AppPalette.white : tone.plate,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tone.ink.withValues(alpha: 0.12)),
      ),
      child: hasLogo
          ? Padding(
              padding: const EdgeInsets.all(4),
              // Cached by URL, so a row scrolled back into view doesn't refetch.
              child: CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.contain,
                placeholder: (_, _) => fallback,
                errorWidget: (_, _, _) => fallback,
              ),
            )
          : fallback,
    );
  }
}

typedef _Tone = ({Color ink, Color plate});

const _tones = <_Tone>[
  (ink: AppPalette.logoRedInk, plate: AppPalette.logoRedPlate),
  (ink: AppPalette.logoPurpleInk, plate: AppPalette.logoPurplePlate),
  (ink: AppPalette.logoIndigoInk, plate: AppPalette.logoIndigoPlate),
  (ink: AppPalette.logoAmberInk, plate: AppPalette.logoAmberPlate),
  (ink: AppPalette.logoGreenInk, plate: AppPalette.logoGreenPlate),
  (ink: AppPalette.logoOrangeInk, plate: AppPalette.logoOrangePlate),
  (ink: AppPalette.logoTealInk, plate: AppPalette.logoTealPlate),
  (ink: AppPalette.logoBlueInk, plate: AppPalette.logoBluePlate),
];

// Indices into [_tones] for the stocks Figma colours by hand. Anything else
// gets a stable hash, so a real feed still gets consistent colours.
const _byStock = <String, int>{
  'Muthoot Finance': 0, 'Paradeep Phosphate': 1, 'Hindustan Zinc': 2,
  'Adani Port': 2, 'Netweb Tech': 3, 'HBL Engine': 0, 'Lodha Developers': 3,
  'LTM': 4, 'Waaree Energies': 5, 'Bank of Maharastra': 4, 'SONACOM': 6,
  'GODFREYPHILLIP': 2, 'Sun Pharmaceutical': 3, 'MCX': 6, 'Hitachi Energy': 0,
  'Blue Star': 2, 'Asian Paints': 7, 'Coforge': 4, 'Ambuja Cement': 0,
  'CAMS': 0, 'Radico Khaitan': 2, 'IEX': 1, 'Bank of Baroda': 2,
  'LIC Housing Finance': 3, 'Astral': 5, 'Yes Bank': 4, //
};

_Tone _toneFor(String stock) {
  final i =
      _byStock[stock] ??
      stock.codeUnits.fold<int>(0, (a, c) => a + c) % _tones.length;
  return _tones[i];
}
