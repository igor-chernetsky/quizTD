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
    List<List<BuildingModel>> buildings = [
      [
        BuildingModel(type: BuildingType.farm, price: 10, hp: 50),
      ],
      [
        BuildingModel(type: BuildingType.farm, price: 10, hp: 50),
        BuildingModel(
            type: BuildingType.tower,
            price: 50,
            hp: 150,
            dps: 10,
            buildSpeed: 5),
        BuildingModel(
            type: BuildingType.warhouse, price: 50, hp: 200, buildSpeed: 10)
      ],
      [
        BuildingModel(type: BuildingType.farm, price: 10, hp: 50),
        BuildingModel(
            type: BuildingType.tower,
            price: 50,
            hp: 150,
            dps: 10,
            buildSpeed: 5),
        BuildingModel(
            type: BuildingType.warhouse, price: 50, hp: 200, buildSpeed: 10)
      ]
    ];

    getEpochBuilding(int epoch, GameModel gm) {
      return Row(
          children: buildings[epoch - 1]
              .map(
                (b) => Column(
                  children: [
                    BuildingWidget(
                      level: gm.epoch,
                      size: size,
                      building: b,
                      onTap: () => context.read<GameCubit>().build(b, epoch),
                    ),
                    Center(
                      child: Text(
                        b.price.toString(),
                        style: TextStyle(
                            color:
                                gm.score < b.price ? Colors.red : Colors.green),
                      ),
                    )
                  ],
                ),
              )
              .toList());
    }

    return BlocBuilder<GameCubit, GameModel>(
        builder: (context, gm) => SizedBox(
              height: widgetHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getEpochBuilding(1, gm),
                  getEpochBuilding(2, gm),
                  getEpochBuilding(3, gm),
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
