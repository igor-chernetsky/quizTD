import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/cubit/gameCubit.dart';
import 'package:quiz_td/models/game_model.dart';
import 'package:quiz_td/utils/colors.dart';

class ScoreWidget extends StatelessWidget {
  final double size;
  const ScoreWidget({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    int income = context.read<GameCubit>().getIncome();
    return BlocBuilder<GameCubit, GameModel>(
      builder: (context, gm) => SizedBox(
        height: size,
        width: size,
        child: Card(
          color: const Color.fromRGBO(0, 0, 0, 0.4),
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('\$${gm.score}',
                    style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('+$income/',
                        style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                    Icon(
                      Icons.sunny,
                      color: AppColors.textColor,
                      size: 16,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
