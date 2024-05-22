class BuildingModel {
  int hp;
  int price;
  BuildingType? type;

  BuildingModel({this.hp = 0, this.price = 0, this.type});
}

enum BuildingType { farm, warhouse, main }
