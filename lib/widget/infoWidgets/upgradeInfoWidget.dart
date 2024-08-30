import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:quiz_defence/models/upgrade_model.dart';
import 'package:quiz_defence/utils/colors.dart';
import 'package:quiz_defence/widget/infoWidgets/closeDialogButton.dart';
import 'package:quiz_defence/widget/infoWidgets/upgradeWidget.dart';

class UpgradeInfo extends StatelessWidget {
  final UpgradeType upgrade;
  const UpgradeInfo({super.key, required this.upgrade});

  @override
  Widget build(BuildContext context) {
    double size = min<double>(MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height / 2) /
            3 -
        24;
    return Stack(
      children: [
        Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  UpgradeWidget(size: size, upgrade: upgrade),
                  Text(upgradeNameMap[upgrade]!,
                      style:
                          TextStyle(color: AppColors.textColor, fontSize: 20)),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(upgradeDescriptionMap[upgrade]!,
                    style: TextStyle(
                        color: AppColors.textSecondary, fontSize: 16)),
              ),
            ],
          ),
        ),
        const Positioned(bottom: 10, right: 10, child: CloseDialogButton())
      ],
    );
  }
}
