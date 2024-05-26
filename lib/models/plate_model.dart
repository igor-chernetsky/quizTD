import 'package:quiz_td/models/building_model.dart';

class PlateModel {
  BuildingModel? building;
  int? buildProgress;
  int hp;
  int level;

  PlateModel({this.building, this.hp = 0, this.buildProgress, this.level = 1});

  int? get topHP {
    if (building?.hp == null) {
      return null;
    }
    return level * building!.hp;
  }
}
