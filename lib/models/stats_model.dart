import 'package:quiz_td/models/fame_model.dart';

class StatsModel {
  GameState state;
  List<FameModel> fameList;

  StatsModel({this.state = GameState.game, this.fameList = const []});
}

enum GameState { start, game, win, loose }
