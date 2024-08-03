import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/cubit/gameCubit.dart';
import 'package:quiz_td/models/game_model.dart';
import 'package:quiz_td/models/plate_model.dart';
import 'package:quiz_td/models/upgrade_model.dart';
import 'package:quiz_td/utils/colors.dart';
import 'package:quiz_td/widget/infoWidgets/barWidget.dart';
import 'package:quiz_td/widget/infoWidgets/closePlateButton.dart';
import 'package:quiz_td/widget/infoWidgets/repairButton.dart';
import 'package:quiz_td/widget/infoWidgets/upgradeButtonWidget.dart';
import 'package:quiz_td/widget/infoWidgets/upgradeWidget.dart';
import 'package:quiz_td/widget/playgroundWidgets/buildingWidget.dart';

class SchoolWidget extends StatelessWidget {
  final PlateModel plate;
  const SchoolWidget({super.key, required this.plate});

  @override
  Widget build(BuildContext context) {
    var availableHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    double widgetHeight = availableHeight / 2;
    double size = MediaQuery.of(context).size.width * 0.4;
    double upgradeSize = MediaQuery.of(context).size.width / 4 - 14;

    upgradeClick(UpgradeType upgrade) {
      context.read<GameCubit>().makeUpgrade(upgrade);
    }

    getUpgrades(GameModel gm) {
      List<Widget> children = [
        UpgradeWidget(
          size: upgradeSize,
          upgrade: UpgradeType.education,
          done: gm.upgrades?.education == true,
          price: upgradePriceMap[UpgradeType.education] ?? 0,
          score: gm.score,
          onTap: () => upgradeClick(UpgradeType.education),
        ),
        UpgradeWidget(
          size: upgradeSize,
          upgrade: UpgradeType.range,
          done: gm.upgrades?.range == true,
          price: upgradePriceMap[UpgradeType.range] ?? 0,
          score: gm.score,
          onTap: () => upgradeClick(UpgradeType.range),
        ),
      ];
      if (gm.epoch > 2) {
        children.add(UpgradeWidget(
          size: upgradeSize,
          upgrade: UpgradeType.repair,
          done: gm.upgrades?.repair == true,
          score: gm.score,
          price: upgradePriceMap[UpgradeType.repair] ?? 0,
          onTap: () => upgradeClick(UpgradeType.repair),
        ));
        children.add(UpgradeWidget(
          size: upgradeSize,
          upgrade: UpgradeType.fence,
          price: upgradePriceMap[UpgradeType.fence] ?? 0,
          done: gm.upgrades?.fence == true,
          score: gm.score,
          onTap: () => upgradeClick(UpgradeType.fence),
        ));
        if (gm.epoch > 3) {
          children.add(UpgradeWidget(
            size: upgradeSize,
            upgrade: UpgradeType.dome,
            price: upgradePriceMap[UpgradeType.dome] ?? 0,
            done: gm.upgrades?.repair == true,
            score: gm.score,
            onTap: () => upgradeClick(UpgradeType.dome),
          ));
        }
      }
      return Row(children: children);
    }

    return BlocBuilder<GameCubit, GameModel>(
        builder: (context, gm) => Stack(
              children: [
                Container(
                  height: widgetHeight,
                  padding: const EdgeInsets.only(
                      top: 10, left: 20, right: 20, bottom: 30),
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
                                    'SCHOOL level ${plate.level}',
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
                                                  '+${gm.upgrades?.education == true ? 25 : 50}% question reward',
                                                  style: TextStyle(
                                                      color:
                                                          AppColors.textColor,
                                                      height: 2,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                        ],
                                      ),
                                      UpgradeButton(plate: plate),
                                    ],
                                  ),
                                ]),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
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
                      getUpgrades(gm),
                    ],
                  ),
                ),
                const Positioned(bottom: 4, right: 4, child: ClosePlateButton())
              ],
            ));
  }
}
