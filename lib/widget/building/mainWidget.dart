import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/cubit/gameCubit.dart';
import 'package:quiz_td/cubit/questionCubit.dart';
import 'package:quiz_td/models/game_model.dart';
import 'package:quiz_td/models/plate_model.dart';
import 'package:quiz_td/widget/infoWidgets/closePlateButton.dart';
import 'package:quiz_td/widget/infoWidgets/epochNum.dart';
import 'package:quiz_td/widget/infoWidgets/repairButton.dart';
import 'package:quiz_td/widget/playgroundWidgets/buildingWidget.dart';
import 'package:quiz_td/widget/infoWidgets/barWidget.dart';

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
    double size = MediaQuery.of(context).size.width / 3;

    return BlocBuilder<GameCubit, GameModel>(
        builder: (context, gm) => Container(
              height: widgetHeight,
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            Column(
                              children: [
                                Text(
                                  'EPOCH:',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  gm.epochName,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            EpochnumWidget(epoch: gm.epoch)
                          ],
                        ),
                        ElevatedButton.icon(
                            onPressed: () {
                              int epoch =
                                  context.read<GameCubit>().nextEpoch(false);
                              context
                                  .read<QuestionCubit>()
                                  .setQuestions(epoch, 0);
                            },
                            icon: const Icon(Icons.upgrade),
                            label: Text('Upgrade \$${plate.building!.price}')),
                        RepairButton(plate: plate)
                      ])
                    ],
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: BarWidget(
                        value: plate.hp,
                        total: plate.building!.hp * plate.level,
                        icon: Icons.favorite,
                      )),
                  const ClosePlateButton()
                ],
              ),
            ));
  }
}
