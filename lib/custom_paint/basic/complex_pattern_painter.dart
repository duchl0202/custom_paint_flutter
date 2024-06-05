import 'package:flutter/material.dart';

class ComplexPatternWidget extends StatelessWidget {
  const ComplexPatternWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complex Pattern Widget'),
      ),
      body: Center(
        child: CustomPaint(
          size: const Size(400, 400),
          painter: PatternPainter(),
        ),
      ),
    );
  }
}

class PatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    var sideLength = 20.0;
    var gap = 10.0;

    for (double x = 0; x < size.width; x += sideLength + gap) {
      for (double y = 0; y < size.height; y += sideLength + gap) {
        canvas.drawRect(Rect.fromLTWH(x, y, sideLength, sideLength), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
