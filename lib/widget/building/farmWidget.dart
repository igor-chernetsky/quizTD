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

class FarmWidget extends StatelessWidget {
  final PlateModel plate;
  const FarmWidget({super.key, required this.plate});

  @override
  Widget build(BuildContext context) {
    var availableHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    double widgetHeight = availableHeight / 2;
    double size = MediaQuery.of(context).size.width * 0.4;

    return BlocBuilder<GameCubit, GameModel>(
        builder: (context, gm) => Stack(
              children: [
                Container(
                  height: widgetHeight,
                  padding: const EdgeInsets.only(
                      top: 10, left: 20, right: 20, bottom: 80),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BuildingWidget(
                            level: plate.level,
                            size: size,
                            building: plate.building,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'FARM level ${plate.level}',
                                    style: TextStyle(
                                        height: 2,
                                        fontSize: 20,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                  'INCOME ${plate.income.toString()}/',
                                                  style: TextStyle(
                                                      height: 2,
                                                      color:
                                                          AppColors.textColor,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Icon(
                                                Icons.sunny,
                                                color: AppColors.textColor,
                                                size: 16,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      UpgradeButton(plate: plate),
                                    ],
                                  ),
                                ]),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width - 140,
                              child: BarWidget(
                                value: plate.hp,
                                total: plate.building!.hp * plate.level,
                                icon: Icons.favorite,
                              )),
                          RepairButton(plate: plate),
                        ],
                      ),
                    ],
                  ),
                ),
                const Positioned(
                    bottom: 10, right: 10, child: ClosePlateButton())
              ],
            ));
  }
}
