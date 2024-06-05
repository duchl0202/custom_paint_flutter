import 'dart:math' as math;

import 'package:flutter/material.dart';

class HalfCircleProgressWidget extends StatelessWidget {
  const HalfCircleProgressWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Half Circle Widget'),
      ),
      body: Center(
        child: HalfCircleProgress(
          progress: 0.5,
          progressColor: Colors.blue,
          backgroundColor: Colors.grey,
        ),
      ),
    );
  }
}

class HalfCircleProgress extends StatefulWidget {
  final double progress;
  final Color progressColor;
  final Color backgroundColor;

  const HalfCircleProgress({
    required this.progress,
    required this.progressColor,
    required this.backgroundColor,
    Key? key,
  }) : super(key: key);

  @override
  State<HalfCircleProgress> createState() => _HalfCircleProgressState();
}

class _HalfCircleProgressState extends State<HalfCircleProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    ).drive(Tween<double>(begin: 0.0, end: widget.progress))
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
    super.initState();
  }

  @override
  void didUpdateWidget(HalfCircleProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.progress != oldWidget.progress) {
      _animation = Tween<double>(begin: 0.0, end: widget.progress).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeInOutCubic,
        ),
      )..addListener(() {
          setState(() {});
        });

      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(260, 130),
      painter: HalfCircleProgressPainter(
        progress: _animation.value,
        backgroundColor: widget.backgroundColor,
        progressColor: widget.progressColor,
      ),
    );
  }
}

class HalfCircleProgressPainter extends CustomPainter {
  final double progress;
  final Color backgroundColor;
  final Color progressColor;

  HalfCircleProgressPainter({
    required this.progress,
    this.backgroundColor = Colors.grey,
    this.progressColor = Colors.blue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeWidth = 18
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height * 2),
      math.pi,
      math.pi,
      false,
      paint,
    );

    paint.color = progressColor;

    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height * 2),
      math.pi,
      math.pi * progress,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
