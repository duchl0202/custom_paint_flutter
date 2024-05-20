import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/scheduler.dart';

class ClockPainter extends CustomPainter {
  ClockPainter({required this.progress});

  final double progress;

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

    final x = center.dx + radius * cos(angle60 * progress - pi / 2);
    final y = center.dy + radius * sin(angle60 * progress - pi / 2);

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
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  double _seconds = 0;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      final now = DateTime.now();
      setState(() {
        _seconds = now.second + (now.millisecond / 1000);
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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Flutter Custom Paint')),
        body: Center(
          child: CustomPaint(
            size: Size(300, 300),
            painter: ClockPainter(
              progress: _seconds,
            ),
          ),
        ),
      ),
    );
  }
}
