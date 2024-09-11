import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_defence/cubit/gameCubit.dart';
import 'package:quiz_defence/models/enemy_model.dart';
import 'package:quiz_defence/models/game_model.dart';
import 'package:quiz_defence/utils/colors.dart';
import 'package:quiz_defence/widget/infoWidgets/closePlateButton.dart';
import 'package:quiz_defence/widget/infoWidgets/barWidget.dart';
import 'package:quiz_defence/widget/playgroundWidgets/enemyInfo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    double mainSize = min<double>(MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height / 2);
    double size = mainSize * 0.35;

    getEnemyDescription(AppLocalizations locale, EnemyType? t) {
      if (t != null) {
        switch (t) {
          case EnemyType.wolf:
            return locale.descriptionWolf;
          case EnemyType.enemy:
            return locale.descriptionEnemy;
          case EnemyType.helicopter:
            return locale.descriptionHelicopter;
          case EnemyType.zombie:
            return locale.descriptionZombie;
          case EnemyType.meteor:
            return locale.descriptionMeteor;
        }
      }
    }

    getEnemyName(AppLocalizations locale, EnemyType? t) {
      if (t != null) {
        switch (t) {
          case EnemyType.wolf:
            return locale.nameWolf;
          case EnemyType.enemy:
            return locale.nameEnemy;
          case EnemyType.helicopter:
            return locale.nameHelicopter;
          case EnemyType.zombie:
            return locale.nameZombie;
          case EnemyType.meteor:
            return locale.nameMeteor;
        }
      }
    }

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
                                      getEnemyName(
                                              AppLocalizations.of(context)!,
                                              enemy.type) ??
                                          '',
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
                                      getEnemyDescription(
                                              AppLocalizations.of(context)!,
                                              enemy.type) ??
                                          '',
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
                          width: mainSize - 10,
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
