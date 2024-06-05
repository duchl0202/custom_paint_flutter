import 'package:flutter/material.dart';

class RectangleGradientWidget extends StatelessWidget {
  const RectangleGradientWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rectangle Gradient Widget'),
      ),
      body: Center(
        child: CustomPaint(
          size: const Size(400, 400),
          painter: RectangleGradient(),
        ),
      ),
    );
  }
}

class RectangleGradient extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const gradient = LinearGradient(
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
