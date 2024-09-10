import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_defence/cubit/gameCubit.dart';
import 'package:quiz_defence/models/game_model.dart';
import 'package:quiz_defence/models/plate_model.dart';
import 'package:quiz_defence/widget/infoWidgets/barWidget.dart';
import 'package:quiz_defence/widget/infoWidgets/repairButton.dart';

class BuildingHp extends StatelessWidget {
  final PlateModel plate;
  final double mainSize;
  const BuildingHp({super.key, required this.plate, required this.mainSize});

  @override
  Widget build(BuildContext context) {
    double percent = (plate.topHP! - plate.hp) / (plate.topHP!);
    int price = (plate.building!.price * plate.level * percent).toInt();

    return BlocBuilder<GameCubit, GameModel>(builder: (context, gm) {
      bool hideRepair = price < 1 ||
          plate.hp == plate.topHP! ||
          gm.upgrades?.repair != true ||
          gm.score < price;
      List<Widget> repairBtn =
          hideRepair ? [] : [RepairButton(plate: plate, price: price)];
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              width: mainSize - (hideRepair ? 40 : 140),
              child: BarWidget(
                value: plate.hp,
                total: plate.building!.hp * plate.level,
                icon: Icons.favorite,
              )),
          ...repairBtn
        ],
      );
    });
  }
}
