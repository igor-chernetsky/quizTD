import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_defence/models/fame_model.dart';
import 'package:quiz_defence/models/stats_model.dart';
import 'package:quiz_defence/utils/colors.dart';
import 'package:quiz_defence/widget/infoWidgets/barWidget.dart';
import 'package:quiz_defence/widget/infoWidgets/healthBarWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../cubit/statsCubit.dart';

class ThemeSelector extends StatelessWidget {
  final BuildContext parentContext;
  const ThemeSelector({super.key, required this.parentContext});

  getName(AppLocalizations locale, int id) {
    switch (id) {
      case 0:
        return locale.math1;
      case 1:
        return locale.math2;
      case 2:
        return locale.geo;
      case 3:
        return locale.math3;
      case 4:
        return locale.flag;
    }
  }

  renderThemeSelector(BuildContext context, List<ThemeItem> top) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
        itemCount: top.length,
        itemBuilder: (context1, index) => GestureDetector(
              onTap: () {
                context.read<StatsCubit>().initFame(themeItems[index]);
                Navigator.of(context1).pop();
              },
              child: Container(
                height: 40,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/img/${themeItems[index].img}',
                      width: 80,
                    ),
                    Text(getName(
                        AppLocalizations.of(context)!, themeItems[index].id)),
                    const SizedBox(
                      height: 6,
                    ),
                    HealthbarWidget(
                      width: 100,
                      hp: (themeItems[index].level ?? 0) * 0.2,
                    ),
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatsCubit, StatsModel>(
        builder: (context, sm) => SizedBox(
              height: 180,
              width: 300,
              child: SizedBox(
                  child: GestureDetector(
                      onTap: () => showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context1) {
                            return Container(
                              alignment: Alignment.center,
                              color: AppColors.backgroundColor,
                              padding: const EdgeInsets.all(10),
                              height: 320,
                              width: double.infinity,
                              child: renderThemeSelector(context, sm.top),
                            );
                          }),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/img/${sm.theme.img}',
                            width: 80,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  width: 140,
                                  child: BarWidget(
                                      value: sm.theme.level ?? 0, total: 5)),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                sm.theme.name,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ))),
            ));
  }
}
