import 'package:flutter/material.dart';

void showAlertDialog(
  BuildContext context, {
  required Widget child,
  bool canDismiss = false,
  Color? barrierColor,
}) {
  showDialog(
    context: context,
    barrierDismissible: canDismiss,
    barrierColor: barrierColor,
    builder: (context) => PopScope(
      canPop: canDismiss,
      child: child,
    ),
  );
}
