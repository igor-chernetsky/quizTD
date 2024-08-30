import 'package:quiz_defence/models/fame_model.dart';

class StatsModel {
  GameState state;
  List<FameModel> fameList;

  StatsModel({this.state = GameState.game, this.fameList = const []});
}

enum GameState { start, game, win, loose }
