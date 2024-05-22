import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/cubit/gameCubit.dart';
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
          child: BlocProvider(
              create: (_) => GameCubit(),
              child: BlocBuilder<GameCubit, GameModel>(
                builder: (context, gm) => Column(
                  children: [TopWidget(), ScoreWidget(), PlaygroundWidget()],
                ),
              ))),
    );
  }
}
