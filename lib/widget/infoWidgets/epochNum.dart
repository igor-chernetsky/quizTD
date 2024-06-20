import 'package:flutter/material.dart';

class EpochnumWidget extends StatelessWidget {
  final bool isSelected;
  final int epoch;
  final double size;
  final bool disabled;
  const EpochnumWidget(
      {super.key,
      required this.epoch,
      this.isSelected = false,
      this.disabled = false,
      this.size = 48});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/img/e$epoch.png'))),
      width: size,
      height: size,
    );
  }
}
