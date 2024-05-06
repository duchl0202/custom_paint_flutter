import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_custom_pain/example/basic/rectangle_gradient.dart';
import 'package:flutter_custom_pain/example/basic/smile.dart';
import 'package:flutter_custom_pain/example/basic/pentagon.dart';
import 'package:flutter_custom_pain/example/basic/cloud_painter.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: false);
    _animation = Tween<double>(begin: 0.1, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Flutter custom paint')),
        body: Center(
          child: Container(
            color: Colors.grey,
            child: CustomPaint(
              size: Size(200, 200), // You can change this as needed
              painter: RectangleGradient(),
            ),
          ),
        ),
      ),
    );
  }
}
