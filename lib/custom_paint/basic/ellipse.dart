import 'package:flutter/material.dart';

class EllipseWidget extends StatelessWidget {
  const EllipseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ellipse Widget'),
      ),
      body: Center(
        child: CustomPaint(
          size: Size(400, 400),
          painter: EllipsePainter(),
        ),
      ),
    );
  }
}

class EllipsePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    final Rect rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: 300,
      height: 150,
    );

    canvas.drawOval(rect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

void main() {
  runApp(MaterialApp(
    home: EllipseWidget(),
  ));
}
