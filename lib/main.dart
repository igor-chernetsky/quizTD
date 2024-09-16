import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:quiz_defence/cubit/statsCubit.dart';
import 'package:quiz_defence/data/database_helper.dart';
import 'package:quiz_defence/models/stats_model.dart';
import 'package:quiz_defence/screens/game.dart';
import 'package:quiz_defence/screens/start.dart';
import 'package:quiz_defence/utils/colors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final dbHelper = DatabaseHelper();

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  await dbHelper.init();
  FlutterNativeSplash.remove();
  runApp(const QuizTDApp());
}

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
  }

  @override
  void onTransition(
      Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    super.onTransition(bloc, transition);
  }
}

class QuizTDApp extends StatelessWidget {
  const QuizTDApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<StatsCubit>(
      create: (BuildContext context) => StatsCubit()..initFame(null, null),
      child: BlocBuilder<StatsCubit, StatsModel>(
          builder: (context, sm) => MaterialApp(
                locale: sm.locale,
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  AppLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en'), // English
                  Locale('es'), // Spanish
                  Locale('de'), // Genrman
                  Locale('it'), // Italian
                  Locale('fr'), // Franch
                  Locale('ru'), // Russian
                ],
                title: 'Quiz Tower Defence',
                theme: ThemeData(
                  primaryColor: AppColors.primarySwatch,
                  outlinedButtonTheme: OutlinedButtonThemeData(
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColors.primarySwatch))),
                  colorScheme: ColorScheme.fromSwatch(
                      brightness: Brightness.dark,
                      backgroundColor: AppColors.backgroundColor,
                      cardColor: AppColors.cardColor,
                      primarySwatch: AppColors.primarySwatch,
                      accentColor: AppColors.accentColor),
                ),
                initialRoute: StartScreen.routeName,
                routes: {
                  StartScreen.routeName: (context) => const StartScreen(),
                  GameScreen.routeName: (context) => const GameScreen(),
                },
              )),
    );
  }
}
