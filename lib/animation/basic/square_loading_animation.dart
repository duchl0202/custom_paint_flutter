import 'package:flutter/material.dart';

class SquareLoadingAnimation extends StatefulWidget {
  @override
  _SquareLoadingAnimationState createState() => _SquareLoadingAnimationState();
}

class _SquareLoadingAnimationState extends State<SquareLoadingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 12),
    );

    _animation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 0.6).chain(
          CurveTween(curve: Curves.linear),
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.6, end: 0.0).chain(
          CurveTween(curve: Curves.linear),
        ),
        weight: 0.2,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 0.4).chain(
          CurveTween(curve: Curves.linear),
        ),
        weight: 0.8,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.4, end: 0.0).chain(
          CurveTween(curve: Curves.linear),
        ),
        weight: 0.2,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 1.0).chain(
          CurveTween(curve: Curves.linear),
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.0).chain(
          CurveTween(curve: Curves.linear),
        ),
        weight: 0.5,
      ),
    ]).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Square Loading Animation')),
      body: Center(
        child: CustomPaint(
          painter: SquareBorderPainter(animation: _animation),
          child: const SizedBox(
            width: 300,
            height: 300,
          ),
        ),
      ),
    );
  }
}

class SquareBorderPainter extends CustomPainter {
  final Animation<double> animation;

  SquareBorderPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    double progress = animation.value * 4;
    double halfWidth = size.width / 2;

    if (progress <= 1) {
      path.moveTo(halfWidth, 0);
      path.lineTo(halfWidth + progress * halfWidth, 0);
      path.moveTo(halfWidth, 0);
      path.lineTo(halfWidth - progress * halfWidth, 0);
    } else if (progress <= 2) {
      path.moveTo(halfWidth, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, (progress - 1) * size.height);
      path.moveTo(halfWidth, 0);
      path.lineTo(0, 0);
      path.lineTo(0, (progress - 1) * size.height);
    } else if (progress <= 3) {
      path.moveTo(halfWidth, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width - (progress - 2) * size.width, size.height);
      path.moveTo(halfWidth, 0);
      path.lineTo(0, 0);
      path.lineTo(0, size.height);
      path.lineTo((progress - 2) * size.width, size.height);
    } else {
      path.moveTo(halfWidth, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.lineTo(0, size.height - (progress - 3) * size.height);
      path.moveTo(halfWidth, 0);
      path.lineTo(0, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, size.height - (progress - 3) * size.height);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
