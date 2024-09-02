import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_defence/cubit/gameCubit.dart';
import 'package:quiz_defence/cubit/questionCubit.dart';
import 'package:quiz_defence/models/fame_model.dart';
import 'package:quiz_defence/models/game_model.dart';
import 'package:quiz_defence/screens/start.dart';
import 'package:quiz_defence/utils/colors.dart';

class ThemeSelector extends StatelessWidget {
  final BuildContext parentContext;
  const ThemeSelector({super.key, required this.parentContext});

  renderThemeSelector(int level) {
    ListView.builder(
        itemBuilder: (context, index) => GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                height: 100,
                child: Column(
                  children: [Text(levelNameMap[level]!)],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameModel>(
        builder: (context, gm) => SizedBox(
              height: 80,
              width: 80,
              child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/img/splash.gif'))),
                  child: IconButton(
                      onPressed: () => showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              alignment: Alignment.center,
                              color: AppColors.backgroundColor,
                              padding: const EdgeInsets.all(10),
                              height: 220,
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton.icon(
                                      icon: const Icon(Icons.arrow_back,
                                          color: Colors.white),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      label: Container(
                                        alignment: Alignment.center,
                                        width: 120,
                                        child: const Text(
                                          'RESUME',
                                          style: TextStyle(
                                              color: Colors.white,
                                              letterSpacing: 3,
                                              fontSize: 20),
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            );
                          }),
                      icon: const Icon(Icons.menu, size: 38))),
            ));
  }
}
