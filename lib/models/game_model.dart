import 'package:quiz_td/models/plate_model.dart';

class GameModel {
  int score;
  List<PlateModel> plates;
  int width;
  int? selectedIndex;
  GameModel(
      {this.score = 0,
      this.width = 3,
      this.plates = const [],
      this.selectedIndex});

  get selectedPlate {
    if (selectedIndex == null) {
      return null;
    }
    return plates[selectedIndex!];
  }
}
