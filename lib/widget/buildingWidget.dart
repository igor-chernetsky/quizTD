import 'package:flutter/material.dart';
import 'package:quiz_td/models/building_model.dart';

class BuildingWidget extends StatelessWidget {
  BuildingModel? building;
  double size;
  Function? onTap;
  BuildingWidget({required this.size, super.key, this.building, this.onTap});

  @override
  Widget build(BuildContext context) {
    String imgPath = 'assets/img/concrete.png';
    if (building != null) {
      switch (building!.type) {
        case BuildingType.farm:
          imgPath = 'assets/img/farm1.png';
          break;
        case BuildingType.main:
          imgPath = 'assets/img/main1.png';
          break;
        case BuildingType.warhouse:
          imgPath = 'assets/img/warhouse1.png';
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
