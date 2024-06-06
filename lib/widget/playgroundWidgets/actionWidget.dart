import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/cubit/gameCubit.dart';
import 'package:quiz_td/models/enemy_model.dart';
import 'package:quiz_td/models/game_model.dart';
import 'package:quiz_td/widget/infoWidgets/healthBarWidget.dart';

class ActionWidget extends StatelessWidget {
  final double size;
  final int index;
  final Function? onTap;

  const ActionWidget(
      {super.key, required this.size, required this.index, this.onTap});

  getEnemyImg(EnemyModel? enemy, double size) {
    String enemyImg = 'assets/img/wolf.png';
    switch (enemy?.type) {
      case EnemyType.wolf:
        enemyImg = 'assets/img/wolf.png';
        break;
      case EnemyType.enemy:
        enemyImg = 'assets/img/enemy.png';
        break;
      case EnemyType.meteor:
        enemyImg = 'assets/img/meteor.png';
        break;
      default:
        return [];
    }
    return [
      Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(enemyImg)))),
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
                          ...getEnemyImg(gm.enemies[index], size - 20),
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
