import 'dart:math' as math;

import 'package:flutter/material.dart';

class QuaCauBayVaNayLen extends StatefulWidget {
  @override
  _QuaCauBayVaNayLenState createState() => _QuaCauBayVaNayLenState();
}

class _QuaCauBayVaNayLenState extends State<QuaCauBayVaNayLen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.bounceIn))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    double maxHeight = -MediaQuery.of(context).size.height / 2 - 150;
    return Scaffold(
      appBar: AppBar(
        title: Text('Quả cầu bay và nẩy lên'),
      ),
      body: Column(
        children: [
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.translate(
                offset: Offset(0, _animation.value * maxHeight),
                child: CustomPaint(
                  painter: BallPainter(),
                  child: Container(
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class BallPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.blue;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 25, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
