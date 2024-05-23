import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HealthbarWidget extends StatelessWidget {
  double hp;
  double width;
  HealthbarWidget({super.key, required this.hp, required this.width});

  @override
  Widget build(BuildContext context) {
    int val = (hp * 255).toInt();
    Color color = Color.fromRGBO(255 - val, val, 20, 1);

    return Container(
      padding: const EdgeInsets.all(4),
      height: 12,
      width: width,
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: hp,
        heightFactor: 1,
        child: Container(
          color: color,
        ),
      ),
    );
  }
}
