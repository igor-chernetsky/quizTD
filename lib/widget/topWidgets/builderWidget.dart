import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_defence/cubit/gameCubit.dart';
import 'package:quiz_defence/models/building_model.dart';
import 'package:quiz_defence/models/game_model.dart';
import 'package:quiz_defence/utils/colors.dart';
import 'package:quiz_defence/widget/infoWidgets/buildingInfoWidget.dart';
import 'package:quiz_defence/widget/infoWidgets/closePlateButton.dart';
import 'package:quiz_defence/widget/infoWidgets/epochNum.dart';
import 'package:quiz_defence/widget/playgroundWidgets/buildingWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BuilderWidget extends StatelessWidget {
  const BuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var availableHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    double widgetHeight = availableHeight / 2;
    double mainSize = min<double>(MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height / 2);
    double size = mainSize / 3 - 24;
    List<List<BuildingModel>> buildings = [
      [
        BuildingModel(
            type: BuildingType.farm, price: 10, hp: 100, buildSpeed: 4),
      ],
      [
        BuildingModel(
            type: BuildingType.farm, price: 10, hp: 100, buildSpeed: 4),
        BuildingModel(
            type: BuildingType.tower,
            price: 50,
            hp: 200,
            dps: 10,
            buildSpeed: 5),
        BuildingModel(
            type: BuildingType.school, price: 100, hp: 100, buildSpeed: 5)
      ],
      [
        BuildingModel(
            type: BuildingType.farm, price: 10, hp: 100, buildSpeed: 4),
        BuildingModel(
            type: BuildingType.tower,
            price: 50,
            hp: 200,
            dps: 10,
            buildSpeed: 5),
        BuildingModel(
            type: BuildingType.school, price: 100, hp: 150, buildSpeed: 5)
      ],
      [
        BuildingModel(
            type: BuildingType.farm, price: 10, hp: 100, buildSpeed: 4),
        BuildingModel(
            type: BuildingType.tower,
            price: 50,
            hp: 200,
            dps: 10,
            buildSpeed: 5),
        BuildingModel(
            type: BuildingType.school, price: 100, hp: 150, buildSpeed: 5)
      ]
    ];

    getEpochBuilding(int epoch, GameModel gm) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: buildings[epoch - 1]
                .map(
                  (b) => Column(
                    children: [
                      BuildingWidget(
                        level: epoch,
                        size: size,
                        building: b,
                        onTap: () => context.read<GameCubit>().build(b, epoch),
                      ),
                      Center(
                        child: Text(
                          '\$${(b.price * epoch).toString()}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: gm.score < (b.price * epoch)
                                  ? Colors.red
                                  : Colors.green),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              buldingNames(
                                  AppLocalizations.of(context)!, b.type)!,
                              style: TextStyle(
                                  color: AppColors.textColor, fontSize: 16)),
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton.outlined(
                              onPressed: () {
                                showModalBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                          padding: const EdgeInsets.all(10),
                                          height: 300,
                                          width: double.infinity,
                                          child: BuildingInfo(
                                            building: b,
                                            epoch: epoch,
                                          ));
                                    });
                              },
                              iconSize: 18,
                              icon: const Icon(
                                Icons.question_mark,
                              ))
                        ],
                      )
                    ],
                  ),
                )
                .toList()),
      );
    }

    getTabs(int epoch) {
      const double tabHeight = 50;
      List<Widget> tabs = [
        const Tab(
          height: tabHeight,
          child: EpochnumWidget(epoch: 1),
        ),
      ];
      if (epoch > 1) {
        tabs.add(const Tab(
          height: tabHeight,
          child: EpochnumWidget(epoch: 2),
        ));
      }
      if (epoch > 2) {
        tabs.add(const Tab(
          height: tabHeight,
          child: EpochnumWidget(epoch: 3),
        ));
      }
      if (epoch > 3) {
        tabs.add(const Tab(
          height: tabHeight,
          child: EpochnumWidget(epoch: 4),
        ));
      }
      return TabBar(
        tabs: tabs,
      );
    }

    getTabContent(GameModel gm) {
      List<Widget> tabs = [getEpochBuilding(1, gm)];
      if (gm.epoch > 1) {
        tabs.add(getEpochBuilding(2, gm));
      }
      if (gm.epoch > 2) {
        tabs.add(getEpochBuilding(3, gm));
      }
      if (gm.epoch > 3) {
        tabs.add(getEpochBuilding(4, gm));
      }
      return TabBarView(
        children: tabs,
      );
    }

    return BlocBuilder<GameCubit, GameModel>(
        builder: (context, gm) => SizedBox(
              height: widgetHeight,
              width: mainSize,
              child: DefaultTabController(
                initialIndex: gm.epoch - 1,
                length: gm.epoch,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getTabs(gm.epoch),
                    Expanded(
                      child: getTabContent(gm),
                    ),
                    const ClosePlateButton()
                  ],
                ),
              ),
            ));
  }
}
