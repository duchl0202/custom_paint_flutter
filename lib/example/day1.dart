import 'package:flutter/material.dart';

class Day1Example extends StatefulWidget {
  const Day1Example({super.key});

  @override
  State<Day1Example> createState() => _Day1ExampleState();
}

class _Day1ExampleState extends State<Day1Example>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOut, // Sử dụng đường cong để làm mượt animation
    ).drive(Tween(begin: 0.0, end: 1.0)); // Tween từ 0 đến 1

    // _animation = Tween<double>(begin: 0, end: 200).animate(_controller)
    //   ..addListener(() {
    //     setState(() {});
    //   });
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   width: _animation.value,
    //   height: _animation.value,
    //   color: Colors.red,
    // );
    return FadeTransition(
      opacity: _animation,
      child: Container(
        width: 200,
        height: 200,
        color: Colors.red,
      ),
    );
  }
}
