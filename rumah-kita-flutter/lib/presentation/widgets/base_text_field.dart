import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/themes.dart';

enum _TextFieldType {
  simple,
  outlined,
}

extension _TextFieldTypeX on _TextFieldType {
  bool get isSimple => this == _TextFieldType.simple;
  bool get isOutlined => this == _TextFieldType.outlined;
}

/// BaseTextField
///
/// Pre-configured TextField widget
class BaseTextField extends StatelessWidget {
  final _TextFieldType _type;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? label;
  final double? labelFontSize;
  final Color? labelColor;
  final double? inputFontSize;
  final bool? enabled;
  final TextInputType? keyboardType;
  final int? maxLines;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final String? hintText;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final bool? filled;
  final Color? fillColor;

  const BaseTextField({
    super.key,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.label,
    this.labelFontSize,
    this.labelColor,
    this.inputFontSize,
    this.enabled,
    this.keyboardType,
    this.maxLines,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.hintText,
    this.errorText,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding,
    this.filled,
    this.fillColor,
  }) : _type = _TextFieldType.simple;

  const BaseTextField.outlined({
    super.key,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.label,
    this.labelFontSize,
    this.labelColor,
    this.inputFontSize,
    this.enabled,
    this.keyboardType,
    this.maxLines,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.hintText,
    this.errorText,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding,
  })  : _type = _TextFieldType.outlined,
        filled = false,
        fillColor = null;

  Widget _labelWidget() {
    if (label == null) {
      return const SizedBox.shrink();
    }

    late double height = 8.0;

    return Column(
      children: [
        Text(
          label!,
          style: TextStyle(
            fontSize: labelFontSize ?? fParagraph,
            color: labelColor ?? cWhite,
            fontWeight: fBold,
          ),
        ),
        SizedBox(height: height),
      ],
    );
  }

  InputBorder? _inputBorder() {
    if (_type.isSimple) {
      return const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
        borderSide: BorderSide.none,
      );
    } else if (_type.isOutlined) {
      return const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
        borderSide: BorderSide(
          color: cWhite,
        ),
      );
    }

    return null;
  }

  InputBorder? _inputFocusBorder() {
    if (_type.isSimple) {
      return const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
        borderSide: BorderSide.none,
      );
    } else if (_type.isOutlined) {
      return const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
        borderSide: BorderSide(
          color: cBlue,
        ),
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _labelWidget(),
        TextField(
          controller: controller,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          enabled: enabled,
          keyboardType: keyboardType,
          maxLines: maxLines,
          obscureText: obscureText,
          obscuringCharacter: '●',
          textAlignVertical: TextAlignVertical.center,
          textCapitalization: textCapitalization,
          textInputAction: textInputAction,
          inputFormatters: inputFormatters,
          style: TextStyle(
            fontSize: inputFontSize ?? fParagraph,
            letterSpacing: 0.5,
          ),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: contentPadding,
            filled: filled,
            fillColor: fillColor,
            border: _inputBorder(),
            focusedBorder: _inputFocusBorder(),
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: inputFontSize ?? fParagraph,
            ),
            errorText: errorText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
