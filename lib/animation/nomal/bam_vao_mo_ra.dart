import 'package:flutter/material.dart';
import 'dart:math';

import 'dart:math' as math;

import 'package:flutter/material.dart';

class BamVaoMoRa extends StatefulWidget {
  @override
  _BamVaoMoRaState createState() => _BamVaoMoRaState();
}

class _BamVaoMoRaState extends State<BamVaoMoRa>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _expandAnimation;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 2 * pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _expandAnimation = Tween<double>(begin: 0.0, end: 70.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleAnimation() {
    if (_isExpanded) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    _isExpanded = !_isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bấm vào mở ra'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _toggleAnimation,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  for (int i = 0; i < 5; i++)
                    Transform.translate(
                      offset: Offset(
                        _expandAnimation.value * cos(2 * pi * i / 5),
                        _expandAnimation.value * sin(2 * pi * i / 5),
                      ),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.yellow,
                        child: Icon(
                          _getIconForIndex(i),
                          color: Colors.black,
                        ),
                      ),
                    ),
                  Transform.rotate(
                    angle: _rotationAnimation.value,
                    child: const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.orange,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.image;
      case 1:
        return Icons.language;
      case 2:
        return Icons.videocam;
      case 3:
        return Icons.chat;
      case 4:
        return Icons.headphones;
      default:
        return Icons.star;
    }
  }
}
