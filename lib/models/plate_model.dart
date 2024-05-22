import 'dart:math';

import 'package:quiz_td/models/building_model.dart';

class PlateModel {
  Point point;
  BuildingModel? building;
  bool isBuilding;
  PlateModel(
      {this.point = const Point(0, 0), this.isBuilding = false, this.building});
}
