import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_fade/image_fade.dart';
import 'package:quiz_defence/cubit/gameCubit.dart';
import 'package:quiz_defence/models/game_model.dart';
import 'package:quiz_defence/models/plate_model.dart';
import 'package:quiz_defence/screens/start.dart';
import 'package:quiz_defence/utils/colors.dart';
import 'package:quiz_defence/widget/infoWidgets/epochNum.dart';
import 'package:quiz_defence/widget/menus/mainMenu.dart';
import 'package:quiz_defence/widget/playgroundWidgets/arrowWidget.dart';
import 'package:quiz_defence/widget/playgroundWidgets/buildingWidget.dart';
import 'package:quiz_defence/widget/infoWidgets/healthBarWidget.dart';
import 'package:quiz_defence/widget/playgroundWidgets/actionWidget.dart';
import 'package:quiz_defence/widget/playgroundWidgets/seasonWidget.dart';
import 'package:quiz_defence/widget/playgroundWidgets/scoreWidget.dart';

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
          hp: ((plate.topHP ?? 0) > 0 && plate.hp > 0)
              ? (plate.hp / plate.topHP!)
              : 0,
          width: size - 4,
        ),
      ));
    } else {
      res.add(Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: HealthbarWidget(
          color: AppColors.accentColor,
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
              child: Transform.scale(
                scale: 1.12,
                child: Opacity(
                  opacity: 0.75,
                  child: Container(
                    width: size * 3,
                    height: size * 3,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/img/fencemap.png'))),
                  ),
                ),
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
        color: const Color.fromRGBO(0, 0, 0, 0.6),
        child: Container(
          padding: const EdgeInsets.all(10),
          height: double.infinity,
          width: double.infinity,
          child: EpochnumWidget(epoch: epoch),
        ),
      ),
    );
  }

  getSeasonName(double counter) {
    if (counter < 0.25) {
      return 'summer';
    } else if (counter < 0.5) {
      return 'autumn';
    } else if (counter < 0.75) {
      return 'winter';
    }
    return 'spring';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameModel>(builder: (context, gm) {
      double mainSize = min<double>(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height / 2);
      double size = mainSize / (gm.width + 2);
      int maxSize = gm.width * gm.width;
      return Stack(
        children: [
          Positioned.fill(
            child: Opacity(
                opacity: 1,
                child: ImageFade(
                  // whenever the image changes, it will be loaded, and then faded in:
                  image: AssetImage(
                      'assets/img/seasons/${getSeasonName(gm.counter)}.png'),

                  // slow-ish fade for loaded images:
                  duration: const Duration(milliseconds: 1000),

                  // supports most properties of Image:
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                  scale: 1,
                )),
          ),
          Center(
            child: Container(
              alignment: Alignment.center,
              width: mainSize,
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
                        getEpoch(gm.epoch, size),
                        ...getActionWidgets(size, maxSize - gm.width, gm.width),
                        MainMenu(
                          size: size,
                          parentContext: context,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
