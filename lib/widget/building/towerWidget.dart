import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/cubit/gameCubit.dart';
import 'package:quiz_td/models/game_model.dart';
import 'package:quiz_td/models/plate_model.dart';
import 'package:quiz_td/utils/colors.dart';
import 'package:quiz_td/widget/infoWidgets/closePlateButton.dart';
import 'package:quiz_td/widget/infoWidgets/repairButton.dart';
import 'package:quiz_td/widget/infoWidgets/upgradeButtonWidget.dart';
import 'package:quiz_td/widget/playgroundWidgets/buildingWidget.dart';
import 'package:quiz_td/widget/infoWidgets/barWidget.dart';

class TowerWidget extends StatelessWidget {
  final PlateModel plate;
  const TowerWidget({super.key, required this.plate});

  @override
  Widget build(BuildContext context) {
    var availableHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    double widgetHeight = availableHeight / 2;
    double size = MediaQuery.of(context).size.width / 2;

    return BlocBuilder<GameCubit, GameModel>(
        builder: (context, gm) => Container(
              height: widgetHeight,
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      BuildingWidget(
                        level: plate.level,
                        size: size,
                        building: plate.building,
                      ),
                      Column(children: [
                        Row(
                          children: [
                            Text(
                              'LEVEL - ${(plate.level).toString()}',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('DEMAGE ${plate.dps.toString()}',
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                                Icon(
                                  Icons.gps_fixed,
                                  color: AppColors.primaryColor,
                                  size: 16,
                                )
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            UpgradeButton(plate: plate),
                            RepairButton(plate: plate)
                          ],
                        ),
                      ])
                    ],
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: BarWidget(
                        value: plate.hp,
                        total: plate.building!.hp * plate.level,
                        icon: Icons.favorite,
                      )),
                  const ClosePlateButton()
                ],
              ),
            ));
  }
}
