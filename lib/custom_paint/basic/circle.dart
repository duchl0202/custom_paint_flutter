import 'package:flutter/material.dart';

class CircleWidget extends StatelessWidget {
  const CircleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Circle Widget'),
      ),
      body: Center(
        child: CustomPaint(
          size: Size(200, 200),
          painter: CirclePainter(),
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    final double radius = 80;
    final Offset center = Offset(size.width / 2, size.height / 2);

    final Path path = Path();
    path.addOval(Rect.fromCircle(center: center, radius: radius));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}


