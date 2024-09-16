import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_defence/cubit/gameCubit.dart';
import 'package:quiz_defence/cubit/questionCubit.dart';
import 'package:quiz_defence/models/game_model.dart';
import 'package:quiz_defence/screens/start.dart';
import 'package:quiz_defence/utils/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainMenu extends StatelessWidget {
  final double size;
  final BuildContext parentContext;
  const MainMenu({super.key, required this.size, required this.parentContext});

  @override
  Widget build(BuildContext ctx) {
    return BlocBuilder<GameCubit, GameModel>(
        builder: (context, gm) => SizedBox(
              height: size,
              width: size,
              child: Card(
                  color: const Color.fromRGBO(0, 0, 0, 0.6),
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
                                        child: Text(
                                          AppLocalizations.of(ctx)!.resume,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              letterSpacing: 3,
                                              fontSize: 20),
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ElevatedButton.icon(
                                      icon: const Icon(
                                        Icons.refresh,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        parentContext
                                            .read<GameCubit>()
                                            .resetState();
                                        parentContext
                                            .read<QuestionCubit>()
                                            .setQuestions(1, 0,
                                                theme: gm.theme,
                                                local:
                                                    AppLocalizations.of(ctx)!);
                                        Navigator.of(context).pop();
                                      },
                                      label: Container(
                                          alignment: Alignment.center,
                                          width: 120,
                                          child: Text(
                                            AppLocalizations.of(ctx)!.restart,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                letterSpacing: 3,
                                                fontSize: 20),
                                          ))),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ElevatedButton.icon(
                                      icon: const Icon(
                                        Icons.exit_to_app_outlined,
                                        color: Colors.white,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFFA2031E),
                                      ),
                                      onPressed: () =>
                                          Navigator.pushReplacementNamed(
                                              context, StartScreen.routeName),
                                      label: Container(
                                          alignment: Alignment.center,
                                          width: 120,
                                          child: Text(
                                            AppLocalizations.of(ctx)!.exit,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                letterSpacing: 3,
                                                fontSize: 20),
                                          ))),
                                ],
                              ),
                            );
                          }),
                      icon: const Icon(Icons.menu, size: 38))),
            ));
  }
}
