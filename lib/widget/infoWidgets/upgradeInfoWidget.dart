import 'package:flutter/widgets.dart';
import 'package:quiz_td/models/upgrade_model.dart';
import 'package:quiz_td/utils/colors.dart';
import 'package:quiz_td/widget/infoWidgets/closeDialogButton.dart';
import 'package:quiz_td/widget/infoWidgets/upgradeWidget.dart';

class UpgradeInfo extends StatelessWidget {
  final UpgradeType upgrade;
  const UpgradeInfo({super.key, required this.upgrade});

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width / 3 - 24;
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
