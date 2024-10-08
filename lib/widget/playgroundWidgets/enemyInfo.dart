import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_defence/cubit/gameCubit.dart';
import 'package:quiz_defence/models/enemy_model.dart';
import 'package:quiz_defence/models/game_model.dart';

class EnemyInfo extends StatelessWidget {
  final double size;
  final int width;
  final int index;

  const EnemyInfo(
      {super.key,
      required this.size,
      required this.index,
      required this.width});

  getEnemyImg(BuildContext context, EnemyModel? enemy, double size) {
    String enemyImg = 'assets/img/w1.png';
    switch (enemy?.type) {
      case EnemyType.wolf:
        enemyImg = 'assets/img/w1.png';
        break;
      case EnemyType.enemy:
        enemyImg = 'assets/img/archer1.png';
        break;
      case EnemyType.zombie:
        enemyImg = 'assets/img/zombie.png';
        break;
      case EnemyType.helicopter:
        enemyImg = 'assets/img/helicopter.png';
        break;
      case EnemyType.meteor:
        enemyImg = 'assets/img/meteor.png';
        break;
      default:
        return [];
    }
    return Container(
        width: size,
        height: size,
        decoration:
            BoxDecoration(image: DecorationImage(image: AssetImage(enemyImg))));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameModel>(
      builder: (context, gm) => SizedBox(
          height: size,
          width: size,
          child: getEnemyImg(context, gm.enemies[index], size - 20)),
    );
  }
}
