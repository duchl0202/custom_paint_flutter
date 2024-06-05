import 'package:flutter/material.dart';

class TriangleWidget extends StatelessWidget {
  const TriangleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Triangle Widget'),
      ),
      body: Center(
        child: CustomPaint(
          size: const Size(400, 400),
          painter: MyPainter(),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 10
      ..color = Colors.brown
      ..style = PaintingStyle.fill;

    final Path path = Path();

    path.moveTo(size.width / 2, size.height / 4);

    path.lineTo(size.width / 4, size.height * 3 / 4);
    path.lineTo(size.width * 3 / 4, size.height * 3 / 4);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
