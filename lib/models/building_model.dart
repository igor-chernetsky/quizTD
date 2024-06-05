class BuildingModel {
  int hp;
  int price;
  BuildingType? type;
  int dps;
  int buildSpeed;

  BuildingModel(
      {this.hp = 0,
      this.price = 0,
      this.dps = 0,
      this.buildSpeed = 1,
      this.type});
}

enum BuildingType { farm, warhouse, main, tower }
