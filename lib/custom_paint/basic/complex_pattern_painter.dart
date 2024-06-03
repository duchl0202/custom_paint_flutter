import 'package:flutter/material.dart';

class PatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    var sideLength = 20.0;
    var gap = 10.0;
    for (double y = 0; y < size.height; y += sideLength + gap) {
      for (double x = 0; x < size.width; x += sideLength + gap) {
        canvas.drawRect(Rect.fromLTWH(x, y, sideLength, sideLength), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
