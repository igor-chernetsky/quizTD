import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:quiz_defence/models/building_model.dart';
import 'package:quiz_defence/utils/colors.dart';
import 'package:quiz_defence/widget/infoWidgets/closeDialogButton.dart';
import 'package:quiz_defence/widget/playgroundWidgets/buildingWidget.dart';

class BuildingInfo extends StatelessWidget {
  final BuildingModel building;
  final int epoch;
  const BuildingInfo({super.key, required this.building, required this.epoch});

  @override
  Widget build(BuildContext context) {
    double mainSize = min<double>(MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height / 2);
    double size = mainSize / 3 - 24;
    return Stack(
      children: [
        Center(
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
                      style:
                          TextStyle(color: AppColors.textColor, fontSize: 20)),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(buldingDescription[building.type]!,
                    style: TextStyle(
                        color: AppColors.textSecondary, fontSize: 16)),
              ),
            ],
          ),
        ),
        const Positioned(bottom: 10, right: 10, child: CloseDialogButton())
      ],
    );
  }
}
