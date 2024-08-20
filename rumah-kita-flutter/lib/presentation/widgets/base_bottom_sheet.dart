import 'package:flutter/material.dart';

import '../../utils/themes.dart';

/// BottomSheetAppBar
///
/// Pre-configured AppBar for BottomSheet widget
class BottomSheetAppBar extends StatelessWidget {
  /// Widgets to be placed on the left side
  final List<Widget>? left;

  /// Widgets to be placed on the middle
  final List<Widget>? middle;

  /// Widgets to be placed on the right side
  final List<Widget>? right;

  final Color? backgroundColor;

  const BottomSheetAppBar({
    super.key,
    this.left,
    this.middle,
    this.right,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 12.0,
        left: 12.0,
        right: 12.0,
        bottom: 8.0,
      ),
      color: backgroundColor,
      child: Column(
        children: [
          Center(
            child: Container(
              height: 6.0,
              width: 64.0,
              decoration: BoxDecoration(
                color: cDeepBlue,
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: left != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: left!,
                      )
                    : const SizedBox.shrink(),
              ),
              middle != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: middle!,
                    )
                  : const SizedBox.shrink(),
              Expanded(
                flex: 1,
                child: right != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: right!,
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
