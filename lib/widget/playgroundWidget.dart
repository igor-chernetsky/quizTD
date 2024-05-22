import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/cubit/gameCubit.dart';
import 'package:quiz_td/models/game_model.dart';
import 'package:quiz_td/models/plate_model.dart';
import 'package:quiz_td/widget/buildingWidget.dart';

class PlaygroundWidget extends StatelessWidget {
  const PlaygroundWidget({super.key});

  drawCity(
      BuildContext context, List<PlateModel> plates, int width, double size) {
    List<Widget> res = [];
    int height = plates.length ~/ width;
    for (int y = 0; y < height; y++) {
      List<Widget> rowItems = [];
      for (int x = 0; x < width; x++) {
        int index = y * width + x;
        rowItems.add(BuildingWidget(
            onTap: () {
              context.read<GameCubit>().selectPlate(index);
            },
            building: plates[y * width + x].building,
            size: size));
      }
      res.add(Row(
        children: rowItems,
      ));
    }
    return Column(
      children: res,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameModel>(builder: (context, gm) {
      double size = MediaQuery.of(context).size.width / (gm.width + 2);
      return Column(
        children: [
          SizedBox(
            height: size,
          ),
          Row(
            children: [
              SizedBox(
                width: size,
              ),
              drawCity(context, gm.plates, gm.width, size),
              SizedBox(
                width: size,
              ),
            ],
          ),
          SizedBox(
            height: size,
          ),
        ],
      );
    });
  }
}
