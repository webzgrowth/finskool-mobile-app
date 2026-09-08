import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// Six single-digit boxes for entering a verification code, auto-advancing
/// focus forward on entry and back on backspace. Reports the combined code
/// via [onChanged] on every keystroke.
///
/// Each box is a true circle (`BoxShape.circle` on a square, fill-only
/// `Container`) with the `TextField` itself fully borderless — an
/// `OutlineInputBorder` radius on a non-square box, plus the global input
/// theme's own enabled/focused borders leaking through underneath it, is
/// what made an earlier version look like a blurry mismatched oval.
class OtpBoxes extends StatefulWidget {
  const OtpBoxes({super.key, required this.onChanged, this.length = 6});

  final ValueChanged<String> onChanged;
  final int length;

  static const double _boxSize = 46;

  @override
  State<OtpBoxes> createState() => _OtpBoxesState();
}

class _OtpBoxesState extends State<OtpBoxes> {
  late final _controllers =
      List.generate(widget.length, (_) => TextEditingController());
  late final _nodes = List.generate(widget.length, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final n in _nodes) {
      n.dispose();
    }
    super.dispose();
  }

  void _onDigit(int index, String value) {
    if (value.isNotEmpty && index < widget.length - 1) {
      _nodes[index + 1].requestFocus();
    }
    widget.onChanged(_controllers.map((c) => c.text).join());
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(widget.length, (i) {
        final filled = _controllers[i].text.isNotEmpty;
        return Container(
          height: OtpBoxes._boxSize,
          width: OtpBoxes._boxSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: filled ? AppPalette.headerGradientEnd : cs.surfaceContainerHighest,
          ),
          alignment: Alignment.center,
          child: KeyboardListener(
            focusNode: FocusNode(skipTraversal: true),
            onKeyEvent: (event) {
              if (event is KeyDownEvent &&
                  event.logicalKey == LogicalKeyboardKey.backspace &&
                  _controllers[i].text.isEmpty &&
                  i > 0) {
                _nodes[i - 1].requestFocus();
              }
            },
            child: TextField(
              controller: _controllers[i],
              focusNode: _nodes[i],
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              style:
                  inter(size: 20, weight: 400, height: 1, color: cs.onPrimary),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                counterText: '',
                filled: false,
                isCollapsed: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
              onChanged: (v) => setState(() => _onDigit(i, v)),
            ),
          ),
        );
      }),
    );
  }
}
