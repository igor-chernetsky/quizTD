import 'package:quiz_defence/models/fame_model.dart';

class StatsModel {
  GameState state;
  int level;
  List<FameModel> fameList;

  StatsModel(
      {this.state = GameState.game, this.fameList = const [], this.level = 0});
}

enum GameState { start, game, win, loose }
