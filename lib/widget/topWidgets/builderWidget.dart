import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_td/cubit/gameCubit.dart';
import 'package:quiz_td/models/building_model.dart';
import 'package:quiz_td/models/game_model.dart';
import 'package:quiz_td/widget/infoWidgets/epochNum.dart';
import 'package:quiz_td/widget/playgroundWidgets/buildingWidget.dart';

class BuilderWidget extends StatelessWidget {
  const BuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double widgetHeight = MediaQuery.of(context).size.height / 3;
    double size = MediaQuery.of(context).size.width / 4;
    List<List<BuildingModel>> buildings = [
      [
        BuildingModel(type: BuildingType.farm, price: 10, hp: 50),
      ],
      [
        BuildingModel(type: BuildingType.farm, price: 10, hp: 50),
        BuildingModel(
            type: BuildingType.tower,
            price: 50,
            hp: 150,
            dps: 10,
            buildSpeed: 5),
        BuildingModel(
            type: BuildingType.warhouse, price: 50, hp: 200, buildSpeed: 10)
      ],
      [
        BuildingModel(type: BuildingType.farm, price: 10, hp: 50),
        BuildingModel(
            type: BuildingType.tower,
            price: 50,
            hp: 150,
            dps: 10,
            buildSpeed: 5),
        BuildingModel(
            type: BuildingType.warhouse, price: 50, hp: 200, buildSpeed: 10)
      ],
      [
        BuildingModel(type: BuildingType.farm, price: 10, hp: 50),
        BuildingModel(
            type: BuildingType.tower,
            price: 50,
            hp: 150,
            dps: 10,
            buildSpeed: 5),
        BuildingModel(
            type: BuildingType.warhouse, price: 50, hp: 200, buildSpeed: 10)
      ]
    ];

    getEpochBuilding(int epoch, GameModel gm) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
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
                          (b.price * epoch).toString(),
                          style: TextStyle(
                              color: gm.score < b.price
                                  ? Colors.red
                                  : Colors.green),
                        ),
                      )
                    ],
                  ),
                )
                .toList()),
      );
    }

    getTabs(int epoch) {
      List<Widget> tabs = [
        const Tab(
          child: EpochnumWidget(epoch: 1),
          height: 60,
        ),
      ];
      if (epoch > 1) {
        tabs.add(const Tab(
          child: EpochnumWidget(epoch: 2),
          height: 60,
        ));
      }
      if (epoch > 2) {
        tabs.add(const Tab(
          child: EpochnumWidget(epoch: 3),
          height: 60,
        ));
      }
      if (epoch > 3) {
        tabs.add(const Tab(
          child: EpochnumWidget(epoch: 4),
          height: 60,
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
                    IconButton.filled(
                      onPressed: () =>
                          context.read<GameCubit>().selectPlate(null),
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),
              ),
            ));
  }
}
