import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/models/stats_model.dart';

class StatsCubit extends Cubit<StatsModel> {
  StatsCubit() : super(StatsModel());

  StatsModel _cloneModel() {
    StatsModel res = StatsModel(range: state.range, state: state.state);
    return res;
  }

  void setWin() {
    StatsModel res = _cloneModel();
    res.state = GameState.win;
    return emit(res);
  }

  void setLoose() {
    StatsModel res = _cloneModel();
    res.state = GameState.loose;
    return emit(res);
  }
}
