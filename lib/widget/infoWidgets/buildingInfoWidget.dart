import 'package:flutter/widgets.dart';
import 'package:quiz_td/models/building_model.dart';
import 'package:quiz_td/utils/colors.dart';
import 'package:quiz_td/widget/playgroundWidgets/buildingWidget.dart';

class BuildingInfo extends StatelessWidget {
  final BuildingModel building;
  final int epoch;
  const BuildingInfo({super.key, required this.building, required this.epoch});

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width / 3 - 24;
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              BuildingWidget(
                size: size,
                building: building,
                level: epoch,
              ),
              Text(buldingNames[building.type]!,
                  style: TextStyle(color: AppColors.textColor, fontSize: 20)),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(buldingDescription[building.type]!,
                style: TextStyle(color: AppColors.textSecondary, fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
