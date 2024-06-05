import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/cubit/gameCubit.dart';
import 'package:quiz_td/models/building_model.dart';
import 'package:quiz_td/models/game_model.dart';
import 'package:quiz_td/widget/playgroundWidgets/buildingWidget.dart';

class BuilderWidget extends StatelessWidget {
  const BuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double widgetHeight = MediaQuery.of(context).size.height / 3;
    double size = MediaQuery.of(context).size.width / 4;
    List<BuildingModel> buildings = [
      BuildingModel(type: BuildingType.farm, price: 10, hp: 50),
      BuildingModel(
          type: BuildingType.tower, price: 50, hp: 150, dps: 10, buildSpeed: 5),
      BuildingModel(
          type: BuildingType.warhouse, price: 50, hp: 200, buildSpeed: 10)
    ];

    return BlocBuilder<GameCubit, GameModel>(
        builder: (context, gm) => SizedBox(
              height: widgetHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                      children: buildings
                          .map(
                            (b) => Column(
                              children: [
                                BuildingWidget(
                                  level: gm.epoch,
                                  size: size,
                                  building: b,
                                  onTap: () =>
                                      context.read<GameCubit>().build(b),
                                ),
                                Center(
                                  child: Text(
                                    b.price.toString(),
                                    style: TextStyle(
                                        color: gm.score < b.price
                                            ? Colors.red
                                            : Colors.green),
                                  ),
                                )
                              ],
                            ),
                          )
                          .toList()),
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
