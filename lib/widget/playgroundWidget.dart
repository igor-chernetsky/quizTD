import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/cubit/gameCubit.dart';
import 'package:quiz_td/models/game_model.dart';
import 'package:quiz_td/models/plate_model.dart';
import 'package:quiz_td/widget/infoWidgets/epochNum.dart';
import 'package:quiz_td/widget/playgroundWidgets/arrowWidget.dart';
import 'package:quiz_td/widget/playgroundWidgets/buildingWidget.dart';
import 'package:quiz_td/widget/infoWidgets/healthBarWidget.dart';
import 'package:quiz_td/widget/playgroundWidgets/actionWidget.dart';
import 'package:quiz_td/widget/playgroundWidgets/seasonWidget.dart';
import 'package:quiz_td/widget/playgroundWidgets/scoreWidget.dart';

class PlaygroundWidget extends StatelessWidget {
  const PlaygroundWidget({super.key});

  drawBuilding(PlateModel plate, BuildContext context, int index, double size,
      bool isSelected, int width) {
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
    if (plate.targetIndex != null) {
      res.add(ArrowWidget(
        width: width,
        index: plate.targetIndex!,
        size: size,
      ));
    }
    return res;
  }

  drawCity(BuildContext context, List<PlateModel> plates, int width,
      double size, bool fence, int? selectedIndex) {
    List<Widget> res = [];
    int height = plates.length ~/ width;
    for (int y = 0; y < height; y++) {
      List<Widget> rowItems = [];
      for (int x = 0; x < width; x++) {
        PlateModel plate = plates[y * width + x];
        int index = y * width + x;
        rowItems.add(Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: drawBuilding(
              plate, context, index, size, index == selectedIndex, width),
        ));
      }
      res.add(Row(
        children: rowItems,
      ));
    }
    List<Widget> background = fence
        ? [
            Positioned(
              child: Container(
                width: size * 3,
                height: size * 3,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/img/fencemap.png'))),
              ),
            ),
          ]
        : [];
    return Stack(
      children: [
        ...background,
        Column(
          children: res,
        ),
      ],
    );
  }

  getActionWidgets(double size, int start, int width) {
    List<Widget> res = [];
    for (int i = 0; i < width; i++) {
      res.add(ActionWidget(
        width: width,
        size: size,
        index: i + start,
      ));
    }
    return res;
  }

  getEpoch(int epoch, double size) {
    return SizedBox(
      height: size,
      width: size,
      child: Card(
        color: const Color.fromRGBO(0, 0, 0, 0.4),
        child: Container(
          padding: const EdgeInsets.all(10),
          height: double.infinity,
          width: double.infinity,
          child: EpochnumWidget(epoch: epoch),
        ),
      ),
    );
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
                drawCity(context, gm.plates, gm.width, size,
                    gm.upgrades?.fence == true, gm.selectedIndex),
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
                  getEpoch(gm.epoch, size),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
