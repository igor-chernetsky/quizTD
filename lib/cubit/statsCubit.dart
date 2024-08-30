import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_defence/main.dart';
import 'package:quiz_defence/models/fame_model.dart';
import 'package:quiz_defence/models/stats_model.dart';

class StatsCubit extends Cubit<StatsModel> {
  StatsCubit() : super(StatsModel());

  StatsModel _cloneModel() {
    StatsModel res = StatsModel(state: state.state, fameList: state.fameList);
    return res;
  }

  void initFame(Future<List<FameModel>> famesGetter) {
    famesGetter.then((fames) {
      StatsModel res = _cloneModel();
      res.fameList = fames;
      print(fames);
      return emit(res);
    });
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
