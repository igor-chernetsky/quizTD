import 'dart:ui';

import 'package:quiz_defence/models/fame_model.dart';

class StatsModel {
  GameState state;
  late ThemeItem theme;
  late List<ThemeItem> top;
  List<FameModel> fameList;
  Locale locale;

  StatsModel(
      {this.state = GameState.game,
      this.locale = const Locale('en'),
      this.fameList = const []}) {
    theme = themeItems[0];
    top = themeItems;
  }
}

enum GameState { start, game, win, loose }
