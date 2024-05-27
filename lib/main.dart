import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/screens/game.dart';
import 'package:quiz_td/utils/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const QuizTDApp());
}

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) print(change);
  }

  @override
  void onTransition(
      Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    super.onTransition(bloc, transition);
    print(transition);
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
      initialRoute: GameScreen.routeName,
      routes: {
        GameScreen.routeName: (context) => const GameScreen(),
      },
    );
  }
}
