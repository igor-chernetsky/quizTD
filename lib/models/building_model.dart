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

enum BuildingType { farm, main, tower, school }

Map<BuildingType, String> buldingNames = {
  BuildingType.farm: 'Farm',
  BuildingType.main: 'Main',
  BuildingType.school: 'School',
  BuildingType.tower: 'Tower'
};

Map<BuildingType, String> buldingDescription = {
  BuildingType.farm:
      'This building brings some amount of gold every season. Amount of gold can be increased with new level of the building.',
  BuildingType.main:
      'This is the MAIN building, the game overs when it\'s destroyed. It can attack one enemy unit. Upgrade it to reach the next epoch.',
  BuildingType.school:
      'Here you can make upgrades for your building, also each SCHOOL increase reward for correct answers.',
  BuildingType.tower:
      'This building can attack enemies is specific range, the range can be increased in the SCHOOL.'
};
