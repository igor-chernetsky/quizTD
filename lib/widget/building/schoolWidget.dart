import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_defence/cubit/gameCubit.dart';
import 'package:quiz_defence/models/game_model.dart';
import 'package:quiz_defence/models/plate_model.dart';
import 'package:quiz_defence/models/upgrade_model.dart';
import 'package:quiz_defence/utils/colors.dart';
import 'package:quiz_defence/widget/building/buildingHP.dart';
import 'package:quiz_defence/widget/infoWidgets/buildingInfoWidget.dart';
import 'package:quiz_defence/widget/infoWidgets/closePlateButton.dart';
import 'package:quiz_defence/widget/infoWidgets/sellButtonWidget.dart';
import 'package:quiz_defence/widget/infoWidgets/upgradeButtonWidget.dart';
import 'package:quiz_defence/widget/infoWidgets/upgradeInfoWidget.dart';
import 'package:quiz_defence/widget/infoWidgets/upgradeWidget.dart';
import 'package:quiz_defence/widget/playgroundWidgets/buildingWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    double mainSize = min<double>(MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height / 2);
    double size = mainSize * 0.35;
    double upgradeSize = 70;

    upgradeClick(UpgradeType upgrade) {
      context.read<GameCubit>().makeUpgrade(upgrade);
    }

    getInfoWidget(UpgradeType upgrade) {
      return SizedBox(
        height: 24,
        width: 24,
        child: IconButton.outlined(
            iconSize: 12,
            padding: EdgeInsets.all(1),
            onPressed: () {
              showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                        padding: const EdgeInsets.all(10),
                        height: 200,
                        width: double.infinity,
                        child: UpgradeInfo(
                          upgrade: upgrade,
                        ));
                  });
            },
            icon: const Icon(
              Icons.question_mark,
            )),
      );
    }

    getUpgrades(GameModel gm) {
      List<Widget> children = [
        Column(
          children: [
            UpgradeWidget(
              size: upgradeSize,
              upgrade: UpgradeType.education,
              done: gm.upgrades?.education == true,
              price: upgradePriceMap[UpgradeType.education] ?? 0,
              score: gm.score,
              onTap: () => upgradeClick(UpgradeType.education),
            ),
            getInfoWidget(UpgradeType.education)
          ],
        ),
        Column(
          children: [
            UpgradeWidget(
              size: upgradeSize,
              upgrade: UpgradeType.range,
              done: gm.upgrades?.range == true,
              price: upgradePriceMap[UpgradeType.range] ?? 0,
              score: gm.score,
              onTap: () => upgradeClick(UpgradeType.range),
            ),
            getInfoWidget(UpgradeType.range)
          ],
        ),
      ];
      if (gm.epoch > 2) {
        children.add(Column(
          children: [
            UpgradeWidget(
              size: upgradeSize,
              upgrade: UpgradeType.repair,
              done: gm.upgrades?.repair == true,
              score: gm.score,
              price: upgradePriceMap[UpgradeType.repair] ?? 0,
              onTap: () => upgradeClick(UpgradeType.repair),
            ),
            getInfoWidget(UpgradeType.repair)
          ],
        ));
        children.add(Column(
          children: [
            UpgradeWidget(
              size: upgradeSize,
              upgrade: UpgradeType.fence,
              price: upgradePriceMap[UpgradeType.fence] ?? 0,
              done: gm.upgrades?.fence == true,
              score: gm.score,
              onTap: () => upgradeClick(UpgradeType.fence),
            ),
            getInfoWidget(UpgradeType.fence)
          ],
        ));
        // if (gm.epoch > 3) {
        //   children.add(Column(
        //     children: [
        //       UpgradeWidget(
        //         size: upgradeSize,
        //         upgrade: UpgradeType.dome,
        //         price: upgradePriceMap[UpgradeType.dome] ?? 0,
        //         done: gm.upgrades?.repair == true,
        //         score: gm.score,
        //         onTap: () => upgradeClick(UpgradeType.dome),
        //       ),
        //       getInfoWidget(UpgradeType.dome)
        //     ],
        //   ));
        // }
      }
      return Row(children: children);
    }

    return BlocBuilder<GameCubit, GameModel>(
        builder: (context, gm) => Stack(
              children: [
                Container(
                  height: widgetHeight,
                  width: mainSize,
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
                                    '${AppLocalizations.of(context)!.school} ${AppLocalizations.of(context)!.level}  ${plate.level}',
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
                                                  '+${gm.upgrades?.education == true ? 50 : 25}% ${AppLocalizations.of(context)!.reward}',
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
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      UpgradeButton(plate: plate),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      SellButton(plate: plate),
                                    ],
                                  ),
                                ]),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BuildingHp(
                        plate: plate,
                        mainSize: mainSize,
                      ),
                      getUpgrades(gm),
                    ],
                  ),
                ),
                Positioned(
                    bottom: 4,
                    right: 4,
                    child: Row(
                      children: [
                        IconButton.outlined(
                            onPressed: () {
                              showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                        padding: const EdgeInsets.all(10),
                                        height: 300,
                                        width: double.infinity,
                                        child: BuildingInfo(
                                          building: plate.building!,
                                          epoch: gm.epoch,
                                        ));
                                  });
                            },
                            iconSize: 18,
                            icon: const Icon(
                              Icons.question_mark,
                            )),
                        const ClosePlateButton(),
                      ],
                    ))
              ],
            ));
  }
}
