import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:quiz_td/data/database_helper.dart';
import 'package:quiz_td/screens/game.dart';
import 'package:quiz_td/screens/start.dart';
import 'package:quiz_td/utils/colors.dart';

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
    return MaterialApp(
      title: 'Quiz Tower Defence',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.primaryColor))),
        colorScheme: ColorScheme.fromSwatch(
            brightness: Brightness.dark,
            backgroundColor: AppColors.neutralBackground,
            cardColor: AppColors.secondaryColor,
            primarySwatch: AppColors.primaryColor,
            accentColor: AppColors.accentColor),
      ),
      initialRoute: StartScreen.routeName,
      routes: {
        StartScreen.routeName: (context) => const StartScreen(),
        GameScreen.routeName: (context) => const GameScreen(),
      },
    );
  }
}
