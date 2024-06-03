import 'package:quiz_td/models/enemy_model.dart';
import 'package:quiz_td/models/plate_model.dart';

class GameModel {
  int score;
  List<PlateModel> plates;
  int width;
  int? selectedIndex;
  int epoch;
  int yearNumber;
  double counter;
  late List<EnemyModel?> enemies;
  GameModel(
      {this.score = 0,
      this.epoch = 1,
      this.width = 3,
      this.yearNumber = 1,
      this.counter = 0,
      this.plates = const [],
      this.enemies = const [],
      this.selectedIndex}) {
    if (enemies.isEmpty) {
      enemies = List.filled(width * 4, null);
    }
  }

  PlateModel? get selectedPlate {
    if (selectedIndex == null) {
      return null;
    }
    return plates[selectedIndex!];
  }
}
