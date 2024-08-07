import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/cubit/gameCubit.dart';
import 'package:quiz_td/models/game_model.dart';
import 'package:quiz_td/models/plate_model.dart';
import 'package:quiz_td/widget/infoWidgets/closePlateButton.dart';
import 'package:quiz_td/widget/playgroundWidgets/buildingWidget.dart';
import 'package:quiz_td/widget/infoWidgets/barWidget.dart';

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
    double size = MediaQuery.of(context).size.width / 3;

    return BlocBuilder<GameCubit, GameModel>(
        builder: (context, gm) => SizedBox(
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
                          onPressed: () =>
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
