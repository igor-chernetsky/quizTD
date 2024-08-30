import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_defence/cubit/gameCubit.dart';
import 'package:quiz_defence/models/game_model.dart';

class ClosePlateButton extends StatelessWidget {
  const ClosePlateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameModel>(
        builder: (context, gm) => Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Align(
                alignment: Alignment.bottomRight,
                child: IconButton.outlined(
                  onPressed: () => context.read<GameCubit>().selectPlate(null),
                  icon: const Icon(Icons.close),
                ),
              ),
            ));
  }
}
