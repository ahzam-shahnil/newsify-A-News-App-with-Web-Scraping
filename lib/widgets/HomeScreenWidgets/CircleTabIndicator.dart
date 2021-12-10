// Flutter imports:
import 'package:flutter/material.dart';

class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  CircleTabIndicator(
      {required Color color, required double radius, required isPortrait})
      : _painter = _CirclePainter(color, radius, isPortrait);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;
  final bool isPortrait;

  _CirclePainter(Color color, this.radius, this.isPortrait)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset = offset +
        Offset(
            cfg.size!.width / 2,
            isPortrait
                ? cfg.size!.height * 0.35 - radius - 5
                : cfg.size!.height - radius - 5);

    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
