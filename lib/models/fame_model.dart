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
  ThemeItem(id: 0, name: 'Elementary Math 1', multiply: 1, img: 'ep1.png'),
  ThemeItem(id: 1, name: 'Elementary Math 2', multiply: 2, img: 'ep2.png'),
  ThemeItem(id: 1, name: 'Geograply', multiply: 1, img: 'ep3.png'),
];
