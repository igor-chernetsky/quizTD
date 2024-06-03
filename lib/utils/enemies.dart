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
    ...List.filled(5, EnemyType.meteor),
  ],
  ...[
    ...List.filled(3, EnemyType.wolf),
    ...List.filled(15, EnemyType.enemy),
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
    var t = DayMapItem(enemies: enemies, width: width);
    return t;
  }

  static int? getTargetByIndex(int index, int width, List<PlateModel> plates) {
    if (index < width) {
      for (int i = index, count = 0; count < width; i += width, count++) {
        if (plates[i].building != null) {
          return i;
        }
      }
    } else if (index < 2 * width) {
      int row = index - width + 1;
      for (int i = width * row - 1, count = 0; count < width; i--, count++) {
        if (plates[i].building != null) {
          return i;
        }
      }
    } else if (index < 3 * width) {
      int delta = index - 2 * width;
      for (int i = width * (width - 1) + delta, count = 0;
          count < width;
          i -= width, count++) {
        if (plates[i].building != null) {
          return i;
        }
      }
    } else if (index < 4 * width) {
      int row = index - 3 * width;
      for (int i = width * row, count = 0; count < width; i++, count++) {
        if (plates[i].building != null) {
          return i;
        }
      }
    }
    return null;
  }
}
