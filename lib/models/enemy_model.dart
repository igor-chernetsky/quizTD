class EnemyModel {
  late int hp;
  late int max;
  late int dps;
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
      case EnemyType.helicopter:
        hp = 500;
        dps = 20;
        break;
      case EnemyType.meteor:
        hp = 20;
        dps = 200;
        break;
      default:
        hp = 1;
        dps = 1;
    }
    max = hp;
  }
}

enum EnemyType { wolf, meteor, enemy, zombie, helicopter }

Map<EnemyType, String> enemyNameMap = {
  EnemyType.wolf: 'Wolf',
  EnemyType.enemy: 'Archer',
  EnemyType.meteor: 'Meteor',
  EnemyType.zombie: 'Zombie',
  EnemyType.helicopter: 'Helicopter'
};

Map<EnemyType, String> enemyDescriptionMap = {
  EnemyType.wolf:
      'Attacks closest building, if the closest cell is empty goes away.',
  EnemyType.enemy: 'Attacks whole line, if line is empty goes away.',
  EnemyType.meteor: 'Hits building on the line.',
  EnemyType.zombie:
      'Attacks whole line, if line is empty goes away. When deals 100 demage new zombie appears nearby.',
  EnemyType.helicopter:
      'Attacks whole line, if the line is empty goes to the next cell.'
};
