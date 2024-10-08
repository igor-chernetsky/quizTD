import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_defence/cubit/gameCubit.dart';
import 'package:quiz_defence/cubit/questionCubit.dart';
import 'package:quiz_defence/models/game_model.dart';
import 'package:quiz_defence/models/plate_model.dart';
import 'package:quiz_defence/widget/building/buildingHP.dart';
import 'package:quiz_defence/widget/infoWidgets/buildingInfoWidget.dart';
import 'package:quiz_defence/widget/infoWidgets/closePlateButton.dart';
import 'package:quiz_defence/widget/playgroundWidgets/buildingWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    double size = mainSize * 0.35;

    isDisabled(GameModel gm) {
      return gm.epoch == 4 ||
          (gm.selectedPlate!.building!.price * gm.selectedPlate!.level) >
              gm.score;
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
                                    '${AppLocalizations.of(context)!.main} ${AppLocalizations.of(context)!.level}  ${plate.level}',
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
                                            '${AppLocalizations.of(context)!.epoch}: ${gm.epochName(AppLocalizations.of(context)!)}',
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
                                                      .setQuestions(epoch, 0,
                                                          local: AppLocalizations
                                                              .of(context)!);
                                                },
                                          icon: Icon(
                                            Icons.upgrade,
                                            color: isDisabled(gm)
                                                ? Colors.grey
                                                : Colors.white,
                                          ),
                                          label: Text(
                                              '\$${plate.building!.price * plate.level}',
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
                      BuildingHp(
                        plate: plate,
                        mainSize: mainSize,
                      )
                    ],
                  ),
                ),
                Positioned(
                    bottom: 10,
                    right: 10,
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
