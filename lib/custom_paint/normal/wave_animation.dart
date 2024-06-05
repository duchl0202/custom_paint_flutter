import 'dart:math';

import 'package:flutter/material.dart';

class WaveAnimation extends StatefulWidget {
  @override
  _WaveAnimationState createState() => _WaveAnimationState();
}

class _WaveAnimationState extends State<WaveAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: WavePainter(_controller.value),
          child: Container(),
        );
      },
    );
  }
}

class WavePainter extends CustomPainter {
  final double wavePhase;

  WavePainter(this.wavePhase);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final Path path = Path();

    final double waveHeight = 30.0;
    final double waveLength = size.width;

    path.moveTo(0, size.height / 2);

    for (double i = 0; i < waveLength; i++) {
      final y = size.height / 2 +
          waveHeight * (sin((i / waveLength * 2 * pi) + (wavePhase * 2 * pi)));
      path.lineTo(i, y);
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
