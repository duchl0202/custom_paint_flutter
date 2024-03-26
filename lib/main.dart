import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Animation Zigzag')),
        body: ZigzagAnimationWidget(),
      ),
    );
  }
}

class ZigzagAnimationWidget extends StatefulWidget {
  @override
  _ZigzagAnimationWidgetState createState() => _ZigzagAnimationWidgetState();
}

class _ZigzagAnimationWidgetState extends State<ZigzagAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    // Áp dụng Curve vào animation
    final curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastEaseInToSlowEaseOut, // Sử dụng Curves.decelerate
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });

    _controller.repeat(reverse: true); // Bắt đầu animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      painter: ZigzagSquarePainter(_animation.value),
    );
  }
}

class ZigzagSquarePainter extends CustomPainter {
  final double progress;

  ZigzagSquarePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    final squarePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final Path path = Path();

    // Di chuyển đến điểm đầu tiên của tam giác (đỉnh trên cùng)
    path.moveTo(size.width / 2, size.height / 4);

    // Thêm các đường thẳng để tạo thành hình tam giác
    path.lineTo(size.width / 4, size.height * 3 / 4); // Điểm góc dưới bên trái
    path.lineTo(
        size.width * 3 / 4, size.height * 3 / 4); // Điểm góc dưới bên phải
    path.close(); // Đóng đường dẫn để tạo thành một hình khép kín

    // Vẽ tam giác
    canvas.drawPath(path, paint);

    final squareSize = 10.0;
    final pathMetrics = path.computeMetrics();
    final pathMetric = pathMetrics.elementAt(0);
    final tangent =
        pathMetric.getTangentForOffset(pathMetric.length * progress);

    canvas.drawPath(path, paint);
    if (tangent != null) {
      final offset = tangent.position - Offset(squareSize / 2, squareSize / 2);
      canvas.drawRect(offset & Size(squareSize, squareSize), squarePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
