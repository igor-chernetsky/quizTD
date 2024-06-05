import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/cubit/gameCubit.dart';
import 'package:quiz_td/models/enemy_model.dart';
import 'package:quiz_td/models/game_model.dart';
import 'package:quiz_td/utils/colors.dart';
import 'package:quiz_td/widget/playgroundWidgets/actionWidget.dart';
import 'package:quiz_td/widget/infoWidgets/barWidget.dart';

class Enemywidget extends StatelessWidget {
  final EnemyModel enemy;
  const Enemywidget({super.key, required this.enemy});

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
                      ActionWidget(
                        index: gm.selectedEnemyIndex!,
                        size: size,
                      ),
                      Column(children: [
                        Row(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('DEMAGE ${enemy.dps.toString()} ',
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
                      ])
                    ],
                  ),
                  Container(
                      padding: const EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width - 10,
                      child: BarWidget(
                        value: enemy.hp,
                        total: enemy.max,
                        icon: Icons.favorite,
                      )),
                  IconButton.filled(
                    onPressed: () =>
                        context.read<GameCubit>().selectEnemy(null),
                    icon: const Icon(Icons.close),
                  )
                ],
              ),
            ));
  }
}
