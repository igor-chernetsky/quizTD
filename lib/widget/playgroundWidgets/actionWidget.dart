import 'package:flutter/material.dart';

class ActionWidget extends StatelessWidget {
  final double size;
  final int index;
  const ActionWidget({super.key, required this.size, required this.index});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Text(index.toString()),
    );
  }
}
