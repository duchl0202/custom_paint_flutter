import 'package:flutter/material.dart';
import 'dart:math';

class PentagonWidget extends StatelessWidget {
  const PentagonWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pentagon Widget'),
      ),
      body: Center(
        child: CustomPaint(
          size: Size(400, 400),
          painter: PentagonPainter(progress: 0.5),
        ),
      ),
    );
  }
}

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

    final Offset startPath =
        Offset(radius * cos(0) + center.dx, radius * sin(0) + center.dy);
    path.moveTo(startPath.dx, startPath.dy);

    for (var i = 0; i <= side; i++) {
      final x = center.dx + radius * cos(i * angle);
      final y = center.dy + radius * sin(i * angle);
      path.lineTo(x, y);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
