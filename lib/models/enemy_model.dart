import 'dart:math';

class EnemyModel {
  late int hp;
  late int max;
  late int dps;
  late bool oneTimeUse = false;
  EnemyType? type;
  int? targetIndex;

  EnemyModel({this.type}) {
    switch (type) {
      case EnemyType.wolf:
        hp = 20;
        dps = 2;
        break;
      case EnemyType.enemy:
        hp = 100;
        dps = 5;
        break;
      case EnemyType.meteor:
        hp = 20;
        dps = 200;
        oneTimeUse = true;
        break;
      default:
        hp = 1;
        dps = 1;
    }
    max = hp;
  }
}

enum EnemyType { wolf, meteor, enemy }

getEnemiesByEpoch(int epoch, int width) {
  var rng = Random();
  List<EnemyModel?> res = List.filled(width * 4, null);
  switch (epoch) {
    case 1:
      res.add(EnemyModel(type: EnemyType.wolf));
      break;
    case 2:
      res[rng.nextInt(width * 4)] = EnemyModel(type: EnemyType.enemy);
      break;
  }
}
