class BuildingModel {
  int hp;
  int price;
  BuildingType? type;
  int dps;

  BuildingModel({this.hp = 0, this.price = 0, this.dps = 0, this.type});
}

enum BuildingType { farm, warhouse, main }
