import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/scheduler.dart';

class ClockWidget extends StatefulWidget {
  const ClockWidget({super.key});

  @override
  State<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  double _seconds = 0;
  double _minutes = 0;
  double _hours = 0;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      final now = DateTime.now();
      setState(() {
        _seconds = now.second + (now.millisecond / 1000);
        _minutes = now.minute + (_seconds / 60);
        _hours = now.hour + (_minutes / 60);
      });
    })
      ..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clock Widget'),
      ),
      body: Center(
        child: CustomPaint(
          size: const Size(300, 300),
          painter: ClockPainter(
            seconds: _seconds,
            minutes: _minutes,
            hours: _hours,
          ),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  ClockPainter({
    required this.seconds,
    required this.minutes,
    required this.hours,
  });

  final double seconds;
  final double minutes;
  final double hours;
  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = min(size.width / 2, size.height / 2);
    const angleText = 2 * pi / 12;
    const angle60 = 2 * pi / 60;
    final paint60 = Paint()..color = Colors.black;

    for (int i = 1; i <= 12; i++) {
      final x = center.dx + (radius - 34) * cos(angleText * i - pi / 2);
      final y = center.dy + (radius - 34) * sin(angleText * i - pi / 2);
      final textSpan = TextSpan(
        text: i.toString(),
        style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      );

      final textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: size.width,
      );
      final position =
          Offset(x - textPainter.width / 2, y - textPainter.height / 2);

      textPainter.paint(canvas, position);
    }

    for (int i = 1; i <= 60; i++) {
      final x = center.dx + radius * cos(angle60 * i);
      final y = center.dy + radius * sin(angle60 * i);

      final startX = center.dx + (radius - 10) * cos(angle60 * i);
      final startY = center.dy + (radius - 10) * sin(angle60 * i);

      final start = Offset(startX, startY);
      final position = Offset(x, y);

      final isHour = i % 5 == 0;

      paint60.strokeWidth = isHour ? 3 : 1;

      canvas.drawLine(start, position, paint60);
    }
    canvas.drawCircle(center, 5, Paint()..style = PaintingStyle.fill);

    final minuteAngle = 2 * pi * (minutes / 60) - pi / 2;
    final minuteX = center.dx + radius * 0.8 * cos(minuteAngle);
    final minuteY = center.dy + radius * 0.8 * sin(minuteAngle);
    final minuteOffset = Offset(minuteX, minuteY);
    canvas.drawLine(
      center,
      minuteOffset,
      Paint()
        ..strokeWidth = 3
        ..color = Colors.black,
    );

    final hourAngle = 2 * pi * (hours / 12) - pi / 2;
    final hourX = center.dx + radius * 0.5 * cos(hourAngle);
    final hourY = center.dy + radius * 0.5 * sin(hourAngle);
    final hourOffset = Offset(hourX, hourY);
    canvas.drawLine(
      center,
      hourOffset,
      Paint()
        ..strokeWidth = 5
        ..color = Colors.black,
    );

    final x = center.dx + radius * cos(angle60 * seconds - pi / 2);
    final y = center.dy + radius * sin(angle60 * seconds - pi / 2);

    final secondOffset = Offset(x, y);
    canvas.drawLine(
      center,
      secondOffset,
      Paint()
        ..strokeWidth = 1
        ..color = Color.fromARGB(255, 255, 158, 13),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
