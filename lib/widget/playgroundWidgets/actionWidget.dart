import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/cubit/gameCubit.dart';
import 'package:quiz_td/models/enemy_model.dart';
import 'package:quiz_td/models/game_model.dart';
import 'package:quiz_td/widget/infoWidgets/healthBarWidget.dart';

class ActionWidget extends StatelessWidget {
  final double size;
  final int index;
  const ActionWidget({super.key, required this.size, required this.index});

  drawEnemy(EnemyModel? enemy) {
    switch (enemy?.type) {
      case EnemyType.wolf:
        return Column(
          children: [
            const Text('wolf'),
            HealthbarWidget(hp: enemy!.hp / enemy.max, width: size)
          ],
        );
      case EnemyType.enemy:
        return Column(
          children: [
            const Text('enemy'),
            HealthbarWidget(hp: enemy!.hp / enemy.max, width: size)
          ],
        );
      case EnemyType.meteor:
        return Column(
          children: [
            const Text('Meteor'),
            HealthbarWidget(hp: enemy!.hp / enemy.max, width: size)
          ],
        );
      default:
        return Text(index.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameModel>(
        builder: (context, gm) => SizedBox(
              height: size,
              width: size,
              child: drawEnemy(gm.enemies[index]),
            ));
  }
}
