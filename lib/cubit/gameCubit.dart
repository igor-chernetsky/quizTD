import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/models/building_model.dart';
import 'package:quiz_td/models/game_model.dart';
import 'package:quiz_td/models/plate_model.dart';

class GameCubit extends Cubit<GameModel> {
  GameCubit() : super(GameModel(plates: List.filled(9, PlateModel())));

  void addScore(int s) {
    if (state.score + s >= 0) {
      return emit(GameModel(
          score: state.score + s,
          plates: state.plates,
          selectedIndex: state.selectedIndex,
          width: state.width));
    }
  }

  void build(BuildingModel building) {
    List<PlateModel> plates = [...state.plates];
    plates[state.selectedIndex!] = PlateModel(building: building);
    GameModel res = GameModel(
        score: state.score,
        plates: plates,
        selectedIndex: null,
        width: state.width);
    return emit(res);
  }

  void selectPlate(int index) {
    GameModel res = GameModel(
        score: state.score,
        plates: state.plates,
        selectedIndex: state.selectedIndex == index ? null : index,
        width: state.width);
    return emit(res);
  }
}
