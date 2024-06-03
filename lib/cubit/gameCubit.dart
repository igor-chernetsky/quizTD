import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/models/building_model.dart';
import 'package:quiz_td/models/enemy_model.dart';
import 'package:quiz_td/models/game_model.dart';
import 'package:quiz_td/models/plate_model.dart';
import 'package:quiz_td/utils/enemies.dart';

class GameCubit extends Cubit<GameModel> {
  final int _mainIndex = 4;
  GameCubit()
      : super(GameModel(plates: [
          PlateModel(),
          PlateModel(),
          PlateModel(),
          PlateModel(),
          PlateModel(
            building: BuildingModel(
                hp: 1000, price: 200, type: BuildingType.main, dps: 2),
            hp: 1000,
          ),
          PlateModel(),
          PlateModel(),
          PlateModel(),
          PlateModel()
        ]));

  GameModel _cloneModel() {
    List<PlateModel> plates = [...state.plates];
    List<EnemyModel?> enemies = [...state.enemies];
    GameModel res = GameModel(
        epoch: state.epoch,
        score: state.score,
        plates: plates,
        selectedIndex: state.selectedIndex,
        yearNumber: state.yearNumber,
        counter: state.counter,
        enemies: enemies,
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
    res.counter += 0.02;
    for (var p in res.plates) {
      _changeBuildState(p);
      _buildingAttack(p, res.enemies);
    }
    _enemyAttack(res);
    if (res.counter >= 1) {
      var enemies = getEnemies();
      if (enemies != null) {
        for (int i = 0; i < enemies.length; i++) {
          if (enemies[i] != null) {
            res.enemies[i] = EnemyModel(type: enemies[i]);
          }
        }
      } else {
        // TODO: game over
      }
      res.counter = 0;
      res.yearNumber++;
      res.score += getIncome();
    }
    Future.delayed(const Duration(milliseconds: 500), () {
      changeState();
    });

    return emit(res);
  }

  void _changeBuildState(PlateModel p) {
    if (p.building == null || p.buildProgress == p.building!.hp * p.level) {
      p.buildProgress = null;
    } else if (p.buildProgress != null) {
      p.buildProgress = p.buildProgress! + 1;
      p.hp++;
    }
  }

  void _enemyAttack(GameModel res) {
    for (int i = 0; i < res.enemies.length; i++) {
      if (res.enemies[i] != null) {
        EnemyModel enemy = res.enemies[i]!;
        if (enemy.targetIndex == null) {
          int? targetIndex =
              EpochHelper.getTargetByIndex(i, res.width, res.plates);
          // remove enemy if nothing to attack
          if (targetIndex == null) {
            res.enemies[i] = null;
          } else {
            enemy.targetIndex = targetIndex;
          }
        } else {
          res.plates[enemy.targetIndex!].hp -= enemy.dps;
          if (res.plates[enemy.targetIndex!].hp <= 0) {
            res.plates[enemy.targetIndex!] = PlateModel();
            enemy.targetIndex = null;
          }
          // remove enemy if it's a one time use
          if (enemy.oneTimeUse) {
            res.enemies[i] = null;
          }
        }
      }
    }
  }

  void _buildingAttack(PlateModel p, List<EnemyModel?> enemies) {
    if (p.building?.type == BuildingType.main) {
      if (p.targetIndex == null) {
        int enemyIndex = enemies.indexWhere((e) => e != null);
        if (enemyIndex != -1) {
          p.targetIndex = enemyIndex;
        }
      }
      if (p.targetIndex != null) {
        if (enemies[p.targetIndex!] != null) {
          enemies[p.targetIndex!]!.hp -= p.dps;
          if (enemies[p.targetIndex!]!.hp <= 0) {
            enemies[p.targetIndex!] = null;
            p.targetIndex = null;
          }
        }
      }
    }
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

  List<EnemyType?>? getEnemies() {
    int min = 0;
    int max = state.width * 4;
    if (state.yearNumber < 4) {
      max = 2;
    } else if (state.yearNumber < 5) {
      max = 3;
    } else if (state.yearNumber < 8) {
      max = 4;
    } else if (state.yearNumber < 12) {
      min = 1;
      max = 5;
    } else if (state.yearNumber < 17) {
      min = 1;
      max = 6;
    } else if (state.yearNumber < 24) {
      min = 2;
      max = 7;
    } else {
      min = 3;
    }
    Random rnd = Random();
    int count = rnd.nextInt(max) + min;
    var k = EpochHelper.getDayItem(count, state.width * 4);
    return k?.enemies;
  }
}
