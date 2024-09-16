import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_defence/cubit/statsCubit.dart';
import 'package:quiz_defence/models/stats_model.dart';
import 'package:quiz_defence/utils/colors.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  getImg(String coutryCode) {
    switch (coutryCode) {
      case 'ru':
        return 'assets/img/flags/ru.png';
      case 'es':
        return 'assets/img/flags/es.png';
      case 'de':
        return 'assets/img/flags/de.png';
      case 'fr':
        return 'assets/img/flags/fr.png';
      case 'it':
        return 'assets/img/flags/it.png';
      default:
        return 'assets/img/flags/gb.png';
    }
  }

  getLocaleButton(BuildContext context, String lang, bool isCurrent) {
    return Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            border: Border.all(
                color: isCurrent
                    ? Theme.of(context).primaryColor
                    : Colors.transparent),
            borderRadius: const BorderRadius.all(Radius.circular(14))),
        height: 40,
        width: 40,
        child: GestureDetector(
            onTap: () {
              context.read<StatsCubit>().switchLocale(Locale(lang));
              Navigator.of(context).pop();
            },
            child: Image(
              image: AssetImage(getImg(lang)),
              width: 40,
            )));
  }

  @override
  Widget build(BuildContext ctx) {
    return BlocBuilder<StatsCubit, StatsModel>(
        builder: (context, sm) => SizedBox(
            height: 40,
            width: 40,
            child: GestureDetector(
                onTap: () => showModalBottomSheet<void>(
                    context: ctx,
                    builder: (BuildContext context) {
                      return Container(
                        alignment: Alignment.center,
                        color: AppColors.backgroundColor,
                        padding: const EdgeInsets.all(10),
                        height: 100,
                        width: double.infinity,
                        child: GridView.count(
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          crossAxisCount: 6,
                          children: [
                            getLocaleButton(
                                ctx, 'en', sm.locale.toString() == 'en'),
                            getLocaleButton(
                                ctx, 'es', sm.locale.toString() == 'es'),
                            getLocaleButton(
                                ctx, 'de', sm.locale.toString() == 'de'),
                            getLocaleButton(
                                ctx, 'fr', sm.locale.toString() == 'fr'),
                            getLocaleButton(
                                ctx, 'it', sm.locale.toString() == 'it'),
                            getLocaleButton(
                                ctx, 'ru', sm.locale.toString() == 'ru')
                          ],
                        ),
                      );
                    }),
                child: Image(
                  image: AssetImage(getImg(sm.locale.toString())),
                  width: 40,
                ))));
  }
}
