import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The pale plate, same-hue ink and 12% hairline behind a stock's initials
/// (Figma `Logo / …`, 38px, r12). The design tints each stock its own hue;
/// there are eight, picked by [_toneFor].
class StockLogo extends StatelessWidget {
  const StockLogo({super.key, required this.stock, required this.initials});

  final String stock;
  final String initials;

  @override
  Widget build(BuildContext context) {
    final tone = _toneFor(stock);
    return Container(
      height: 38,
      width: 38,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: tone.plate,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tone.ink.withValues(alpha: 0.12)),
      ),
      child: Text(
        initials,
        style: context.performanceType.logo.copyWith(color: tone.ink),
      ),
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
