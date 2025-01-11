import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class CountdownScreen extends StatefulWidget {
  const CountdownScreen({Key? key}) : super(key: key);

  @override
  State<CountdownScreen> createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Timer _timer;

  Duration countdownDuration =
      const Duration(seconds: 10); // Thời gian đếm ngược
  Duration remainingTime = const Duration(seconds: 10);

  @override
  void initState() {
    super.initState();

    // Animation Controller để điều khiển hiệu ứng sóng
    _controller = AnimationController(
      vsync: this,
      duration: countdownDuration,
    )..addListener(() {
        setState(() {});
      });

    // Timer để cập nhật thời gian còn lại
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.inSeconds > 0) {
        setState(() {
          remainingTime -= const Duration(seconds: 1);
        });
      } else {
        _timer.cancel();
        _controller.stop();
      }
    });

    _controller.forward(); // Bắt đầu hiệu ứng sóng
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  String formatDuration(Duration duration) {
    String hours = duration.inHours.toString().padLeft(2, '0');
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    double progress = _controller.value; // Giá trị tiến trình (0 -> 1)

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hiệu ứng Gradient Button'),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: CustomPaint(
          painter: WavePainter(progress, _controller.value * 6 * pi),
          child: SizedBox(
            width: 200,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  formatDuration(remainingTime),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'To start drying',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  final double progress;
  final double time; // Thêm tham số thời gian

  WavePainter(this.progress, this.time);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint wavePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    double radius = size.width / 2;
    Offset center = Offset(size.width / 2, size.height / 2);

    Path wavePath = Path();

    int waveCount = 20;

    for (double angle = -pi / 2;
        angle < -pi / 2 + 2 * pi * progress;
        angle += 0.01) {
      double waveFactor = sin(waveCount * angle + time);
      double waveRadius = radius + 3 * waveFactor;
      double x = center.dx + waveRadius * cos(angle);
      double y = center.dy + waveRadius * sin(angle);

      if (angle == -pi / 2) {
        wavePath.moveTo(x, y);
      } else {
        wavePath.lineTo(x, y);
      }
    }

    canvas.drawPath(wavePath, wavePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
