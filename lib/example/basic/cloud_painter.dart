import 'package:flutter/material.dart';

class CloudPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.blue[200]!
      ..style = PaintingStyle.fill;
    var path = Path();

    path.moveTo(size.width * 0.3, size.height * 0.5);
    path.cubicTo(size.width * 0.2, size.height * 0.45, size.width * 0.2,
        size.height * 0.55, size.width * 0.3, size.height * 0.55);
    path.cubicTo(size.width * 0.25, size.height * 0.6, size.width * 0.35,
        size.height * 0.6, size.width * 0.4, size.height * 0.55);
    path.cubicTo(size.width * 0.5, size.height * 0.6, size.width * 0.6,
        size.height * 0.55, size.width * 0.6, size.height * 0.5);
    path.cubicTo(size.width * 0.7, size.height * 0.55, size.width * 0.8,
        size.height * 0.45, size.width * 0.7, size.height * 0.4);
    path.cubicTo(size.width * 0.8, size.height * 0.35, size.width * 0.7,
        size.height * 0.3, size.width * 0.6, size.height * 0.35);
    path.cubicTo(size.width * 0.5, size.height * 0.25, size.width * 0.4,
        size.height * 0.35, size.width * 0.4, size.height * 0.4);
    path.cubicTo(size.width * 0.3, size.height * 0.35, size.width * 0.2,
        size.height * 0.4, size.width * 0.3, size.height * 0.5);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
