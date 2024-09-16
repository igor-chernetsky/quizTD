import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_defence/main.dart';
import 'package:quiz_defence/models/fame_model.dart';
import 'package:quiz_defence/models/stats_model.dart';
import 'dart:math';

class StatsCubit extends Cubit<StatsModel> {
  StatsCubit() : super(StatsModel());

  StatsModel _cloneModel() {
    StatsModel res = StatsModel(
        state: state.state, fameList: state.fameList, locale: state.locale);
    res.theme = state.theme;
    return res;
  }

  void initFame(ThemeItem? theme, Locale? locale) async {
    if (theme != null) {
      state.theme = theme;
    } else {
      List<FameModel> value = await dbHelper.queryTops();
      for (var a in value) {
        for (var b in state.top) {
          if (b.id == a.level) {
            b.level = a.epoch;
          }
        }
      }
    }
    List<FameModel> fames =
        await dbHelper.queryAllRows(10, theme?.id ?? state.theme.id);
    StatsModel res = _cloneModel();
    res.fameList = fames;
    if (locale != null) {
      res.locale = locale;
    }
    if (res.fameList.isNotEmpty) {
      res.theme.level = res.fameList.map((item) => item.epoch).reduce(max);
    }
    return emit(res);
  }

  void resetState() {
    state.state = GameState.start;
    return emit(state);
  }

  void switchLocale(Locale locale) {
    StatsModel res = _cloneModel();
    res.locale = locale;
    return emit(res);
  }

  void setWin(FameModel fame) {
    StatsModel res = _cloneModel();
    res.state = GameState.win;
    res.fameList = [...res.fameList, fame];
    dbHelper.insert(fame);
    return emit(res);
  }

  void setLoose(FameModel fame) {
    StatsModel res = _cloneModel();
    res.state = GameState.loose;
    res.fameList = [...res.fameList, fame];
    dbHelper.insert(fame);
    return emit(res);
  }
}
