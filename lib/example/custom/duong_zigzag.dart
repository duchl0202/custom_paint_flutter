import 'package:flutter/material.dart';

class DuongZigzagPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    var path = Path();
    // Điểm bắt đầu
    path.moveTo(0, size.height * 0.5);
    // Độ dài của mỗi "zig" và "zag"
    var width = size.width / 20;
    var height = 40.0;

    for (int i = 0; i < 20; i++) {
      var x = width * (i + 1);
      var y = size.height * 0.5 + (i % 2 == 0 ? -height : height);
      path.lineTo(x, y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
