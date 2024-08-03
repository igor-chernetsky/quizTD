import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/cubit/gameCubit.dart';
import 'package:quiz_td/models/game_model.dart';
import 'package:quiz_td/models/plate_model.dart';

class RepairButton extends StatelessWidget {
  final PlateModel plate;
  const RepairButton({super.key, required this.plate});

  @override
  Widget build(BuildContext context) {
    double percent = (plate.topHP! - plate.hp) / (plate.topHP!);
    int price = (plate.building!.price * plate.level * percent).toInt();

    return BlocBuilder<GameCubit, GameModel>(
        builder: (context, gm) => ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0)),
            onPressed: price < 1 ||
                    plate.hp == plate.topHP! ||
                    gm.upgrades?.repair != true
                ? null
                : context.read<GameCubit>().repairBuilding,
            icon: const Icon(
              Icons.gavel,
              size: 20,
            ),
            label:
                SizedBox(width: 40, child: Center(child: Text('\$$price')))));
  }
}
