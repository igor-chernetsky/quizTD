import 'dart:math';

class EnemyModel {
  int hp;
  EnemyType? type;

  EnemyModel({this.hp = 0, this.type});
}

enum EnemyType { wolf, meteor, enemy }

getEnemiesByEpoch(int epoch, int width) {
  var rng = Random();
  List<EnemyModel?> res = List.filled(width * 4, null);
  switch (epoch) {
    case 1:
      res[rng.nextInt(width * 4)] = EnemyModel(hp: 50, type: EnemyType.wolf);
      break;
    case 2:
      res[rng.nextInt(width * 4)] = EnemyModel(hp: 50, type: EnemyType.wolf);
      break;
  }
}
