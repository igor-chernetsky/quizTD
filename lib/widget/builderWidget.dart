import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/cubit/gameCubit.dart';
import 'package:quiz_td/models/building_model.dart';
import 'package:quiz_td/models/game_model.dart';
import 'package:quiz_td/widget/buildingWidget.dart';

class BuilderWidget extends StatelessWidget {
  const BuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double widgetHeight = MediaQuery.of(context).size.height / 3;
    double size = MediaQuery.of(context).size.width / 4;
    List<BuildingModel> buildings = [
      BuildingModel(type: BuildingType.farm, price: 10),
      BuildingModel(type: BuildingType.warhouse, price: 50),
      BuildingModel(type: BuildingType.main, price: 200)
    ];

    return BlocBuilder<GameCubit, GameModel>(
        builder: (context, gm) => Container(
              height: widgetHeight,
              child: Row(
                  children: buildings
                      .map(
                        (b) => Column(
                          children: [
                            BuildingWidget(
                              size: size,
                              building: b,
                              onTap: () => context.read<GameCubit>().build(b),
                            ),
                            Center(
                              child: Text(b.price.toString()),
                            )
                          ],
                        ),
                      )
                      .toList()),
            ));
  }
}
