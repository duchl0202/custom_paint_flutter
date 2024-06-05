import 'package:flutter/material.dart';

class HalfCircleWidget extends StatelessWidget {
  const HalfCircleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Half Circle Widget'),
      ),
      body: Center(
        child: HalfCircle(size: 200),
      ),
    );
  }
}

class HalfCircle extends StatefulWidget {
  const HalfCircle({
    required this.size,
    super.key,
  });

  final double size;

  @override
  State<HalfCircle> createState() => _HalfCircleState();
}

class _HalfCircleState extends State<HalfCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 6),
    )..repeat();
    super.initState();
    _controller.addListener(() {
      setState(() {});
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
      size: Size(widget.size, widget.size / 2),
      painter: HalfCircleProgressPainter(
        progress: _controller.value,
      ),
    );
  }
}

class HalfCircleProgressPainter extends CustomPainter {
  HalfCircleProgressPainter({
    required this.progress,
  });

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < 10; i++) {
      final double progressCur = (progress + i * 0.1) % 1.0;
      final double radius = size.width / 1.5 * progressCur;
      paint.color = Colors.black.withOpacity(1 - progressCur);
      canvas.drawCircle(Offset(size.width / 2, size.height), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
