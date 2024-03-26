import 'package:flutter/material.dart';
import 'package:flutter_custom_pain/example/custom/duong_zigzag.dart';

class Day2Example extends StatefulWidget {
  const Day2Example({super.key});

  @override
  State<Day2Example> createState() => _Day2ExampleState();
}

class _Day2ExampleState extends State<Day2Example>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   width: _animation.value,
    //   height: _animation.value,
    //   color: Colors.red,
    // );
    return CustomPaint(
      size: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      painter: DuongZigzagPainter(),
      // child: AnimatedBuilder(
      //   animation: _controller,
      //   builder: (context, child) {
      //     return Transform.translate(
      //       offset: Offset(
      //           _controller.value * MediaQuery.of(context).size.width,
      //           MediaQuery.of(context).size.height / 2),
      //       child: child,
      //     );
      //   },
      //   child: Container(
      //     width: 20,
      //     height: 20,
      //     color: Colors.red,
      //   ),
      // ),
    );
  }
}
