import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_defence/cubit/gameCubit.dart';
import 'package:quiz_defence/cubit/questionCubit.dart';
import 'package:quiz_defence/cubit/statsCubit.dart';
import 'package:quiz_defence/models/fame_model.dart';
import 'package:quiz_defence/models/stats_model.dart';
import 'package:quiz_defence/utils/colors.dart';
import 'package:quiz_defence/widget/infoWidgets/looseWidget.dart';
import 'package:quiz_defence/widget/infoWidgets/winWidget.dart';
import 'package:quiz_defence/widget/playgroundWidget.dart';
import 'package:quiz_defence/widget/topWidget.dart';

class GameScreen extends StatelessWidget {
  static String routeName = '/game';

  const GameScreen({super.key});

  getStateWidget(GameState state) {
    switch (state) {
      case GameState.win:
        return [const WinWidget()];
      case GameState.loose:
        return [const LooseWidget()];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: MultiBlocProvider(
            providers: [
              BlocProvider<GameCubit>(
                create: (BuildContext context) => GameCubit()
                  ..resetState()
                  ..changeState(),
              ),
              BlocProvider<QuestionCubit>(
                create: (BuildContext context) =>
                    QuestionCubit()..setQuestions(1, 0),
              ),
              BlocProvider<StatsCubit>(
                create: (BuildContext context) => StatsCubit(),
              ),
            ],
            child: BlocBuilder<StatsCubit, StatsModel>(
              builder: (context, sm) {
                context.read<GameCubit>().onWin =
                    (FameModel fame) => context.read<StatsCubit>().setWin(fame);
                context.read<GameCubit>().onLose = (FameModel fame) =>
                    context.read<StatsCubit>().setLoose(fame);
                return Stack(
                  children: [
                    const Column(
                      children: [PlaygroundWidget(), TopWidget()],
                    ),
                    ...getStateWidget(sm.state),
                  ],
                );
              },
            )),
      ),
    );
  }
}
