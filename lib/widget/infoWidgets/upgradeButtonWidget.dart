import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_defence/cubit/gameCubit.dart';
import 'package:quiz_defence/models/game_model.dart';
import 'package:quiz_defence/models/plate_model.dart';

class UpgradeButton extends StatelessWidget {
  final PlateModel plate;
  const UpgradeButton({super.key, required this.plate});

  isDisabled(GameModel gm) {
    return plate.level >= gm.epoch || gm.score < plate.building!.price;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameModel>(
        builder: (context, gm) => gm.epoch > plate.level
            ? ElevatedButton.icon(
                onPressed: isDisabled(gm)
                    ? null
                    : () => context.read<GameCubit>().upgradeBuilding(),
                icon: Icon(
                  Icons.upgrade,
                  color: isDisabled(gm) ? Colors.grey : Colors.white,
                ),
                label: SizedBox(
                    width: 90,
                    child: Center(
                        child: Text(
                      '\$${plate.building!.price}',
                      style: TextStyle(
                          color: isDisabled(gm) ? Colors.grey : Colors.white,
                          letterSpacing: 1.4),
                    ))))
            : const SizedBox(
                height: 0,
              ));
  }
}
