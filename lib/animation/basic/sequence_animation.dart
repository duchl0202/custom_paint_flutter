import 'package:flutter/material.dart';

class SequenceAnimationExample extends StatefulWidget {
  @override
  _SequenceAnimationExampleState createState() =>
      _SequenceAnimationExampleState();
}

class _SequenceAnimationExampleState extends State<SequenceAnimationExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _animation = TweenSequence(
      [
        TweenSequenceItem(tween: Tween(begin: 0.0, end: 250.0), weight: 1),
        TweenSequenceItem(tween: Tween(begin: 250.0, end: 300.0), weight: 1),
        TweenSequenceItem(tween: Tween(begin: 300.0, end: 250.0), weight: 1),
        TweenSequenceItem(tween: Tween(begin: 250.0, end: 0.0), weight: 1),
      ],
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sequence Animation Example')),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              width: _animation.value,
              height: _animation.value,
              color: Colors.blue,
            );
          },
        ),
      ),
    );
  }
}
