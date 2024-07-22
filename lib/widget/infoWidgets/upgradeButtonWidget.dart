import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/cubit/gameCubit.dart';
import 'package:quiz_td/models/game_model.dart';
import 'package:quiz_td/models/plate_model.dart';

class UpgradeButton extends StatelessWidget {
  final PlateModel plate;
  const UpgradeButton({super.key, required this.plate});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameModel>(
        builder: (context, gm) => ElevatedButton.icon(
            onPressed: () => plate.level >= gm.epoch
                ? null
                : context.read<GameCubit>().upgradeBuilding(),
            icon: const Icon(Icons.upgrade),
            label: Text('Upgrade \$${plate.building!.price}')));
  }
}
