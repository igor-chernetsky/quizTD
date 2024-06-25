import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/cubit/gameCubit.dart';
import 'package:quiz_td/models/game_model.dart';
import 'package:quiz_td/models/plate_model.dart';
import 'package:quiz_td/models/upgrade_model.dart';
import 'package:quiz_td/utils/colors.dart';
import 'package:quiz_td/widget/infoWidgets/barWidget.dart';
import 'package:quiz_td/widget/infoWidgets/upgradeWidget.dart';
import 'package:quiz_td/widget/playgroundWidgets/buildingWidget.dart';

class SchoolWidget extends StatelessWidget {
  final PlateModel plate;
  const SchoolWidget({super.key, required this.plate});

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width / 3;
    double upgradeSize = MediaQuery.of(context).size.width / 4 - 10;

    upgradeClick(UpgradeType upgrade) {
      print(upgrade);
    }

    return BlocBuilder<GameCubit, GameModel>(
        builder: (context, gm) => Container(
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
                                Text(
                                    '+${gm.upgrades?.education == true ? 25 : 50}% question reward',
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                        ElevatedButton.icon(
                            onPressed: () => plate.level >= gm.epoch
                                ? null
                                : context.read<GameCubit>().upgradeBuilding(),
                            icon: const Icon(Icons.upgrade),
                            label: Text('Upgrade \$${plate.building!.price}'))
                      ])
                    ],
                  ),
                  Container(
                      padding: const EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width - 10,
                      child: BarWidget(
                        value: plate.hp,
                        total: plate.building!.hp * plate.level,
                        icon: Icons.favorite,
                      )),
                  IconButton.filled(
                    onPressed: () =>
                        context.read<GameCubit>().selectPlate(null),
                    icon: const Icon(Icons.close),
                  ),
                  Row(
                    children: [
                      UpgradeWidget(
                        size: upgradeSize,
                        upgrade: UpgradeType.education,
                        done: gm.upgrades?.education == true,
                        price: 300,
                        score: gm.score,
                        onTap: () => upgradeClick(UpgradeType.education),
                      ),
                      UpgradeWidget(
                        size: upgradeSize,
                        upgrade: UpgradeType.range,
                        done: gm.upgrades?.range == true,
                        price: 200,
                        score: gm.score,
                        onTap: () => upgradeClick(UpgradeType.range),
                      ),
                      UpgradeWidget(
                        size: upgradeSize,
                        upgrade: UpgradeType.repair,
                        done: gm.upgrades?.repair == true,
                        score: gm.score,
                        price: 200,
                        onTap: () => upgradeClick(UpgradeType.repair),
                      ),
                      UpgradeWidget(
                        size: upgradeSize,
                        upgrade: UpgradeType.fence,
                        price: 400,
                        done: gm.upgrades?.repair == true,
                        score: gm.score,
                        onTap: () => upgradeClick(UpgradeType.fence),
                      )
                    ],
                  )
                ],
              ),
            ));
  }
}
