import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/cubit/gameCubit.dart';
import 'package:quiz_td/models/enemy_model.dart';
import 'package:quiz_td/models/game_model.dart';
import 'package:quiz_td/utils/colors.dart';
import 'package:quiz_td/widget/infoWidgets/closePlateButton.dart';
import 'package:quiz_td/widget/infoWidgets/barWidget.dart';
import 'package:quiz_td/widget/playgroundWidgets/enemyInfo.dart';

class EnemyWidget extends StatelessWidget {
  final EnemyModel enemy;
  const EnemyWidget({super.key, required this.enemy});

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
                          EnemyInfo(
                            width: gm.width,
                            index: gm.selectedEnemyIndex!,
                            size: size,
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      enemyNameMap[enemy.type]!,
                                      style: TextStyle(
                                          height: 2,
                                          fontSize: 20,
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Row(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                                'DEMAGE ${enemy.dps.toString()} ',
                                                style: TextStyle(
                                                    color:
                                                        AppColors.primarySwatch,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Icon(
                                              Icons.gps_fixed,
                                              color: AppColors.primarySwatch,
                                              size: 16,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      enemyDescriptionMap[enemy.type]!,
                                      style: const TextStyle(
                                          height: 1.2,
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                  ]),
                            ),
                          )
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
                    ],
                  ),
                ),
                const Positioned(
                    bottom: 10, right: 10, child: ClosePlateButton())
              ],
            ));
  }
}
