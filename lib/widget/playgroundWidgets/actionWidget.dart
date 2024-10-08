import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_defence/cubit/gameCubit.dart';
import 'package:quiz_defence/models/enemy_model.dart';
import 'package:quiz_defence/models/game_model.dart';
import 'package:quiz_defence/widget/infoWidgets/healthBarWidget.dart';

class ActionWidget extends StatelessWidget {
  final double size;
  final int width;
  final int index;
  final Function? onTap;

  const ActionWidget(
      {super.key,
      required this.size,
      required this.index,
      required this.width,
      this.onTap});

  getTransformWrapper(int index, Widget child) {
    if (index >= width * 3) {
      return Transform.flip(flipX: true, child: child);
    }
    double angle = -1.57;
    if (index >= 2 * width) {
      angle = 1.57;
    } else if (index >= width) {
      angle = 0;
    }
    return Transform.rotate(angle: angle, child: child);
  }

  getEnemyImg(BuildContext context, EnemyModel? enemy, double size) {
    if (enemy?.type == EnemyType.meteor) {
      Future.delayed(const Duration(milliseconds: 1020),
          () => context.read<GameCubit>().removeEnemy(index));
    }
    String enemyImg = 'assets/img/wolf.gif';
    switch (enemy?.type) {
      case EnemyType.wolf:
        enemyImg = 'assets/img/wolf.gif';
        break;
      case EnemyType.enemy:
        enemyImg = 'assets/img/enemy.gif';
        break;
      case EnemyType.zombie:
        enemyImg = 'assets/img/zombie.gif';
        break;
      case EnemyType.helicopter:
        enemyImg = 'assets/img/helicopter.gif';
        break;
      case EnemyType.meteor:
        enemyImg = 'assets/img/meteor.gif';
        break;
      default:
        return [];
    }
    return [
      getTransformWrapper(
          index,
          Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(enemyImg))))),
      HealthbarWidget(hp: enemy!.hp / enemy.max, width: size)
    ];
  }

  getAttackWrapper(GameModel gm, Widget child) {
    if (gm.actionUnderAttack.contains(index)) {
      return Stack(
        children: [
          child,
          Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
                color: Color(0x22FF073A),
                borderRadius: BorderRadius.all(Radius.circular(4))),
          )
        ],
      );
    }
    return child;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameModel>(
        builder: (context, gm) => GestureDetector(
              onTap: () => onTap != null ? onTap!() : null,
              child: getAttackWrapper(
                gm,
                Transform.scale(
                  scale: gm.selectedEnemyIndex == index ? 1.2 : 1,
                  child: SizedBox(
                    height: size,
                    width: size,
                    child: GestureDetector(
                      child: Column(
                        children: [
                          ...getEnemyImg(context, gm.enemies[index], size - 20),
                        ],
                      ),
                      onTap: () => gm.enemies[index] == null
                          ? null
                          : context.read<GameCubit>().selectEnemy(index),
                    ),
                  ),
                ),
              ),
            ));
  }
}
