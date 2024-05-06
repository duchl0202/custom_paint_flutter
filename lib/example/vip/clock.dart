import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class SmoothSecondHandClock extends StatefulWidget {
  @override
  _SmoothSecondHandClockState createState() => _SmoothSecondHandClockState();
}

class _SmoothSecondHandClockState extends State<SmoothSecondHandClock>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 60),
    );

    // Cập nhật AnimationController để phản ánh thời gian thực
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      final second = now.second + now.millisecond / 1000.0;
      _controller.value = second / 60;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: ClockPainter(_controller.value),
          size: Size(200, 200),
        );
      },
    );
  }
}

class ClockPainter extends CustomPainter {
  final double animationValue;
  ClockPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final dateTime = DateTime.now();
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2);

    final secondAngle = math.pi * 2 * animationValue;
    drawHand(
        canvas, center, secondAngle - math.pi / 2, radius * 0.9, Colors.red, 2);
  }

  void drawHand(Canvas canvas, Offset center, double angle, double length,
      Color color, double strokeWidth) {
    final position = center + Offset(math.cos(angle), math.sin(angle)) * length;
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(center, position, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
