import 'package:flutter/material.dart';

/// showSnackBar
///
/// Pre-configured `ScaffoldMessenger.of(context).showSnackBar()`
ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar({
  required BuildContext context,
  required Widget content,
  int? durationInMilliseconds,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      clipBehavior: Clip.hardEdge,
      behavior: SnackBarBehavior.floating,
      duration: Duration(milliseconds: durationInMilliseconds ?? 2500),
      dismissDirection: DismissDirection.down,
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 24.0,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      content: content,
    ),
  );
}
