import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/models/building_model.dart';
import 'package:quiz_td/models/enemy_model.dart';
import 'package:quiz_td/models/game_model.dart';
import 'package:quiz_td/models/plate_model.dart';
import 'package:quiz_td/utils/enemies.dart';

class GameCubit extends Cubit<GameModel> {
  final int _mainIndex = 4;
  final int TOWER_RANGE = 1;
  GameCubit()
      : super(GameModel(plates: [
          PlateModel(),
          PlateModel(),
          PlateModel(),
          PlateModel(),
          PlateModel(
            building: BuildingModel(
                hp: 1000, price: 200, type: BuildingType.main, dps: 1),
            hp: 1000,
          ),
          PlateModel(),
          PlateModel(),
          PlateModel(),
          PlateModel()
        ]));

  GameModel _cloneModel() {
    List<PlateModel> plates = [...state.plates];
    GameModel res = GameModel(
        epoch: state.epoch,
        score: state.score,
        plates: plates,
        selectedIndex: state.selectedIndex,
        selectedEnemyIndex: state.selectedEnemyIndex,
        yearNumber: state.yearNumber,
        counter: state.counter,
        enemies: state.enemies,
        actionUnderAttack: state.actionUnderAttack,
        width: state.width);
    return res;
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
    BuildingType? sellType = seletedPlate.building?.type;
    seletedPlate.building = null;
    seletedPlate.buildProgress = null;
    res.selectedIndex = null;
    res.score += price;
    if (sellType == BuildingType.tower) {
      _setUnderAttackActions(res);
    }
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
    res.selectedEnemyIndex = null;
    res.selectedIndex =
        index == null || state.selectedIndex == index ? null : index;
    return emit(res);
  }

  void selectEnemy(int? index) {
    GameModel res = _cloneModel();
    res.selectedIndex = null;
    res.selectedEnemyIndex =
        index == null || state.selectedEnemyIndex == index ? null : index;
    return emit(res);
  }

  void changeState() {
    GameModel res = _cloneModel();
    res.counter += 0.02;
    for (int i = 0; i < res.plates.length; i++) {
      _changeBuildState(res.plates[i], res);
      _buildingAttack(res.plates[i], i, res.enemies);
    }
    _enemyAttack(res);
    double cnt = double.parse(res.counter.toStringAsFixed(2));
    if (cnt == 1 || cnt == 0.5 || cnt == 0.26 || cnt == 0.76) {
      var enemies = EpochHelper.generateEnemies(res.width, res.yearNumber);
      if (enemies != null) {
        for (int i = 0; i < enemies.length; i++) {
          if (enemies[i] != null) {
            res.enemies[i] = EnemyModel(type: enemies[i]);
          }
        }
      } else {
        // TODO: game over
      }
      if (cnt == 1) {
        res.counter = 0;
        res.yearNumber++;
        res.score += getIncome();
      }
    }
    Future.delayed(const Duration(milliseconds: 500), () {
      changeState();
    });

    return emit(res);
  }

  void removeEnemy(int index) {
    GameModel res = _cloneModel();
    res.enemies[index] = null;
  }

  void _changeBuildState(PlateModel p, GameModel res) {
    if (p.building == null || p.buildProgress == p.building!.hp * p.level) {
      p.buildProgress = null;
      if (p.building?.type == BuildingType.tower) {
        _setUnderAttackActions(res);
      }
    } else if (p.buildProgress != null) {
      p.buildProgress = p.buildProgress! + p.building!.buildSpeed;
      p.hp += p.building!.buildSpeed;
    }
  }

  void _enemyAttack(GameModel res) {
    for (int i = 0; i < res.enemies.length; i++) {
      if (res.enemies[i] != null) {
        EnemyModel enemy = res.enemies[i]!;
        if (enemy.targetIndex == null) {
          int? targetIndex =
              EpochHelper.getTargetByIndex(i, res.width, res.plates);
          print(targetIndex);
          // remove enemy if nothing to attack
          if (targetIndex == null) {
            res.enemies[i] = null;
          } else {
            enemy.targetIndex = targetIndex;
          }
        } else {
          res.plates[enemy.targetIndex!].hp -= enemy.dps;
          if (res.plates[enemy.targetIndex!].hp <= 0) {
            BuildingType? destroyedType =
                res.plates[enemy.targetIndex!].building?.type;
            res.plates[enemy.targetIndex!] = PlateModel();
            if (destroyedType == BuildingType.tower) {
              _setUnderAttackActions(res);
            }
            enemy.targetIndex = null;
          }
        }
      }
    }
  }

  void _buildingAttack(PlateModel p, int index, List<EnemyModel?> enemies) {
    if (p.building?.type == BuildingType.main) {
      EpochHelper.setBuildingTarget(p, enemies);
    } else if (p.building?.type == BuildingType.tower) {
      EpochHelper.setRangeBuildingTarget(
          p, enemies, index, state.width, TOWER_RANGE);
    }
  }

  void _setUnderAttackActions(GameModel res) {
    List<int> potential = [];
    for (int i = 0; i < res.plates.length; i++) {
      if (res.plates[i].building?.type == BuildingType.tower &&
          res.plates[i].buildProgress == null) {
        potential
            .addAll(EpochHelper.getTowerPotential(i, res.width, TOWER_RANGE));
      }
    }
    res.actionUnderAttack = potential.toSet().toList();
  }

  int getIncome() {
    int income = 0;
    for (var p in state.plates) {
      if (p.building?.type == BuildingType.farm && p.buildProgress == null) {
        income += p.income;
      }
    }
    return income;
  }
}
