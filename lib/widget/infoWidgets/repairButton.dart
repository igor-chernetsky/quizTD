import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_defence/cubit/gameCubit.dart';
import 'package:quiz_defence/models/game_model.dart';
import 'package:quiz_defence/models/plate_model.dart';

class RepairButton extends StatelessWidget {
  final PlateModel plate;
  final int price;
  const RepairButton({super.key, required this.plate, required this.price});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameModel>(
        builder: (context, gm) => ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0)),
            onPressed: context.read<GameCubit>().repairBuilding,
            icon: const Icon(
              Icons.gavel,
              size: 20,
            ),
            label:
                SizedBox(width: 40, child: Center(child: Text('\$$price')))));
  }
}
