import 'package:flutter/material.dart';

class DuongZigzagWidget extends StatefulWidget {
  const DuongZigzagWidget({Key? key}) : super(key: key);

  @override
  State<DuongZigzagWidget> createState() => _DuongZigzagWidgetState();
}

class _DuongZigzagWidgetState extends State<DuongZigzagWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    controller.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Duong Zigzag Widget'),
      ),
      body: Center(
        child: CustomPaint(
          size: const Size(400, 400),
          painter: DuongZigzagPainter(progress: animation.value),
        ),
      ),
    );
  }
}

class DuongZigzagPainter extends CustomPainter {
  DuongZigzagPainter({this.progress = 0.0});
  final double progress;
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    var path = Path();
    path.moveTo(0, size.height * 0.5 + 20);
    var width = size.width / 10;
    var height = 20.0;

    for (int i = 0; i < 10; ++i) {
      var x = width * (i + 1);
      var y = size.height * 0.5 + (i % 2 == 0 ? -height : height);
      path.lineTo(x, y);
    }

    final squareSize = 10.0;
    final pathMetrics = path.computeMetrics();
    final pathMetric = pathMetrics.elementAt(0);
    final tangent =
        pathMetric.getTangentForOffset(pathMetric.length * progress);

    canvas.drawPath(path, paint);
    if (tangent != null) {
      final offset = tangent.position - Offset(squareSize / 2, squareSize / 2);
      canvas.drawRect(offset & Size(squareSize, squareSize), Paint());
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
