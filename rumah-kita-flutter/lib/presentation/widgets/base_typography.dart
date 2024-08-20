import 'package:flutter/material.dart';

import '../../utils/themes.dart';

/// BaseTypography
///
/// Pre-configured Typography widget
class BaseTypography extends StatelessWidget {
  final String? _text;

  /// Options `h1`, `h2`, `h3`, `paragraph`, `label`,
  /// and `small`
  ///
  /// Type size `h1` = 32.0, `h2` = 24.0, `h3` = 18.0,
  /// `paragraph` = 18.0, `label` = 14.0, `small` = 12.0
  ///
  /// Can be override by providing fontSize
  /// argument
  ///
  /// If ignored it will use the default type
  /// `paragraph`
  final String? type;

  final int? maxLines;
  final TextOverflow? overflow;
  final bool softWrap;
  final TextAlign textAlign;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextDecoration? decoration;
  final double? letterSpacing;
  final double? height;
  final FontStyle? fontStyle;
  final double? stroke;
  final Color? strokeColor;

  /// Used along with RichText widget
  final List<InlineSpan>? children;

  const BaseTypography({
    super.key,
    required String text,
    this.type = 'paragraph',
    this.maxLines,
    this.overflow,
    this.softWrap = true,
    this.textAlign = TextAlign.start,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.decoration,
    this.letterSpacing,
    this.height,
    this.fontStyle,
    this.stroke,
    this.strokeColor = cBlack,
  })  : _text = text,
        children = null;

  const BaseTypography.richText({
    super.key,
    this.type = 'paragraph',
    this.maxLines,
    this.overflow,
    this.softWrap = true,
    this.textAlign = TextAlign.start,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.decoration,
    this.letterSpacing,
    this.height,
    this.fontStyle,
    required this.children,
  })  : stroke = null,
        strokeColor = null,
        _text = null;

  double _fontSize() {
    if (fontSize != null) {
      return fontSize!;
    }

    switch (type) {
      case 'h1':
        return fHeadline1;
      case 'h2':
        return fHeadline2;
      case 'h3':
        return fHeadline3;
      case 'paragraph':
        return fParagraph;
      case 'label':
        return fLabel;
      case 'small':
        return fSmall;
      default:
        return fParagraph;
    }
  }

  Paint _paintStroke() {
    return Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke!
      ..color = strokeColor!;
  }

  // If `strokeMode` true, TextStyle will be
  // rendered as stroke
  TextStyle _textStyle([bool strokeMode = false]) {
    return TextStyle(
      fontSize: _fontSize(),
      color: strokeMode ? null : color,
      fontWeight: fontWeight,
      decoration: decoration,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
      height: height,
      foreground: strokeMode ? _paintStroke() : null,
    );
  }

  dynamic _content() {
    if (children != null) {
      return TextSpan(
        style: _textStyle(),
        children: children,
      );
    }

    return _text;
  }

  Widget _textWidget() {
    if (stroke != null) {
      return Stack(
        children: [
          // Stroked text as border
          Text(
            _content(),
            maxLines: maxLines,
            overflow: overflow,
            softWrap: softWrap,
            textAlign: textAlign,
            style: _textStyle(true),
          ),
          // Solid text as fill
          Text(
            _content(),
            maxLines: maxLines,
            overflow: overflow,
            softWrap: softWrap,
            textAlign: textAlign,
            style: _textStyle(),
          ),
        ],
      );
    }

    return Text(
      _content(),
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      textAlign: textAlign,
      style: _textStyle(),
    );
  }

  Widget _richTextWidget() {
    return RichText(
      text: _content(),
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.clip,
      softWrap: softWrap,
      textAlign: textAlign,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (children != null) {
      return _richTextWidget();
    } else {
      return _textWidget();
    }
  }
}
