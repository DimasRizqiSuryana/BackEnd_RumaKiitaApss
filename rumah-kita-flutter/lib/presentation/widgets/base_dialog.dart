import 'package:flutter/material.dart';

import '../../utils/themes.dart';
import 'base_buttons.dart';
import 'base_typography.dart';

// Internal dialog types
enum _DialogType {
  simple,
  confirm,
  strictConfirm,
}

extension _DialogTypeX on _DialogType {
  bool get isSimple => this == _DialogType.simple;
  bool get isConfirm => this == _DialogType.confirm;
  bool get isStrictConfirm => this == _DialogType.strictConfirm;
}

/// BaseDialog
///
/// Pre-configured SimpleDialog widget
///
/// Constructor variants :
/// - `BaseDialog()`
/// - `BaseDialog.confirm()`
/// - `BaseDialog.strictConfirm()`
class BaseDialog extends StatelessWidget {
  final _DialogType _type;
  final dynamic Function()? onConfirm;
  final dynamic Function()? onCancel;
  final String? confirmLabel;
  final String? cancelLabel;
  final EdgeInsetsGeometry? contentPadding;
  final Color? foregroundColor;
  final List<Widget>? children;

  const BaseDialog({
    super.key,
    this.contentPadding,
    this.children,
  })  : _type = _DialogType.simple,
        onConfirm = null,
        onCancel = null,
        confirmLabel = null,
        cancelLabel = null,
        foregroundColor = null;

  const BaseDialog.confirm({
    super.key,
    this.onConfirm,
    this.confirmLabel,
    this.contentPadding,
    this.foregroundColor,
    this.children,
  })  : _type = _DialogType.confirm,
        onCancel = null,
        cancelLabel = null;

  const BaseDialog.strictConfirm({
    super.key,
    this.onConfirm,
    this.onCancel,
    this.confirmLabel,
    this.cancelLabel,
    this.contentPadding,
    this.foregroundColor,
    this.children,
  }) : _type = _DialogType.strictConfirm;

  List<Widget> _confirmActionWidget() {
    if (_type.isConfirm) {
      return [
        Expanded(
          child: BaseElevatedButton(
            onPressed: onConfirm,
            label: confirmLabel ?? 'Close',
          ),
        ),
      ];
    } else if (_type.isStrictConfirm) {
      return [
        Expanded(
          child: BaseElevatedButton(
            onPressed: onConfirm,
            label: confirmLabel ?? 'Confirm',
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: BaseElevatedButton(
            onPressed: onCancel,
            label: cancelLabel ?? 'Cancel',
          ),
        ),
      ];
    } else {
      return [];
    }
  }

  List<Widget>? _render() {
    if (_type.isSimple) {
      return children;
    } else {
      return [
        children != null
            ? Container(
                margin: const EdgeInsets.only(
                  bottom: 24.0,
                ),
                child: Column(
                  children: children!,
                ),
              )
            : const SizedBox.shrink(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _confirmActionWidget(),
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      clipBehavior: Clip.hardEdge,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 24.0,
      ),
      contentPadding: contentPadding ??
          const EdgeInsets.symmetric(
            vertical: 24.0,
            horizontal: 24.0,
          ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      children: _render(),
    );
  }
}

/// showActionDialog
///
/// Pre-configured showDialog for `BaseDialog()`
Future<T?> showActionDialog<T>({
  required BuildContext context,
  bool barrierDismissible = true,
  EdgeInsetsGeometry? contentPadding,
  List<Widget>? children,
}) async {
  return showDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (BuildContext context) {
      return BaseDialog(
        contentPadding: contentPadding,
        children: children,
      );
    },
  );
}

/// showActionConfirmDialog
///
/// Pre-configured showDialog for `BaseDialog.confirm()`
Future<bool> showActionConfirmDialog({
  required BuildContext context,
  String? confirmLabel,
  Color? foregroundColor,
  List<Widget>? children,
}) async {
  final res = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return BaseDialog.confirm(
        onConfirm: () {
          Navigator.pop(context, true);
        },
        confirmLabel: confirmLabel,
        foregroundColor: foregroundColor,
        children: children,
      );
    },
  );

  return res ?? false;
}

/// showActionStrictConfirmDialog
///
/// Pre-configured showDialog for `BaseDialog.strictConfirm()`
Future<bool> showActionStrictConfirmDialog({
  required BuildContext context,
  String? confirmLabel,
  String? cancelLabel,
  Color? foregroundColor,
  List<Widget>? children,
}) async {
  final res = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return BaseDialog.strictConfirm(
        onConfirm: () {
          Navigator.pop(context, true);
        },
        onCancel: () {
          Navigator.pop(context, false);
        },
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        foregroundColor: foregroundColor,
        children: children,
      );
    },
  );

  return res ?? false;
}

/// showInfoDialog
///
/// Pre-configured showDialog without an action
///
/// `type` variants : `info`, `warning`, `error`
Future<void> showInfoDialog({
  required BuildContext context,
  required String type,
  required String title,
  required String body,
}) async {
  Color? variantColor() {
    switch (type) {
      case 'info':
        return cLightBlue;
      case 'warning':
        return cOrange;
      case 'error':
        return cRed;
      default:
        return null;
    }
  }

  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return BaseDialog.confirm(
        onConfirm: () {
          Navigator.pop(context);
        },
        children: [
          Center(
            child: BaseTypography(
              text: title,
              type: 'h3',
              textAlign: TextAlign.center,
              fontWeight: fBold,
              color: variantColor(),
            ),
          ),
          const SizedBox(height: 24.0),
          Center(
            child: BaseTypography(
              text: body,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    },
  );
}
