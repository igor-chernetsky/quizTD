import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_defence/cubit/gameCubit.dart';
import 'package:quiz_defence/models/game_model.dart';
import 'package:quiz_defence/widget/infoWidgets/healthBarWidget.dart';

class SeasonWidget extends StatelessWidget {
  final double size;
  const SeasonWidget({super.key, required this.size});

  Icon getSeasonIcon(double counter) {
    if (counter < 0.25) {
      return const Icon(Icons.sunny, size: 38, color: Colors.amber);
    } else if (counter < 0.5) {
      return const Icon(Icons.cloud, size: 38, color: Colors.lightBlue);
    } else if (counter < 0.75) {
      return const Icon(Icons.ac_unit, size: 38, color: Colors.white70);
    }
    return const Icon(Icons.local_florist, size: 38, color: Colors.green);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameModel>(
      builder: (context, gm) => SizedBox(
        height: size,
        width: size,
        child: Card(
          color: const Color.fromRGBO(0, 0, 0, 0.6),
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                getSeasonIcon(gm.counter),
                HealthbarWidget(hp: gm.counter, width: size - 20)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
