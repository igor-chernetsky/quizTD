class FameModel {
  String? id;
  int year;
  int epoch;
  int level;
  FameModel({required this.year, required this.epoch, this.id, this.level = 0});
}
