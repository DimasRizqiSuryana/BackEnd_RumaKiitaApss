import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/themes.dart';

enum _DropdownMenuType {
  simple,
  outlined,
}

extension _DropdownMenuTypeX on _DropdownMenuType {
  bool get isSimple => this == _DropdownMenuType.simple;
  bool get isOutlined => this == _DropdownMenuType.outlined;
}

/// BaseDropdownMenu
///
/// Pre-configured BaseDropdownMenu widget
class BaseDropdownMenu<T> extends StatelessWidget {
  final _DropdownMenuType _type;
  final TextEditingController? controller;
  final ValueChanged<T?>? onSelected;
  final String? label;
  final double? labelFontSize;
  final Color? labelColor;
  final double? inputFontSize;
  final bool enabled;
  final bool enableFilter;
  final bool enableSearch;
  final SearchCallback<T>? searchCallback;
  final bool? requestFocusOnTap;
  final String? hintText;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final EdgeInsetsGeometry? contentPadding;
  final bool filled;
  final Color? fillColor;
  final T? initialSelection;
  final List<DropdownMenuEntry<T>> dropdownMenuEntries;

  const BaseDropdownMenu({
    super.key,
    this.controller,
    this.onSelected,
    this.label,
    this.labelFontSize,
    this.labelColor,
    this.inputFontSize,
    this.enabled = true,
    this.enableFilter = false,
    this.enableSearch = true,
    this.searchCallback,
    this.requestFocusOnTap,
    this.hintText,
    this.errorText,
    this.inputFormatters,
    this.leadingIcon,
    this.trailingIcon,
    this.contentPadding,
    this.filled = false,
    this.fillColor,
    this.initialSelection,
    required this.dropdownMenuEntries,
  }) : _type = _DropdownMenuType.simple;

  const BaseDropdownMenu.outlined({
    super.key,
    this.controller,
    this.onSelected,
    this.label,
    this.labelFontSize,
    this.labelColor,
    this.inputFontSize,
    this.enabled = true,
    this.enableFilter = false,
    this.enableSearch = true,
    this.searchCallback,
    this.requestFocusOnTap,
    this.hintText,
    this.errorText,
    this.inputFormatters,
    this.leadingIcon,
    this.trailingIcon,
    this.contentPadding,
    this.initialSelection,
    required this.dropdownMenuEntries,
  })  : _type = _DropdownMenuType.outlined,
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
            color: labelColor ?? cBlack,
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
          color: cBlack,
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
        DropdownMenu<T>(
          controller: controller,
          onSelected: onSelected,
          expandedInsets: EdgeInsets.zero,
          enabled: enabled,
          enableFilter: enableFilter,
          enableSearch: enableSearch,
          requestFocusOnTap: requestFocusOnTap,
          leadingIcon: leadingIcon,
          trailingIcon: trailingIcon,
          errorText: errorText,
          inputDecorationTheme: InputDecorationTheme(
            isDense: true,
            contentPadding: contentPadding,
            filled: filled,
            fillColor: fillColor,
            border: _inputBorder(),
            focusedBorder: _inputFocusBorder(),
            hintStyle: TextStyle(
              fontSize: inputFontSize ?? fParagraph,
            ),
          ),
          hintText: hintText,
          inputFormatters: inputFormatters,
          textStyle: TextStyle(
            fontSize: inputFontSize ?? fParagraph,
            letterSpacing: 0.5,
          ),
          initialSelection: initialSelection,
          dropdownMenuEntries: dropdownMenuEntries,
        )
      ],
    );
  }
}
