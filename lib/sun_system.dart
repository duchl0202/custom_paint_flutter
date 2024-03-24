import 'dart:math';

import 'package:flutter/material.dart';

class SunSystem extends StatefulWidget {
  const SunSystem({super.key});

  @override
  State<SunSystem> createState() => _SunSystemState();
}

class _SunSystemState extends State<SunSystem>
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: SolarSystemPainter(_controller.value * 60),
          child: Container(),
        );
      },
    );
  }
}

class MasterPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.strokeWidth = 2;
    paint.color = Colors.black;

    canvas.drawCircle(Offset.zero, 40, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class SolarSystemPainter extends CustomPainter {
  final double time;
  SolarSystemPainter(this.time);

  // void drawPlanet(Canvas canvas, Color color, double distanceFromSun,
  //     double size, double orbitTime, Offset sunPosition, double angleOffset) {
  //   double angle = time * (2 * math.pi / orbitTime) + angleOffset;
  //   Offset planetPosition = Offset(
  //       sunPosition.dx + distanceFromSun * math.cos(angle),
  //       sunPosition.dy + distanceFromSun * math.sin(angle));
  //   canvas.drawCircle(planetPosition, size, Paint()..color = color);
  // }

  void drawMoon(Canvas canvas, Offset planetPosition, double distanceFromPlanet,
      double size, double orbitTime, double time, Color color) {
    double angle = time * (2 * pi / orbitTime);
    Offset moonPosition = Offset(
        planetPosition.dx + distanceFromPlanet * cos(angle),
        planetPosition.dy + distanceFromPlanet * sin(angle));
    canvas.drawCircle(moonPosition, size, Paint()..color = color);
  }

  void drawPlanet(Canvas canvas, Color color, double distanceFromSun,
      double size, double orbitTime, Offset sunPosition, double angleOffset) {
    double angle = time * (2 * pi / orbitTime) + angleOffset;
    Offset planetPosition = Offset(
        sunPosition.dx + distanceFromSun * cos(angle),
        sunPosition.dy + distanceFromSun * sin(angle));
    canvas.drawCircle(planetPosition, size, Paint()..color = color);

    if (color == Colors.blue) {
      drawMoon(
          canvas, planetPosition, 15, 3, 1, time, Colors.grey); // Vẽ Mặt Trăng
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final double maxOrbitRadius = min(size.width, size.height) / 3;

    // Draw Sun
    canvas.drawCircle(center, 20, Paint()..color = Colors.yellow);

    // Draw Planets with varying orbitTime to simulate different speeds
    drawPlanet(
        canvas, Colors.grey, maxOrbitRadius * 0.2, 5, 3, center, 0); // Mercury
    drawPlanet(
        canvas, Colors.orange, maxOrbitRadius * 0.35, 8, 5, center, 1); // Venus
    drawPlanet(
        canvas, Colors.blue, maxOrbitRadius * 0.5, 10, 8, center, 2); // Earth
    drawPlanet(
        canvas, Colors.red, maxOrbitRadius * 0.65, 7, 13, center, 3); // Mars
    // Thêm các hành tinh khác nếu muốn
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
