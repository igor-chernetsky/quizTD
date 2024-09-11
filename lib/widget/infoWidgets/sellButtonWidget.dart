import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_defence/cubit/gameCubit.dart';
import 'package:quiz_defence/models/game_model.dart';
import 'package:quiz_defence/models/plate_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SellButton extends StatelessWidget {
  final PlateModel plate;
  const SellButton({super.key, required this.plate});

  @override
  Widget build(BuildContext context) {
    int price = (plate.building!.price * plate.level * 0.7).toInt();
    return BlocBuilder<GameCubit, GameModel>(
        builder: (context, gm) => ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFA2031E),
            ),
            onPressed: () => context.read<GameCubit>().sellBuilding(),
            icon: const Icon(
              Icons.sell,
              color: Colors.white,
            ),
            label: SizedBox(
                width: 90,
                child: Center(
                    child: Text(
                  '${AppLocalizations.of(context)!.sell} \$$price',
                  style:
                      const TextStyle(color: Colors.white, letterSpacing: 1.4),
                )))));
  }
}
