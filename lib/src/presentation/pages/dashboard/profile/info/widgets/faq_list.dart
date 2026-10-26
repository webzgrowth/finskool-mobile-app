import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/domain/model/profile/profile_info.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'info_blocks.dart';

/// Question rows that open one answer at a time. Which row is open is
/// transient UI state, so it's plain `State` here, not a bloc.
class FaqList extends StatefulWidget {
  const FaqList({super.key, required this.faqs});

  final List<Faq> faqs;

  @override
  State<FaqList> createState() => _FaqListState();
}

class _FaqListState extends State<FaqList> {
  int? _open;

  @override
  Widget build(BuildContext context) {
    final type = context.infoType;
    return InfoPlate(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          for (var i = 0; i < widget.faqs.length; i++) ...[
            if (i > 0) const InfoHairline(),
            InkWell(
              onTap: () => setState(() => _open = _open == i ? null : i),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.faqs[i].question,
                            style: type.rowTitle,
                          ),
                        ),
                        const SizedBox(width: 10),
                        AnimatedRotation(
                          turns: _open == i ? 0.25 : 0,
                          duration: const Duration(milliseconds: 200),
                          child: SvgPicture.asset(
                            'assets/icons/info_chevron.svg',
                            height: 14,
                            width: 14,
                          ),
                        ),
                      ],
                    ),
                    AnimatedSize(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      alignment: Alignment.topCenter,
                      child: _open == i
                          ? Padding(
                              padding: const EdgeInsets.only(top: 8, right: 24),
                              child: Text(
                                widget.faqs[i].answer,
                                style: type.rowSub.copyWith(height: 1.55),
                              ),
                            )
                          : const SizedBox(width: double.infinity),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
