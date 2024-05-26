import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HealthbarWidget extends StatelessWidget {
  final double hp;
  final double width;
  const HealthbarWidget({super.key, required this.hp, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      height: 10,
      width: width,
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: const BorderRadius.all(Radius.circular(4))),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: hp,
        heightFactor: 1,
        child: Container(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
