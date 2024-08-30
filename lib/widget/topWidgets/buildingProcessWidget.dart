import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_defence/cubit/gameCubit.dart';
import 'package:quiz_defence/models/building_model.dart';
import 'package:quiz_defence/models/game_model.dart';
import 'package:quiz_defence/models/plate_model.dart';
import 'package:quiz_defence/widget/infoWidgets/closePlateButton.dart';
import 'package:quiz_defence/widget/playgroundWidgets/buildingWidget.dart';
import 'package:quiz_defence/widget/infoWidgets/barWidget.dart';

class BuildingProcessWidget extends StatelessWidget {
  final PlateModel plate;
  const BuildingProcessWidget({super.key, required this.plate});

  @override
  Widget build(BuildContext context) {
    var availableHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    double widgetHeight = availableHeight / 3;
    double mainSize = min<double>(MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height / 2);
    double size = mainSize / 3;

    return BlocBuilder<GameCubit, GameModel>(
        builder: (context, gm) => SizedBox(
              width: mainSize,
              height: widgetHeight,
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
                        SizedBox(
                            width: size * 2 - 10,
                            child: BarWidget(
                              value: plate.hp,
                              total: plate.building!.hp * plate.level,
                              icon: Icons.favorite,
                            )),
                        IconButton.filled(
                          onPressed: plate.building!.type == BuildingType.main
                              ? null
                              : () =>
                                  context.read<GameCubit>().cancelBuilding(),
                          icon: const Icon(Icons.delete),
                        )
                      ])
                    ],
                  ),
                  const ClosePlateButton()
                ],
              ),
            ));
  }
}
