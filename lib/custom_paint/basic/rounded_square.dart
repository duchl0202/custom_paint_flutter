import 'package:flutter/material.dart';

class RoundedSquareWidget extends StatelessWidget {
  const RoundedSquareWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rounded Square Widget'),
      ),
      body: Center(
        child: CustomPaint(
          size: Size(200, 200),
          painter: RoundedSquarePainter(),
        ),
      ),
    );
  }
}

class RoundedSquarePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    final double side = 100;
    final double radius = 20;
    final Rect rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: side,
      height: side,
    );

    final RRect roundedRect =
        RRect.fromRectAndRadius(rect, Radius.circular(radius));
    canvas.drawRRect(roundedRect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
