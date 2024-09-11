import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_defence/cubit/gameCubit.dart';
import 'package:quiz_defence/models/game_model.dart';
import 'package:quiz_defence/screens/start.dart';
import 'package:quiz_defence/utils/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WinWidget extends StatelessWidget {
  const WinWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameModel>(
        builder: (context, gm) => Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.85), BlendMode.dstATop),
                image: AssetImage(
                  'assets/img/win${gm.epoch}.png',
                ),
              )),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  height: 210,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color.fromRGBO(0, 0, 0, 0.7)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.victory,
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primarySwatch),
                      ),
                      Text(
                        '${AppLocalizations.of(context)!.year}: ${gm.yearNumber}',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColor),
                      ),
                      Text(
                        '${AppLocalizations.of(context)!.main}: ${gm.epochName(AppLocalizations.of(context)!)}',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColor),
                      ),
                      ElevatedButton(
                          onPressed: () => {
                                Navigator.pushReplacementNamed(
                                    context, StartScreen.routeName),
                              },
                          child: Text(AppLocalizations.of(context)!.menu))
                    ],
                  ),
                ),
              ),
            ));
  }
}
