import 'package:flutter/material.dart';

class JapanFlagWidget extends StatelessWidget {
  const JapanFlagWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Japan Flag Widget'),
      ),
      body: Center(
        child: CustomPaint(
          size: Size(300, 200),
          painter: JapanFlagPainter(),
        ),
      ),
    );
  }
}

class JapanFlagPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final Rect backgroundRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(backgroundRect, whitePaint);

    final redPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.height * 0.3;

    canvas.drawCircle(center, radius, redPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
