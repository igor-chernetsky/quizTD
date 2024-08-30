import 'package:flutter/material.dart';
import 'package:quiz_defence/models/building_model.dart';

class BuildingWidget extends StatelessWidget {
  final BuildingModel? building;
  final double size;
  final Function? onTap;
  final int? level;
  const BuildingWidget(
      {required this.size, super.key, this.building, this.onTap, this.level});

  @override
  Widget build(BuildContext context) {
    String imgPath = 'assets/img/concrete.png';
    if (building != null) {
      switch (building!.type) {
        case BuildingType.farm:
          imgPath = 'assets/img/farm${level ?? 1}.png';
          break;
        case BuildingType.tower:
          imgPath = 'assets/img/tower${level ?? 1}.png';
          break;
        case BuildingType.main:
          imgPath = 'assets/img/main${level ?? 1}.png';
          break;
        case BuildingType.school:
          imgPath = 'assets/img/school${level ?? 1}.png';
          break;
        default:
          imgPath = 'assets/img/concrete.png';
      }
    }

    return Container(
      padding: const EdgeInsets.all(4),
      width: size,
      height: size,
      child: GestureDetector(
        onTap: () => onTap == null ? null : onTap!(),
        child: Container(
          decoration:
              BoxDecoration(image: DecorationImage(image: AssetImage(imgPath))),
        ),
      ),
    );
  }
}
