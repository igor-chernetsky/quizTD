import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:quiz_defence/models/building_model.dart';
import 'package:quiz_defence/models/enemy_model.dart';
import 'package:quiz_defence/models/fame_model.dart';
import 'package:quiz_defence/models/game_model.dart';
import 'package:quiz_defence/models/plate_model.dart';
import 'package:quiz_defence/models/upgrade_model.dart';
import 'package:quiz_defence/utils/enemies.dart';

class GameCubit extends Cubit<GameModel> {
  final int _mainIndex = 4;
  Function? onWin;
  Function? onLose;
  ThemeItem? theme;
  late Timer _dalayed;

  GameCubit({this.onLose, this.onWin, this.theme}) : super(getDefaultModel());

  GameModel _cloneModel() {
    List<PlateModel> plates = [...state.plates];
    GameModel res = GameModel(
        epoch: state.epoch,
        score: state.score,
        plates: plates,
        theme: state.theme,
        selectedIndex: state.selectedIndex,
        selectedEnemyIndex: state.selectedEnemyIndex,
        yearNumber: state.yearNumber,
        counter: state.counter,
        enemies: state.enemies,
        actionUnderAttack: state.actionUnderAttack,
        upgrades: state.upgrades,
        width: state.width);
    return res;
  }

  void resetState() {
    EpochHelper.resetCounter();
    GameModel res = getDefaultModel();
    if (theme != null) {
      res.theme = theme;
    }
    return emit(res);
  }

  void addScore(int s) {
    int delta = s * state.answerBoost;

    if (state.score + delta >= 0) {
      GameModel res = _cloneModel();
      res.score = state.score + delta;
      return emit(res);
    } else {
      GameModel res = _cloneModel();
      PlateModel mainPlate = res.plates[_mainIndex];
      mainPlate.hp += delta;
      if (mainPlate.hp <= 0) {
        _dalayed.cancel();
        onLose!(FameModel(
            year: res.yearNumber, epoch: res.epoch, level: state.theme!.id));
      }
      return emit(res);
    }
  }

  void build(BuildingModel building, int epoch) {
    if (state.score < building.price * epoch) {
      return;
    }
    GameModel res = _cloneModel();
    res.plates[state.selectedIndex!] =
        PlateModel(building: building, buildProgress: 0, level: epoch);
    res.score = res.score - building.price * epoch;
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

  void repairBuilding() {
    GameModel res = _cloneModel();
    PlateModel seletedPlate = res.plates[state.selectedIndex!];
    double percent =
        (seletedPlate.topHP! - seletedPlate.hp) / (seletedPlate.topHP!);
    int price =
        (seletedPlate.building!.price * seletedPlate.level * percent).toInt();
    if (price < res.score) {
      BuildingType? repairType = seletedPlate.building?.type;
      seletedPlate.buildProgress = seletedPlate.hp;
      res.score -= price;
      if (repairType == BuildingType.tower) {
        _setUnderAttackActions(res);
      }
    }
    return emit(res);
  }

  int nextEpoch(bool isFree) {
    GameModel res = _cloneModel();
    PlateModel seletedPlate = res.plates[state.selectedIndex ?? _mainIndex];
    int price = seletedPlate.level * seletedPlate.building!.price;
    if (!isFree && state.score < price) {
      return res.epoch;
    }
    if (res.epoch == 4) {
      onWin!(FameModel(
          year: res.yearNumber, epoch: res.epoch, level: state.theme!.id));
      return res.epoch;
    }
    seletedPlate.level++;
    res.epoch++;
    seletedPlate.hp += seletedPlate.building!.hp;
    if (!isFree) {
      res.score -= price;
    }
    res.selectedIndex = null;
    emit(res);
    return res.epoch;
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

  void makeUpgrade(UpgradeType upgrade) {
    GameModel res = _cloneModel();
    if (upgradePriceMap[upgrade]! <= res.score) {
      res.score -= upgradePriceMap[upgrade]!;
      switch (upgrade) {
        case UpgradeType.range:
          res.upgrades!.range = true;
          _setUnderAttackActions(res);
          break;
        case UpgradeType.education:
          res.upgrades!.education = true;
          break;
        case UpgradeType.repair:
          res.upgrades!.repair = true;
          break;
        case UpgradeType.fence:
          res.upgrades!.fence = true;
          break;
        case UpgradeType.dome:
          res.upgrades!.dome = true;
          break;
      }
    }
    return emit(res);
  }

  void changeState() {
    GameModel res = _cloneModel();
    res.counter += 0.01;
    _setFence(res.enemies);
    for (int i = 0; i < res.plates.length; i++) {
      _changeBuildState(res.plates[i], res);
      if (res.plates[i].buildProgress == null) {
        _buildingAttack(res.plates[i], i, res.enemies);
      }
    }
    if (_enemyAttack(res)) {
      return emit(res);
    }
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
        if (onWin != null) {
          _dalayed.cancel();
          onWin!(FameModel(
              year: res.yearNumber, epoch: res.epoch, level: state.theme!.id));
          return emit(res);
        }
      }
      if (cnt == 1) {
        res.counter = 0;
        res.yearNumber++;
        res.score += getIncome();
      }
    }
    _dalayed = Timer(const Duration(milliseconds: 500), () {
      changeState();
    });

    return emit(res);
  }

  void removeEnemy(int index) {
    GameModel res = _cloneModel();
    res.enemies[index] = null;
  }

  void _changeBuildState(PlateModel p, GameModel res) {
    if (p.building == null ||
        (p.buildProgress != null &&
            p.buildProgress! >= p.building!.hp * p.level)) {
      p.buildProgress = null;
      if (p.building != null && p.hp > p.topHP!) {
        p.hp = p.topHP!;
      }
      if (p.building?.type == BuildingType.tower) {
        _setUnderAttackActions(res);
      }
    } else if (p.buildProgress != null) {
      p.buildProgress = p.buildProgress! + p.building!.buildSpeed * p.level;
      p.hp += p.building!.buildSpeed * p.level;
    }
  }

  bool _enemyAttack(GameModel res) {
    for (int i = 0; i < res.enemies.length; i++) {
      if (res.enemies[i] != null) {
        EnemyModel enemy = res.enemies[i]!;
        if (enemy.targetIndex == null) {
          int range = enemy.type == EnemyType.wolf ? 1 : res.width;
          int? targetIndex =
              EpochHelper.getTargetByIndex(i, res.width, res.plates, range);
          // remove enemy if nothing to attack
          if (targetIndex == null) {
            if (enemy.type == EnemyType.helicopter) {
              int? nextIndex = _getNextEnemyIndex(i, res);
              if (nextIndex != null) {
                res.enemies[nextIndex] = EnemyModel(type: EnemyType.helicopter);
              }
            }
            res.enemies[i] = null;
          } else {
            enemy.targetIndex = targetIndex;
          }
        } else {
          res.plates[enemy.targetIndex!].hp -= enemy.dps;
          enemy.damege += enemy.dps;
          if (enemy.type == EnemyType.meteor) {
            Vibrate.feedback(FeedbackType.heavy);
          }
          if (enemy.type == EnemyType.zombie && enemy.damege >= 100) {
            enemy.damege = 0;
            int? nextIndex = _getNextEnemyIndex(i, res);
            if (nextIndex != null) {
              res.enemies[nextIndex] = EnemyModel(type: EnemyType.zombie);
            }
          }
          if (res.plates[enemy.targetIndex!].hp <= 0) {
            BuildingType? destroyedType =
                res.plates[enemy.targetIndex!].building?.type;
            res.plates[enemy.targetIndex!] = PlateModel();
            if (destroyedType == BuildingType.tower) {
              _setUnderAttackActions(res);
            }
            if (destroyedType == BuildingType.main) {
              _dalayed.cancel();
              onLose!(FameModel(
                  year: res.yearNumber,
                  epoch: res.epoch,
                  level: state.theme!.id));
              return true;
            }
            enemy.targetIndex = null;
          }
        }
      }
    }
    return false;
  }

  int? _getNextEnemyIndex(int index, GameModel res) {
    int nextIndex = index - 1;
    if (nextIndex < 0) {
      nextIndex = state.enemies.length - 1;
    }
    if (res.enemies[nextIndex] == null) {
      return nextIndex;
    }
    nextIndex = index + 1;
    if (nextIndex > res.enemies.length - 1) {
      nextIndex = 0;
    }
    if (res.enemies[nextIndex] == null) {
      return nextIndex;
    }
    return null;
  }

  void _buildingAttack(PlateModel p, int index, List<EnemyModel?> enemies) {
    if (p.building?.type == BuildingType.main) {
      EpochHelper.setBuildingTarget(p, enemies);
    } else if (p.building?.type == BuildingType.tower) {
      EpochHelper.setRangeBuildingTarget(p, enemies, index, state.width,
          state.upgrades?.range == true ? 2 : 1);
    }
  }

  void _setFence(List<EnemyModel?> enemies) {
    if (state.upgrades?.fence == true) {
      for (int i = 0; i < enemies.length; i++) {
        if (enemies[i] != null) {
          EnemyModel enemy = enemies[i]!;
          enemy.hp -= 10;
          if (enemy.hp <= 0) {
            enemies[i] = null;
          }
        }
      }
    }
  }

  void _setUnderAttackActions(GameModel res) {
    List<int> potential = [];
    for (int i = 0; i < res.plates.length; i++) {
      if (res.plates[i].building?.type == BuildingType.tower &&
          res.plates[i].buildProgress == null) {
        potential.addAll(EpochHelper.getTowerPotential(
            i, res.width, state.upgrades?.range == true ? 2 : 1));
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
