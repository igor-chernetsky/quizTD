import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

buldingNames(AppLocalizations locale, BuildingType? t) {
  if (t != null) {
    switch (t) {
      case BuildingType.farm:
        return locale.farm;
      case BuildingType.main:
        return locale.main;
      case BuildingType.tower:
        return locale.tower;
      case BuildingType.school:
        return locale.school;
    }
  }
}
