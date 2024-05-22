import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/cubit/gameCubit.dart';
import 'package:quiz_td/models/game_model.dart';
import 'package:quiz_td/utils/colors.dart';

class ScoreWidget extends StatelessWidget {
  const ScoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameModel>(
      builder: (context, gm) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Card(
          child: SizedBox(
            height: 40,
            width: double.infinity,
            child: Text('${gm.score}',
                style: TextStyle(
                    color: AppColors.accentColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
