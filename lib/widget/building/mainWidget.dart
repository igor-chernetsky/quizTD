import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_defence/cubit/gameCubit.dart';
import 'package:quiz_defence/cubit/questionCubit.dart';
import 'package:quiz_defence/models/game_model.dart';
import 'package:quiz_defence/models/plate_model.dart';
import 'package:quiz_defence/widget/infoWidgets/closePlateButton.dart';
import 'package:quiz_defence/widget/infoWidgets/repairButton.dart';
import 'package:quiz_defence/widget/playgroundWidgets/buildingWidget.dart';
import 'package:quiz_defence/widget/infoWidgets/barWidget.dart';

class MainWidget extends StatelessWidget {
  final PlateModel plate;
  const MainWidget({super.key, required this.plate});

  @override
  Widget build(BuildContext context) {
    var availableHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    double widgetHeight = availableHeight / 2;
    double mainSize = min<double>(MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height / 2);
    double size = mainSize * 0.4;

    isDisabled(GameModel gm) {
      return gm.epoch == 4 || gm.selectedPlate!.building!.price > gm.score;
    }

    return BlocBuilder<GameCubit, GameModel>(
        builder: (context, gm) => Stack(
              children: [
                Container(
                  width: mainSize,
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
                                    'MAIN level ${plate.level}',
                                    style: const TextStyle(
                                        height: 2,
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'EPOCH: ${gm.epochName}',
                                            style: const TextStyle(
                                                height: 2,
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      ElevatedButton.icon(
                                          onPressed: isDisabled(gm)
                                              ? null
                                              : () {
                                                  int epoch = context
                                                      .read<GameCubit>()
                                                      .nextEpoch(false);
                                                  context
                                                      .read<QuestionCubit>()
                                                      .setQuestions(epoch, 0);
                                                },
                                          icon: Icon(
                                            Icons.upgrade,
                                            color: isDisabled(gm)
                                                ? Colors.grey
                                                : Colors.white,
                                          ),
                                          label: Text(
                                              '\$${plate.building!.price}',
                                              style: TextStyle(
                                                  color: isDisabled(gm)
                                                      ? Colors.grey
                                                      : Colors.white,
                                                  letterSpacing: 1.4))),
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
                              width: mainSize - 140,
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
                Positioned(
                    bottom: 10, right: 10, child: const ClosePlateButton())
              ],
            ));
  }
}
