import 'dart:math';

import 'package:quiz_td/models/enemy_model.dart';
import 'package:quiz_td/models/plate_model.dart';

class DayMapItem {
  List<EnemyType?> enemies;
  final int width;

  DayMapItem({this.enemies = const [], this.width = 12}) {
    while (enemies.length < width) {
      enemies.add(null);
    }
    enemies.shuffle();
  }
}

var epochList = [
  ...[
    ...List.filled(12, EnemyType.wolf),
    ...List.filled(3, EnemyType.meteor),
  ],
  ...[
    ...List.filled(3, EnemyType.wolf),
    ...List.filled(15, EnemyType.enemy),
    ...List.filled(8, EnemyType.meteor),
  ],
  ...[
    ...List.filled(12, EnemyType.zombie),
    ...List.filled(5, EnemyType.enemy),
    ...List.filled(8, EnemyType.meteor),
  ],
  ...[
    ...List.filled(8, EnemyType.zombie),
    ...List.filled(8, EnemyType.helicopter),
    ...List.filled(8, EnemyType.meteor),
  ]
];

class EpochHelper {
  static int _counter = 0;
  static DayMapItem? getDayItem(int count, int width) {
    if (_counter >= epochList.length) {
      return null;
    }
    List<EnemyType?> enemies = [];
    var res = epochList.getRange(_counter, _counter + count).toList()
        as List<EnemyType?>;
    enemies.addAll(res);
    _counter = _counter + count;
    return DayMapItem(enemies: enemies, width: width);
  }

  static void resetCounter() {
    _counter = 0;
  }

  static int? getTargetByIndex(
      int index, int width, List<PlateModel> plates, int range) {
    if (index < width) {
      for (int i = index, count = 0; count < range; i += width, count++) {
        if (plates[i].building != null) {
          return i;
        }
      }
    } else if (index < 2 * width) {
      int row = index - width + 1;
      for (int i = width * row - 1, count = 0; count < range; i--, count++) {
        if (plates[i].building != null) {
          return i;
        }
      }
    } else if (index < 3 * width) {
      int delta = index - 2 * width;
      for (int i = width * (width - 1) + delta, count = 0;
          count < range;
          i -= width, count++) {
        if (plates[i].building != null) {
          return i;
        }
      }
    } else if (index < 4 * width) {
      int row = index - 3 * width;
      for (int i = width * row, count = 0; count < range; i++, count++) {
        if (plates[i].building != null) {
          return i;
        }
      }
    }
    return null;
  }

  static setBuildingTarget(PlateModel p, List<EnemyModel?> enemies) {
    if (p.targetIndex == null) {
      int enemyIndex = enemies.indexWhere((e) => e != null);
      if (enemyIndex != -1) {
        p.targetIndex = enemyIndex;
      }
    }
    if (p.targetIndex != null) {
      if (enemies[p.targetIndex!] != null) {
        enemies[p.targetIndex!]!.hp -= p.dps;
        if (enemies[p.targetIndex!]!.hp <= 0) {
          enemies[p.targetIndex!] = null;
          p.targetIndex = null;
        }
      } else {
        p.targetIndex = null;
      }
    }
  }

  static List<int> getTowerPotential(int index, int width, int range) {
    Map<int, List<int>> targetsMap = {
      0: [0, 9],
      1: [1, 0, 2],
      2: [2, 3],
      3: [10, 11, 9],
      4: [],
      5: [4, 3, 5],
      6: [11, 6],
      7: [6, 7, 8],
      8: [5, 8]
    };

    if (range == 2) {
      targetsMap = {
        0: [0, 9, 10, 1],
        1: [1, 0, 2, 9, 3],
        2: [2, 3, 1, 4],
        3: [10, 11, 9, 6, 0],
        4: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],
        5: [4, 3, 5, 2, 8],
        6: [11, 6, 10, 7],
        7: [6, 7, 8, 11, 5],
        8: [5, 8, 7, 4]
      };
    }

    return targetsMap[index] ?? [];
  }

  static setRangeBuildingTarget(PlateModel p, List<EnemyModel?> enemies,
      int index, int width, int range) {
    if (p.targetIndex == null) {
      int enemyIndex = -1;
      for (int i = 0; i < enemies.length; i++) {
        if (enemies[i] != null &&
            getTowerPotential(index, width, range).contains(i)) {
          enemyIndex = i;
          break;
        }
      }
      if (enemyIndex != -1) {
        p.targetIndex = enemyIndex;
      }
    }
    if (p.targetIndex != null) {
      if (enemies[p.targetIndex!] != null) {
        enemies[p.targetIndex!]!.hp -= p.dps;
        if (enemies[p.targetIndex!]!.hp <= 0) {
          enemies[p.targetIndex!] = null;
          p.targetIndex = null;
        }
      } else {
        p.targetIndex = null;
      }
    }
  }

  static generateEnemies(int width, int year) {
    int min = 0;
    int max = width * 4;
    if (year < 4) {
      max = 2;
    } else if (year < 5) {
      max = 3;
    } else if (year < 8) {
      max = 4;
    } else if (year < 12) {
      min = 1;
      max = 5;
    } else if (year < 17) {
      min = 1;
      max = 6;
    } else if (year < 24) {
      min = 2;
      max = 7;
    } else {
      min = 3;
    }
    Random rnd = Random();
    int count = rnd.nextInt(max) + min;
    var k = EpochHelper.getDayItem(count, width * 4);
    return k?.enemies;
  }
}
