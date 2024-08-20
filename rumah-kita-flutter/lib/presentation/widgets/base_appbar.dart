import 'package:flutter/material.dart';

import '../../utils/themes.dart';

/// BaseAppBar
///
/// Pre-configured AppBar
class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;
  final Widget? child;

  const BaseAppBar({
    super.key,
    this.backgroundColor,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 0.0,
        horizontal: 12.0,
      ),
      height: preferredSize.height,
      color: backgroundColor,
      child: child,
    );
  }

  @override
  get preferredSize => const Size.fromHeight(80);
}

/// RumahKitaAppBar
///
/// RumahKita custom AppBar
class RumahKitaAppBar extends BaseAppBar {
  /// Widgets to be placed on the left side
  final List<Widget>? left;

  /// Widgets to be placed on the middle
  final List<Widget>? middle;

  /// Widgets to be placed on the right side
  final List<Widget>? right;

  const RumahKitaAppBar({
    super.key,
    this.left,
    this.middle,
    this.right,
    super.backgroundColor = cTransparent,
  });

  @override
  Widget build(BuildContext context) {
    return BaseAppBar(
      backgroundColor: super.backgroundColor,
      child: Row(
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
    );
  }
}
