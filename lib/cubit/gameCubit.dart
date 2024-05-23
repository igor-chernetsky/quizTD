import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/models/building_model.dart';
import 'package:quiz_td/models/game_model.dart';
import 'package:quiz_td/models/plate_model.dart';

class GameCubit extends Cubit<GameModel> {
  GameCubit() : super(GameModel(plates: List.filled(9, PlateModel())));

  void addScore(int s) {
    if (state.score + s >= 0) {
      return emit(GameModel(
          score: state.score + s * 10,
          plates: state.plates,
          selectedIndex: state.selectedIndex,
          width: state.width));
    }
  }

  void build(BuildingModel building) {
    if (state.score < building.price) {
      return;
    }
    List<PlateModel> plates = [...state.plates];
    plates[state.selectedIndex!] =
        PlateModel(building: building, buildProgress: 0);
    GameModel res = GameModel(
        score: state.score - building.price,
        plates: plates,
        selectedIndex: null,
        width: state.width);
    return emit(res);
  }

  void changeState() {
    List<PlateModel> plates = [...state.plates];
    for (var p in plates) {
      if (p.buildProgress == p.building?.hp) {
        p.buildProgress = null;
      } else if (p.buildProgress != null) {
        p.buildProgress = p.buildProgress! + 1;
        p.hp++;
      }
    }
    GameModel res = GameModel(
        score: state.score,
        plates: plates,
        selectedIndex: state.selectedIndex,
        width: state.width);
    Future.delayed(const Duration(milliseconds: 700), () {
      changeState();
    });

    return emit(res);
  }

  void selectPlate(int? index) {
    GameModel res = GameModel(
        score: state.score,
        plates: state.plates,
        selectedIndex:
            index == null || state.selectedIndex == index ? null : index,
        width: state.width);
    return emit(res);
  }
}
