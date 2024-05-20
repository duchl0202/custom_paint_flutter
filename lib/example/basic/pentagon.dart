import 'package:flutter/material.dart';
import 'dart:math';

class PentagonPainter extends CustomPainter {
  PentagonPainter({required this.progress});
  final double progress;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    final Offset center = Offset(size.width / 2, size.height / 2);
    const int radius = 100;
    const int side = 5;
    const double angle = 2 * pi / side;

    final Path path = Path();

    final Offset startPosition =
        center + Offset(radius * cos(0), radius * sin(0));
    path.moveTo(startPosition.dx, startPosition.dy);

    for (int i = 1; i <= side; i++) {
      final x = center.dx + radius * cos(angle * i);
      final y = center.dy + radius * sin(angle * i);
      path.lineTo(x, y);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
