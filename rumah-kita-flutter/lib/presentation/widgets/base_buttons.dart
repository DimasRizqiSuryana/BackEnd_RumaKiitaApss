import 'package:flutter/material.dart';

import '../../utils/themes.dart';

/// BaseElevatedButton
///
/// Pre-configured TextButton widget
class BaseElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final EdgeInsets? padding;
  final double? borderRadius;
  final TextDecoration? decoration;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final String? label;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? shadowColor;
  final Widget? child;

  const BaseElevatedButton({
    super.key,
    this.onPressed,
    this.padding = const EdgeInsets.symmetric(
      vertical: 16.0,
      horizontal: 16.0,
    ),
    this.borderRadius,
    this.label = 'Label',
    this.decoration = TextDecoration.none,
    this.foregroundColor,
    this.backgroundColor,
    this.fontSize = fParagraph,
    this.fontWeight = fBold,
    this.shadowColor,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? 16.0,
          ),
        ),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        elevation: 0,
        shadowColor: shadowColor,
      ),
      child: child ??
          Text(
            label!,
            style: TextStyle(
              decoration: decoration,
              fontWeight: fontWeight,
              fontSize: fontSize,
            ),
          ),
    );
  }
}
