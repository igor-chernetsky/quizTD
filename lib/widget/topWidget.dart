import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/cubit/gameCubit.dart';
import 'package:quiz_td/models/building_model.dart';
import 'package:quiz_td/models/game_model.dart';
import 'package:quiz_td/widget/topWidgets/builderWidget.dart';
import 'package:quiz_td/widget/topWidgets/buildingProcessWidget.dart';
import 'package:quiz_td/widget/topWidgets/enemyWidget.dart';
import 'package:quiz_td/widget/topWidgets/farmWidget.dart';
import 'package:quiz_td/widget/topWidgets/mainWidget.dart';
import 'package:quiz_td/widget/topWidgets/quizWidget.dart';
import 'package:quiz_td/widget/topWidgets/towerWidget.dart';

class TopWidget extends StatelessWidget {
  const TopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameModel>(builder: (context, gm) {
      if (gm.selectedPlate == null && gm.selectedEnemy == null) {
        return const QuizWidget();
      }
      if (gm.selectedEnemy != null) {
        return Enemywidget(enemy: gm.selectedEnemy!);
      }
      if (gm.selectedPlate!.building == null) {
        return const BuilderWidget();
      }
      if (gm.selectedPlate!.buildProgress != null) {
        return BuildingProcessWidget(
          plate: gm.selectedPlate!,
        );
      }
      if (gm.selectedPlate!.building!.type == BuildingType.farm) {
        return FarmWidget(
          plate: gm.selectedPlate!,
        );
      }
      if (gm.selectedPlate!.building!.type == BuildingType.tower) {
        return TowerWidget(
          plate: gm.selectedPlate!,
        );
      }
      if (gm.selectedPlate!.building!.type == BuildingType.main) {
        return MainWidget(
          plate: gm.selectedPlate!,
        );
      }
      return Placeholder();
    });
  }
}
