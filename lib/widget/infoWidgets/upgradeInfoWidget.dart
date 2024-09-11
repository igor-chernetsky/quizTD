import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:quiz_defence/models/upgrade_model.dart';
import 'package:quiz_defence/utils/colors.dart';
import 'package:quiz_defence/widget/infoWidgets/closeDialogButton.dart';
import 'package:quiz_defence/widget/infoWidgets/upgradeWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpgradeInfo extends StatelessWidget {
  final UpgradeType upgrade;
  const UpgradeInfo({super.key, required this.upgrade});

  getUpgradeDescription(AppLocalizations locale, UpgradeType? t) {
    if (t != null) {
      switch (t) {
        case UpgradeType.range:
          return locale.upgradeRangeDescription;
        case UpgradeType.education:
          return locale.upgradeEducationDescription;
        case UpgradeType.fence:
          return locale.upgradeFenceDescription;
        case UpgradeType.repair:
          return locale.upgradeRepairDescription;
        case UpgradeType.dome:
          return locale.upgradeAintiAirDescription;
      }
    }
  }

  getUpgradeName(AppLocalizations locale, UpgradeType? t) {
    if (t != null) {
      switch (t) {
        case UpgradeType.range:
          return locale.upgradeRange;
        case UpgradeType.education:
          return locale.upgradeEducation;
        case UpgradeType.fence:
          return locale.upgradeFence;
        case UpgradeType.repair:
          return locale.upgradeRepair;
        case UpgradeType.dome:
          return locale.upgradeAintiAir;
      }
    }
  }

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
                  Text(
                      getUpgradeName(AppLocalizations.of(context)!, upgrade) ??
                          '',
                      style:
                          TextStyle(color: AppColors.textColor, fontSize: 20)),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                    getUpgradeDescription(
                            AppLocalizations.of(context)!, upgrade) ??
                        '',
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
