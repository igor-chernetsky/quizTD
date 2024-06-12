import 'package:flutter/widgets.dart';

class ArrowWidget extends StatelessWidget {
  final double size;
  final int width;
  final int index;
  const ArrowWidget(
      {super.key,
      required this.size,
      required this.width,
      required this.index});

  getWrapper() {}

  @override
  Widget build(BuildContext context) {
    double startOffset = size / 4;
    Offset offset = Offset(0, -size / 1.5);
    double angle = -1.57;
    if (index >= width * 3) {
      angle = 3.14;
      offset = Offset(-size / 2, -startOffset * 2);
    } else if (index >= width * 2) {
      offset = Offset(0, startOffset);
      angle = 1.57;
    } else if (index >= width) {
      angle = 0;
      offset = Offset(size / 2, -startOffset * 2);
    }
    return SizedBox(
      width: size / 2,
      height: size / 2,
      child: OverflowBox(
        maxHeight: size * 3,
        maxWidth: size * 3,
        child: Transform.translate(
          offset: offset,
          child: Transform.rotate(
            angle: angle,
            child: Container(
                width: size / 2,
                height: size / 2,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/img/arrow.png')))),
          ),
        ),
      ),
    );
  }
}
