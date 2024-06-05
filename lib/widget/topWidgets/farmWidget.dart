import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/cubit/gameCubit.dart';
import 'package:quiz_td/models/game_model.dart';
import 'package:quiz_td/models/plate_model.dart';
import 'package:quiz_td/utils/colors.dart';
import 'package:quiz_td/widget/playgroundWidgets/buildingWidget.dart';
import 'package:quiz_td/widget/infoWidgets/barWidget.dart';

class FarmWidget extends StatelessWidget {
  final PlateModel plate;
  const FarmWidget({super.key, required this.plate});

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width / 2;

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
                                Text('INCOME ${plate.income.toString()}/',
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                                Icon(
                                  Icons.sunny,
                                  color: AppColors.primaryColor,
                                  size: 16,
                                )
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
                  )
                ],
              ),
            ));
  }
}
