import 'package:flutter/material.dart';
import 'package:quiz_td/models/upgrade_model.dart';

class UpgradeWidget extends StatelessWidget {
  final UpgradeType upgrade;
  final double size;
  final int price;
  final int score;
  final Function? onTap;
  final int? level;
  final bool done;
  const UpgradeWidget(
      {required this.size,
      required this.price,
      required this.score,
      super.key,
      required this.upgrade,
      this.onTap,
      this.level,
      this.done = false});

  @override
  Widget build(BuildContext context) {
    String imgPath = '';
    switch (upgrade) {
      case UpgradeType.repair:
        imgPath = 'assets/img/repair.png';
        break;
      case UpgradeType.fence:
        imgPath = 'assets/img/fence.png';
        break;
      case UpgradeType.range:
        imgPath = 'assets/img/range.png';
        break;
      case UpgradeType.dome:
        imgPath = 'assets/img/dome.png';
        break;
      default:
        imgPath = 'assets/img/education.png';
    }

    getOverlay() {
      if (done) {
        return [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(50, 150, 23, 0.3),
              borderRadius: BorderRadius.all(Radius.circular(size / 2)),
            ),
            width: size,
            height: size,
            child: const Center(
              child: Icon(
                Icons.check,
                color: Color.fromRGBO(50, 150, 23, 1),
              ),
            ),
          )
        ];
      }
      return [];
    }

    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              width: size,
              height: size,
              child: GestureDetector(
                onTap: () => onTap == null ? null : onTap!(),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(size / 2)),
                      image: DecorationImage(image: AssetImage(imgPath))),
                ),
              ),
            ),
            ...getOverlay(),
          ],
        ),
        Center(
          child: !done
              ? Text(
                  (price).toString(),
                  style: TextStyle(
                      color: score < price ? Colors.red : Colors.green),
                )
              : null,
        )
      ],
    );
  }
}
