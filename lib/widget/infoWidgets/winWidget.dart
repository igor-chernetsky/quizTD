import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/cubit/gameCubit.dart';
import 'package:quiz_td/models/game_model.dart';
import 'package:quiz_td/utils/colors.dart';

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
                      color: Color.fromRGBO(255, 255, 255, 0.6)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'You WON!',
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: AppColors.accentColor),
                      ),
                      Text(
                        'year ${gm.yearNumber}',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.accentColor),
                      ),
                      Text(
                        'you have reached ${gm.epochName}',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.accentColor),
                      ),
                      ElevatedButton(
                          onPressed: () => {}, child: const Text('MENU'))
                    ],
                  ),
                ),
              ),
            ));
  }
}