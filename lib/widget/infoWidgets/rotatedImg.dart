import 'package:flutter/widgets.dart';
import 'dart:math' as math;

class RotatedImage extends StatefulWidget {
  final String imgUrl;
  const RotatedImage({super.key, required this.imgUrl});

  @override
  State<RotatedImage> createState() => _RotatedImageState();
}

class _RotatedImageState extends State<RotatedImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 3))
        ..repeat();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * math.pi,
          child: child,
        );
      },
      child: Image(
        image: AssetImage(widget.imgUrl),
      ),
    ));
  }
}
