import 'package:flutter/material.dart';

import '../../utils/themes.dart';
import 'base_typography.dart';

/// StatusCard
class StatusCard extends StatelessWidget {
  /// 'normal' and 'small'
  final String variant;
  final String status;
  final String label;

  const StatusCard({
    super.key,
    this.variant = 'normal',
    required this.status,
    required this.label,
  });

  Color _color() {
    if (status == 'pending') {
      return cOrange;
    } else if (status == 'processing') {
      return cBlue;
    } else if (status == 'approved') {
      return cGreen;
    } else if (status == 'rejected') {
      return cRed;
    }

    return cBlack;
  }

  IconData? _iconData() {
    if (status == 'pending') {
      return Icons.access_time_filled_rounded;
    } else if (status == 'processing') {
      return Icons.wifi_protected_setup_rounded;
    } else if (status == 'approved') {
      return Icons.check_circle_rounded;
    } else if (status == 'rejected') {
      return Icons.remove_circle_rounded;
    }

    return null;
  }

  EdgeInsetsGeometry _padding() {
    if (variant == 'small') {
      return const EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 16.0,
      );
    }

    return const EdgeInsets.symmetric(
      vertical: 12.0,
      horizontal: 16.0,
    );
  }

  double _fontSize() {
    if (variant == 'small') {
      return fLabel;
    }

    return fParagraph;
  }

  double _iconSize() {
    if (variant == 'small') {
      return 16.0;
    }

    return 24.0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _padding(),
      decoration: BoxDecoration(
        color: _color(),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: BaseTypography(
              text: label,
              color: cWhite,
              fontSize: _fontSize(),
            ),
          ),
          const SizedBox(width: 12.0),
          Icon(
            _iconData(),
            color: cWhite,
            size: _iconSize(),
          )
        ],
      ),
    );
  }
}
