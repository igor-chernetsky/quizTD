class StatsModel {
  GameState state;

  StatsModel({this.state = GameState.game});
}

enum GameState { start, game, win, loose }
