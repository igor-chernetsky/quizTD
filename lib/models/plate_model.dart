import 'dart:math';

import 'package:quiz_td/models/building_model.dart';

class PlateModel {
  Point point;
  BuildingModel? building;
  int? buildProgress;
  int hp;

  PlateModel(
      {this.point = const Point(0, 0),
      this.building,
      this.hp = 0,
      this.buildProgress});
}
