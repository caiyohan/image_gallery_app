import 'package:flutter/material.dart';

class WarningDialog extends StatelessWidget {
  const WarningDialog({
    required this.title,
    required this.okButton,
    super.key,
  });

  final String title;
  final Widget okButton;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      actions: [okButton],
    );
  }
}
