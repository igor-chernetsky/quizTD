import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/cubit/gameCubit.dart';
import 'package:quiz_td/models/game_model.dart';
import 'package:quiz_td/models/plate_model.dart';
import 'package:quiz_td/widget/buildingWidget.dart';
import 'package:quiz_td/widget/infoWidgets/barWidget.dart';

class BuildingProcessWidget extends StatelessWidget {
  final PlateModel plate;
  const BuildingProcessWidget({super.key, required this.plate});

  @override
  Widget build(BuildContext context) {
    double widgetHeight = MediaQuery.of(context).size.height / 3;
    double size = MediaQuery.of(context).size.width / 3;

    return BlocBuilder<GameCubit, GameModel>(
        builder: (context, gm) => Container(
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
                        onTap: () =>
                            context.read<GameCubit>().build(plate.building!),
                      ),
                      Column(children: [
                        SizedBox(
                            width: size * 2 - 10,
                            child: BarWidget(
                              value: plate.hp,
                              total: plate.building!.hp,
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
