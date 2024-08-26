import 'package:flutter/widgets.dart';

import '../../utils/themes.dart';
import 'base_typography.dart';

class ListItem extends StatelessWidget {
  final String label;
  final int? labelFlex;
  final String value;
  final int? valueFlex;

  const ListItem({
    // ignore: unused_element
    super.key,
    required this.label,
    this.labelFlex,
    required this.value,
    this.valueFlex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: labelFlex ?? 3,
          child: BaseTypography(
            text: label,
            type: 'label',
            color: cBlack,
          ),
        ),
        Expanded(
          flex: valueFlex ?? 9,
          child: BaseTypography(
            text: value,
            type: 'label',
            color: cTeal,
            fontWeight: fBold,
          ),
        ),
      ],
    );
  }
}
