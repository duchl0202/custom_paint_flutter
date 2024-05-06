import 'package:flutter/material.dart';

class SmileyPainter extends CustomPainter {
  SmileyPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 2, paint);

    canvas.drawCircle(
        Offset(size.width / 3, size.height / 3), size.width / 10, Paint());
    canvas.drawCircle(
        Offset(size.width / 1.5, size.height / 3), size.width / 10, Paint());

    final smilePaint = Paint();
    smilePaint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    final smilePath = Path();

    smilePath.moveTo(size.width * 0.35, size.height * 0.65);

    smilePath.quadraticBezierTo(size.width / 2, size.height * 0.85,
        size.width * 0.65, size.height * 0.65);
    smilePath.moveTo(size.width * 0.65, size.height * 0.65);

    canvas.drawPath(smilePath, smilePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
