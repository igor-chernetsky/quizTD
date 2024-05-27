import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/cubit/gameCubit.dart';
import 'package:quiz_td/cubit/questionCubit.dart';
import 'package:quiz_td/models/game_model.dart';
import 'package:quiz_td/widget/playgroundWidget.dart';
import 'package:quiz_td/widget/scoreWidget.dart';
import 'package:quiz_td/widget/topWidget.dart';

class GameScreen extends StatelessWidget {
  static String routeName = '/game';

  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: MultiBlocProvider(
              providers: [
            BlocProvider<GameCubit>(
              create: (BuildContext context) => GameCubit()..changeState(),
            ),
            BlocProvider<QuestionCubit>(
              create: (BuildContext context) => QuestionCubit()..setQuestions(),
            ),
          ],
              child: BlocBuilder<GameCubit, GameModel>(
                builder: (context, gm) => const Column(
                  children: [PlaygroundWidget(), ScoreWidget(), TopWidget()],
                ),
              ))),
    );
  }
}
