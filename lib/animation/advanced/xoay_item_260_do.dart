import 'package:flutter/material.dart';
import 'dart:math' as math;

class RotatingImage extends StatefulWidget {
  @override
  _RotatingImageState createState() => _RotatingImageState();
}

class _RotatingImageState extends State<RotatingImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 2 * math.pi).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(_animation.value),
        child: Text('Xoay 360 độ', style: TextStyle(fontSize: 30)));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
