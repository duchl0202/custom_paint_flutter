import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PumpAndBalloon extends StatefulWidget {
  @override
  _PumpAndBalloonState createState() => _PumpAndBalloonState();
}

class _PumpAndBalloonState extends State<PumpAndBalloon>
    with SingleTickerProviderStateMixin {
  double _balloonSize = 100;
  double _currentWidth = 100;
  double _pumpHandlePosition = 0;
  bool _isPopped = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isPopped = false;
          _balloonSize = 100;
          _currentWidth = 100;
          _pumpHandlePosition = 0;
        });
        _controller.reset();
      }
    });
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    if (_isPopped) return;

    setState(() {
      _pumpHandlePosition += details.delta.dy;
      if (_pumpHandlePosition < 0) {
        _pumpHandlePosition = 0;
      } else {
        if (details.delta.dy > 0) {
          _balloonSize += details.delta.dy;
        }
        _currentWidth += details.delta.dy;
      }
      if (_balloonSize >= MediaQuery.of(context).size.width * 0.75) {
        _isPopped = true;
        _controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pump and Balloon')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            _isPopped
                ? AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _animation.value,
                        child: CustomPaint(
                          size: Size(_balloonSize, _balloonSize),
                          painter: ExplosionPainter(),
                        ),
                      );
                    },
                  )
                : AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: _balloonSize,
                    height: _balloonSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                  ),
            Spacer(),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  bottom: 0,
                  child: CustomPaint(
                    size: Size(50, 100),
                    painter: PumpBodyPainter(),
                  ),
                ),
                Positioned(
                  bottom: 100,
                  child: Container(
                    width: 5,
                    height: (200 - _currentWidth).clamp(0, 1000),
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onVerticalDragUpdate: _onVerticalDragUpdate,
                  child: Container(
                    width: 100,
                    height: 200,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 100),
                          width: 100,
                          height: 30,
                          margin: EdgeInsets.only(top: _pumpHandlePosition),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class PumpBodyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue[200]!
      ..style = PaintingStyle.fill;

    final rect = Rect.fromLTWH(size.width / 4, 0, size.width / 2, size.height);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class PumpLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final start = Offset(size.width / 2, 0);
    final end = Offset(size.width / 2, size.height);
    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class ExplosionPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 10; i++) {
      final angle = i * 36.0;
      final radians = angle * (pi / 180);
      final x = size.width / 2 + 50 * (i % 2 == 0 ? 1 : -1) * cos(radians);
      final y = size.height / 2 + 50 * (i % 2 == 0 ? 1 : -1) * sin(radians);
      canvas.drawCircle(Offset(x, y), 10, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true; // Repaint mỗi khi cần
  }
}
