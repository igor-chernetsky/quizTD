class FameModel {
  String? id;
  int year;
  int epoch;
  int level;
  FameModel({required this.year, required this.epoch, this.id, this.level = 0});
}

Map<int, String> levelNameMap = {
  0: 'Elementary Math 1',
  1: 'Elementary Math 2',
  2: 'Geograply',
  3: 'Basic English',
};

Map<int, int> levelMultiplyMap = {
  0: 1,
  1: 2,
  2: 1,
  3: 1,
};
