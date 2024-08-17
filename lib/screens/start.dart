import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_fade/image_fade.dart';
import 'package:quiz_td/cubit/statsCubit.dart';
import 'package:quiz_td/main.dart';
import 'package:quiz_td/models/fame_model.dart';
import 'package:quiz_td/models/stats_model.dart';
import 'package:quiz_td/screens/game.dart';
import 'package:quiz_td/utils/colors.dart';
import 'package:quiz_td/widget/infoWidgets/rotatedImg.dart';

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
                        'Year ${fames[index].year} Epoch ${fames[index].epoch}',
                        style: const TextStyle(
                            fontSize: 16, decoration: TextDecoration.none))),
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
    print(_img);
    var availableHeight = MediaQuery.of(context).size.height;
    return BlocProvider<StatsCubit>(
      create: (BuildContext context) =>
          StatsCubit()..initFame(dbHelper.queryAllRows(10)),
      child: BlocBuilder<StatsCubit, StatsModel>(builder: (context, sm) {
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
                  const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.4)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage('assets/img/splash.gif'),
                    width: 100,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, GameScreen.routeName),
                      child: const Text(
                        'START',
                        style: TextStyle(letterSpacing: 2, fontSize: 18),
                      )),
                  const SizedBox(
                    height: 30,
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
                        const Text('Top 10:',
                            style: TextStyle(
                                fontSize: 20, decoration: TextDecoration.none)),
                        const SizedBox(
                          height: 10,
                        ),
                        renderTop(sm.fameList)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
