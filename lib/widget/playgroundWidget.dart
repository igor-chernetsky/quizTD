import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/cubit/gameCubit.dart';
import 'package:quiz_td/models/game_model.dart';
import 'package:quiz_td/models/plate_model.dart';
import 'package:quiz_td/widget/buildingWidget.dart';
import 'package:quiz_td/widget/infoWidgets/healthBarWidget.dart';
import 'package:quiz_td/widget/playgroundWidgets/actionWidget.dart';
import 'package:quiz_td/widget/playgroundWidgets/seasonWidget.dart';
import 'package:quiz_td/widget/playgroundWidgets/scoreWidget.dart';

class PlaygroundWidget extends StatelessWidget {
  const PlaygroundWidget({super.key});

  drawBuilding(PlateModel plate, BuildContext context, int index, double size,
      bool isSelected) {
    List<Widget> res = [
      Transform.scale(
        scale: isSelected ? 1.3 : 1.1,
        child: BuildingWidget(
            onTap: () {
              context.read<GameCubit>().selectPlate(index);
            },
            level: plate.level,
            building: plate.building,
            size: size),
      )
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

  drawCity(BuildContext context, List<PlateModel> plates, int width,
      double size, int? selectedIndex) {
    List<Widget> res = [];
    int height = plates.length ~/ width;
    for (int y = 0; y < height; y++) {
      List<Widget> rowItems = [];
      for (int x = 0; x < width; x++) {
        PlateModel plate = plates[y * width + x];
        int index = y * width + x;
        rowItems.add(Stack(
          alignment: Alignment.bottomCenter,
          children:
              drawBuilding(plate, context, index, size, index == selectedIndex),
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

  getActionWidgets(double size, int start, int width) {
    List<Widget> res = [];
    for (int i = 0; i < width; i++) {
      res.add(ActionWidget(
        size: size,
        index: i + start,
      ));
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameModel>(builder: (context, gm) {
      double size = MediaQuery.of(context).size.width / (gm.width + 2);
      int maxSize = gm.width * gm.width;
      return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/img/bg1.png'))),
        child: Column(
          children: [
            SizedBox(
              height: size,
              child: Row(
                children: [
                  ScoreWidget(size: size),
                  ...getActionWidgets(size, 0, gm.width),
                  SeasonWidget(size: size)
                ],
              ),
            ),
            Row(
              children: [
                Column(
                  children: [
                    ...getActionWidgets(size, gm.width * 3, gm.width),
                  ],
                ),
                drawCity(context, gm.plates, gm.width, size, gm.selectedIndex),
                Column(
                  children: [
                    ...getActionWidgets(size, gm.width, gm.width),
                  ],
                )
              ],
            ),
            SizedBox(
              height: size,
              child: Row(
                children: [
                  SizedBox(
                    width: size,
                  ),
                  ...getActionWidgets(size, maxSize - gm.width, gm.width),
                  SizedBox(
                    width: size,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
