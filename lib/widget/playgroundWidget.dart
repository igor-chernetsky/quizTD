import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/cubit/gameCubit.dart';
import 'package:quiz_td/models/game_model.dart';
import 'package:quiz_td/models/plate_model.dart';
import 'package:quiz_td/widget/buildingWidget.dart';
import 'package:quiz_td/widget/infoWidgets/healthBarWidget.dart';

class PlaygroundWidget extends StatelessWidget {
  const PlaygroundWidget({super.key});

  drawBuilding(PlateModel plate, BuildContext context, int index, double size) {
    List<Widget> res = [
      BuildingWidget(
          onTap: () {
            context.read<GameCubit>().selectPlate(index);
          },
          level: plate.level,
          building: plate.building,
          size: size)
    ];
    if (plate.building?.hp != null) {
      res.add(Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: HealthbarWidget(
          hp: plate.hp / plate.topHP!,
          width: size - 4,
        ),
      ));
    } else {
      res.add(Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: HealthbarWidget(
          color: const Color(0xFF990000),
          hp: 0,
          width: size - 4,
        ),
      ));
    }
    return res;
  }

  drawCity(
      BuildContext context, List<PlateModel> plates, int width, double size) {
    List<Widget> res = [];
    int height = plates.length ~/ width;
    for (int y = 0; y < height; y++) {
      List<Widget> rowItems = [];
      for (int x = 0; x < width; x++) {
        PlateModel plate = plates[y * width + x];
        int index = y * width + x;
        rowItems.add(Stack(
          alignment: Alignment.bottomCenter,
          children: drawBuilding(plate, context, index, size),
        ));
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
      return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/img/bg1.png'))),
        child: Column(
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
        ),
      );
    });
  }
}
