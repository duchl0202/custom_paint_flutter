import 'package:flutter/material.dart';

class RotateTransitionExample extends StatefulWidget {
  @override
  _RotateTransitionExampleState createState() =>
      _RotateTransitionExampleState();
}

class _RotateTransitionExampleState extends State<RotateTransitionExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Advanced Animation")),
      body: Center(
        child: RotationTransition(
          turns: _controller,
          child: Container(
            width: 100.0,
            height: 100.0,
            color: Colors.blue,
          ),
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