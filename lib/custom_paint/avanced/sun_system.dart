import 'dart:math';

import 'package:flutter/material.dart';

class SunSystemWidget extends StatefulWidget {
  const SunSystemWidget({super.key});

  @override
  State<SunSystemWidget> createState() => _SunSystemWidgetState();
}

class _SunSystemWidgetState extends State<SunSystemWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Sun System')),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: SolarSystemPainter(_controller.value),
            child: Container(),
          );
        },
      ),
    );
  }
}

class SolarSystemPainter extends CustomPainter {
  final double time;
  SolarSystemPainter(this.time);

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);

    void drawPlanet(
        double radian, double speed, double radianPlant, Color color) {
      double angle = time * 2 * pi * speed;
      Offset planPositions = Offset(
        center.dx + radian * (cos(angle)),
        center.dy + radian * (sin(angle)),
      );
      if (color == Color.fromARGB(255, 15, 88, 197)) {
        double monthRadian = 20;
        double angleMonth = time * 2 * pi * 100;
        Offset monthPositions = Offset(
          planPositions.dx + monthRadian * (cos(angleMonth)),
          planPositions.dy + monthRadian * (sin(angleMonth)),
        );
        canvas.drawCircle(monthPositions, 5, Paint()..color = Colors.grey);
      }
      canvas.drawCircle(planPositions, radianPlant, Paint()..color = color);
    }

    drawPlanet(30, 3, 5, Color.fromARGB(255, 138, 138, 138));
    drawPlanet(50, 5, 8, Color.fromARGB(255, 230, 128, 32));
    drawPlanet(80, 8, 13, Color.fromARGB(255, 15, 88, 197));
    drawPlanet(130, 13, 10, Color.fromARGB(255, 223, 16, 5));

    canvas.drawCircle(center, 20, Paint()..color = Colors.yellow);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
