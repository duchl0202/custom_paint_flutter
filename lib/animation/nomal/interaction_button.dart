import 'package:flutter/material.dart';

class InteractionButton extends StatefulWidget {
  const InteractionButton({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _InteractionButtonState createState() => _InteractionButtonState();
}

class _InteractionButtonState extends State<InteractionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hiệu ứng Gradient Button'),
      ),
      body: Stack(
        children: [
          Container(
            width: 300,
            height: 100,
            color: Colors.blue,
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return ShaderMask(
                shaderCallback: (bounds) {
                  final double width = bounds.width;
                  final double dx = _controller.value * width;
                  return LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.transparent,
                      Colors.white.withOpacity(0.5),
                      Colors.transparent,
                    ],
                    stops: [
                      dx / width - 0.2,
                      dx / width,
                      dx / width + 0.2,
                    ],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.srcIn,
                child: Container(
                  width: 300,
                  height: 100,
                  color: Colors.blue,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
