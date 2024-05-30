import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/models/building_model.dart';
import 'package:quiz_td/models/game_model.dart';
import 'package:quiz_td/models/plate_model.dart';

class GameCubit extends Cubit<GameModel> {
  final int _mainIndex = 4;
  GameCubit()
      : super(GameModel(plates: [
          PlateModel(),
          PlateModel(),
          PlateModel(),
          PlateModel(),
          PlateModel(
            building:
                BuildingModel(hp: 1000, price: 200, type: BuildingType.main),
            hp: 1000,
          ),
          PlateModel(),
          PlateModel(),
          PlateModel(),
          PlateModel()
        ], enemies: List.filled(12, null)));

  GameModel _cloneModel() {
    List<PlateModel> plates = [...state.plates];
    return GameModel(
        epoch: state.epoch,
        score: state.score,
        plates: plates,
        selectedIndex: state.selectedIndex,
        yearNumber: state.yearNumber,
        counter: state.counter,
        width: state.width);
  }

  void addScore(int s) {
    int delta = s * 10 * state.epoch;
    if (state.score + delta >= 0) {
      GameModel res = _cloneModel();
      res.score = state.score + delta;
      return emit(res);
    } else {
      GameModel res = _cloneModel();
      PlateModel mainPlate = res.plates[_mainIndex];
      mainPlate.hp += delta;
      return emit(res);
    }
  }

  void build(BuildingModel building) {
    if (state.score < building.price * state.epoch) {
      return;
    }
    GameModel res = _cloneModel();
    res.plates[state.selectedIndex!] =
        PlateModel(building: building, buildProgress: 0, level: state.epoch);
    res.score = res.score - building.price * res.epoch;
    res.selectedIndex = null;
    emit(res);
  }

  void cancelBuilding() {
    GameModel res = _cloneModel();
    PlateModel seletedPlate = res.plates[state.selectedIndex!];
    int price = seletedPlate.building!.price * seletedPlate.level;
    seletedPlate.building = null;
    seletedPlate.buildProgress = null;
    res.selectedIndex = null;
    res.score += price;
    return emit(res);
  }

  void sellBuilding() {
    GameModel res = _cloneModel();
    PlateModel seletedPlate = res.plates[state.selectedIndex!];
    int price =
        (seletedPlate.building!.price * seletedPlate.level * 0.7).toInt();
    seletedPlate.building = null;
    seletedPlate.buildProgress = null;
    res.selectedIndex = null;
    res.score += price;
    return emit(res);
  }

  void nextEpoch() {
    GameModel res = _cloneModel();
    PlateModel seletedPlate = res.plates[state.selectedIndex!];
    int price = seletedPlate.building!.price;
    if (state.epoch == 5 || state.score < price) {
      return;
    }
    seletedPlate.level++;
    res.epoch++;
    seletedPlate.hp += seletedPlate.building!.hp;
    res.score -= price;
    res.selectedIndex = null;
    return emit(res);
  }

  void upgradeBuilding() {
    GameModel res = _cloneModel();
    PlateModel seletedPlate = res.plates[state.selectedIndex!];
    int price = seletedPlate.building!.price * seletedPlate.level;
    if (seletedPlate.level >= state.epoch || state.score < price) {
      return;
    }
    seletedPlate.level++;
    seletedPlate.buildProgress = seletedPlate.hp;
    res.score -= price;
    res.selectedIndex = null;
    return emit(res);
  }

  void selectPlate(int? index) {
    GameModel res = _cloneModel();
    res.selectedIndex =
        index == null || state.selectedIndex == index ? null : index;
    return emit(res);
  }

  void changeState() {
    GameModel res = _cloneModel();
    res.counter += 0.01;
    for (var p in res.plates) {
      if (p.building == null || p.buildProgress == p.building!.hp * p.level) {
        p.buildProgress = null;
      } else if (p.buildProgress != null) {
        p.buildProgress = p.buildProgress! + 1;
        p.hp++;
      }
    }
    if (res.counter >= 1) {
      res.counter = 0;
      res.yearNumber++;
      res.score += getIncome();
    }
    Future.delayed(const Duration(milliseconds: 500), () {
      changeState();
    });

    return emit(res);
  }

  int getIncome() {
    int income = 0;
    for (var p in state.plates) {
      if (p.building?.type == BuildingType.farm && p.buildProgress == null) {
        income += p.level * 30;
      }
    }
    return income;
  }
}
