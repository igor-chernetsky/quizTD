import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FameModel {
  String? id;
  int year;
  int epoch;
  int level;
  FameModel({required this.year, required this.epoch, this.id, this.level = 0});
}

class ThemeItem {
  int id;
  String img;
  int? level;
  String name;
  int multiply;
  ThemeItem(
      {required this.id,
      required this.name,
      required this.multiply,
      required this.img,
      this.level = 0});
}

List<ThemeItem> themeItems = [
  ThemeItem(id: 0, name: 'Elementary Math 1', multiply: 1, img: 'math1.png'),
  ThemeItem(id: 1, name: 'Elementary Math 2', multiply: 2, img: 'math2.png'),
  ThemeItem(id: 3, name: 'Elementary Math 3', multiply: 3, img: 'math3.png'),
  ThemeItem(id: 2, name: 'Geograply', multiply: 1, img: 'geo1.png'),
  ThemeItem(id: 4, name: 'Flags', multiply: 1, img: 'geo2.png'),
  ThemeItem(id: 5, name: 'History', multiply: 1, img: 'history.png'),
];
getThemeName(AppLocalizations locale, int id) {
  switch (id) {
    case 0:
      return locale.math1;
    case 1:
      return locale.math2;
    case 2:
      return locale.geo;
    case 3:
      return locale.math3;
    case 4:
      return locale.flag;
    case 5:
      return locale.history;
  }
}
