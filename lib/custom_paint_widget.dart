import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CustomPaintWidget extends StatelessWidget {
  const CustomPaintWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(),
      size: const Size(300, 300),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Offset canvasCenter = Offset(size.width / 2, size.height / 2);
    Rect rectCanvasSize = Offset.zero & size;
    Rect rectHalfCanvasSize = Offset.zero & size / 2;

    Paint paintBlack = Paint()..color = Colors.black;
    Paint paintRed = Paint()..color = Colors.red;

    Path path = Path()
      ..addOval(Rect.fromCenter(center: canvasCenter, width: 100, height: 100));

    canvas.drawRect(rectCanvasSize, paintBlack);
    canvas.drawPath(path, paintRed);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
