import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/cubit/gameCubit.dart';
import 'package:quiz_td/models/game_model.dart';
import 'package:quiz_td/widget/builderWidget.dart';
import 'package:quiz_td/widget/quizWidget.dart';

class TopWidget extends StatelessWidget {
  const TopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameModel>(builder: (context, gm) {
      if (gm.selectedPlate == null) {
        return const QuizWidget();
      }
      if (gm.selectedPlate.building == null) {
        return const BuilderWidget();
      }
      return Placeholder();
    });
  }
}
