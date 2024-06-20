class StatsModel {
  int range;
  GameState state;

  StatsModel({this.range = 1, this.state = GameState.game});
}

enum GameState { start, game, win, loose }
