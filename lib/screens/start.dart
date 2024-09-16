import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_fade/image_fade.dart';
import 'package:quiz_defence/cubit/statsCubit.dart';
import 'package:quiz_defence/models/fame_model.dart';
import 'package:quiz_defence/models/stats_model.dart';
import 'package:quiz_defence/screens/game.dart';
import 'package:quiz_defence/utils/colors.dart';
import 'package:quiz_defence/widget/infoWidgets/rotatedImg.dart';
import 'package:quiz_defence/widget/menus/languageSelector.dart';
import 'package:quiz_defence/widget/menus/themeSelector.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});
  static String routeName = '/';

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  int _counter = 0;

  static const List<String> _imgs = [
    'assets/img/win1.png',
    'assets/img/win2.png',
    'assets/img/win3.png',
    'assets/img/win4.png',
  ];

  String _img = 'assets/img/win1.png';

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 7), (timer) {
      setState(() {
        _counter = (_counter + 1) % _imgs.length;
        _img = _imgs[_counter];
      });
    });
  }

  renderTop(List<FameModel>? fames) {
    if (fames?.isNotEmpty == true) {
      return SizedBox(
        height: 140,
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: fames!.length,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 24,
                child: Center(
                    child: Text(
                        '${AppLocalizations.of(context)!.epoch} ${fames[index].epoch} ${AppLocalizations.of(context)!.year} ${fames[index].year}',
                        style: const TextStyle(
                            color: Color(0xFFB0B0B0),
                            fontSize: 16,
                            decoration: TextDecoration.none))),
              );
            }),
      );
    }

    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      height: 100,
      child: const RotatedImage(imgUrl: 'assets/img/empty.png'),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<StatsCubit>().resetState();

    var availableHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BlocBuilder<StatsCubit, StatsModel>(builder: (context, sm) {
        if (Localizations.localeOf(context).toString() !=
            sm.locale.languageCode) {
          context.read<StatsCubit>().initFame(null, sm.locale);
        }
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
                child: ImageFade(
              // whenever the image changes, it will be loaded, and then faded in:
              image: AssetImage(_img),

              // slow-ish fade for loaded images:
              duration: const Duration(milliseconds: 500),

              // supports most properties of Image:
              alignment: Alignment.center,
              fit: BoxFit.cover,
              scale: 1,
            )),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              height: availableHeight,
              width: double.infinity,
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.7)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage('assets/img/splash.gif'),
                    width: 100,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFA2031E),
                      ),
                      onPressed: () => Navigator.pushReplacementNamed(
                          context, GameScreen.routeName),
                      child: Text(
                        AppLocalizations.of(context)!.start,
                        style: const TextStyle(
                            color: Colors.white,
                            letterSpacing: 3,
                            fontSize: 20),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(0, 0, 0, 0.8),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: AppColors.primarySwatch, width: 2)),
                    child: Column(
                      children: [
                        Text(AppLocalizations.of(context)!.top10,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                decoration: TextDecoration.none)),
                        const SizedBox(
                          height: 10,
                        ),
                        renderTop(sm.fameList)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const ThemeSelector(),
                  const Positioned(
                      bottom: 10, right: 10, child: LanguageSelector())
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
