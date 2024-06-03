import 'package:flutter/material.dart';

class RectangleGradient extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gradient = const LinearGradient(
      colors: [Colors.blue, Color.fromARGB(255, 255, 0, 0)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
    var rect = Rect.fromLTWH(50, 50, 100, 100);

    final paint = Paint()
      ..strokeWidth = 4
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke;

    var radius = Radius.circular(20);

    var rrect = RRect.fromRectAndRadius(rect, radius);
    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
