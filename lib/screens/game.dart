import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/cubit/gameCubit.dart';
import 'package:quiz_td/cubit/questionCubit.dart';
import 'package:quiz_td/cubit/statsCubit.dart';
import 'package:quiz_td/models/fame_model.dart';
import 'package:quiz_td/models/stats_model.dart';
import 'package:quiz_td/widget/infoWidgets/looseWidget.dart';
import 'package:quiz_td/widget/infoWidgets/winWidget.dart';
import 'package:quiz_td/widget/playgroundWidget.dart';
import 'package:quiz_td/widget/topWidget.dart';

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
      body: SafeArea(
        child: MultiBlocProvider(
            providers: [
              BlocProvider<GameCubit>(
                create: (BuildContext context) => GameCubit()..changeState(),
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
