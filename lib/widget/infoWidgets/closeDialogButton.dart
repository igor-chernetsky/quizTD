import 'package:flutter/material.dart';

class CloseDialogButton extends StatelessWidget {
  const CloseDialogButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton.outlined(
      onPressed: () => Navigator.of(context).pop(),
      icon: const Icon(Icons.close),
    );
  }
}
