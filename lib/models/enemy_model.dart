class EnemyModel {
  late int hp;
  late int max;
  late int dps;
  late bool oneTimeUse = false;
  EnemyType? type;
  int? targetIndex;
  int damege = 0;

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
      case EnemyType.zombie:
        hp = 200;
        dps = 7;
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

enum EnemyType { wolf, meteor, enemy, zombie }
