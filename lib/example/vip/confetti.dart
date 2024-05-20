
import 'dart:math';

import 'package:flutter/material.dart';

class ConfettiWidget extends StatefulWidget {
  @override
  _ConfettiWidgetState createState() => _ConfettiWidgetState();
}

class _ConfettiWidgetState extends State<ConfettiWidget>
    with SingleTickerProviderStateMixin {
  List<Offset> positions = [];
  List<Color> colors = [];
  List<double> velocities = [];
  List<double> anglesX = [];
  List<double> anglesY = [];
  List<double> angularVelocitiesX = [];
  List<double> angularVelocitiesY = [];
  final Random random = Random();
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5))
          ..addListener(() {
            _updatePositions();
          })
          ..repeat();

    _initializeConfetti();
  }

  void _initializeConfetti() {
    for (int i = 0; i < 100; i++) {
      positions
          .add(Offset(random.nextDouble() * 400, random.nextDouble() * 800));
      colors.add(Color.fromARGB(
          255, random.nextInt(256), random.nextInt(256), random.nextInt(256)));
      velocities.add(random.nextDouble() * 4 + 2);
      anglesX.add(random.nextDouble() * 2 * pi);
      anglesY.add(random.nextDouble() * 2 * pi);
      angularVelocitiesX.add(random.nextDouble() * 0.1 - 0.05);
      angularVelocitiesY.add(random.nextDouble() * 0.1 - 0.05);
    }
  }

  void _updatePositions() {
    setState(() {
      for (int i = 0; i < positions.length; i++) {
        positions[i] = Offset(positions[i].dx, positions[i].dy + velocities[i]);
        anglesX[i] += angularVelocitiesX[i];
        anglesY[i] += angularVelocitiesY[i];
        velocities[i]; // Tăng tốc độ để tạo hiệu ứng rơi tự do

        if (positions[i].dy > 800) {
          // Đặt lại vị trí khi confetti rơi xuống quá thấp
          positions[i] = Offset(random.nextDouble() * 400, 0);
          velocities[i] = random.nextDouble() * 4 + 2;
          anglesX[i] = random.nextDouble() * 2 * pi;
          anglesY[i] = random.nextDouble() * 2 * pi;
          angularVelocitiesX[i] = random.nextDouble() * 0.1 - 0.05;
          angularVelocitiesY[i] = random.nextDouble() * 0.1 - 0.05;
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ConfettiPainter(positions, colors, velocities, anglesX, anglesY,
          angularVelocitiesX, angularVelocitiesY, 10, 20),
      child: Container(
        width: 400,
        height: 800,
      ),
    );
  }
}

class ConfettiPainter extends CustomPainter {
  final List<Offset> positions;
  final List<Color> colors;
  final List<double> velocities;
  final List<double> anglesX;
  final List<double> anglesY;
  final List<double> angularVelocitiesX;
  final List<double> angularVelocitiesY;
  final double width;
  final double height;

  ConfettiPainter(
      this.positions,
      this.colors,
      this.velocities,
      this.anglesX,
      this.anglesY,
      this.angularVelocitiesX,
      this.angularVelocitiesY,
      this.width,
      this.height);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    for (int i = 0; i < positions.length; i++) {
      paint.color = colors[i];
      canvas.save();
      canvas.translate(positions[i].dx, positions[i].dy);

      // Tạo hiệu ứng quay 3D bằng cách sử dụng ma trận biến đổi
      final Matrix4 transform = Matrix4.identity()
        ..rotateX(anglesX[i])
        ..rotateY(anglesY[i]);

      final Rect rect =
          Rect.fromCenter(center: Offset(0, 0), width: width, height: height);

      canvas.transform(transform.storage);
      canvas.drawRect(rect, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
