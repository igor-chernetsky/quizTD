import 'package:quiz_td/models/enemy_model.dart';
import 'package:quiz_td/models/plate_model.dart';
import 'package:quiz_td/models/upgrade_model.dart';

class GameModel {
  int score;
  List<PlateModel> plates;
  int width;
  int? selectedIndex;
  int? selectedEnemyIndex;
  int epoch;
  int yearNumber;
  double counter;
  List<int> actionUnderAttack;
  late List<EnemyModel?> enemies;
  late UpgradeModel? upgrades;
  GameModel(
      {this.score = 0,
      this.epoch = 1,
      this.width = 3,
      this.yearNumber = 1,
      this.counter = 0,
      this.plates = const [],
      this.enemies = const [],
      this.selectedEnemyIndex,
      this.actionUnderAttack = const [],
      this.selectedIndex,
      this.upgrades}) {
    upgrades ??= UpgradeModel();
    if (enemies.isEmpty) {
      enemies = List.filled(width * 4, null);
    }
  }

  String get epochName {
    switch (epoch) {
      case 4:
        return 'Future day';
      case 3:
        return 'Present';
      case 2:
        return 'Middle ages';
    }
    return 'Stone age';
  }

  PlateModel? get selectedPlate {
    if (selectedIndex == null) {
      return null;
    }
    return plates[selectedIndex!];
  }

  EnemyModel? get selectedEnemy {
    if (selectedEnemyIndex == null) {
      return null;
    }
    if (enemies[selectedEnemyIndex!] == null) {
      selectedEnemyIndex = null;
      return null;
    }
    return enemies[selectedEnemyIndex!];
  }
}
