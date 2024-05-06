import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 10
      ..color = Colors.brown
      ..style = PaintingStyle.fill; // Chọn PaintingStyle.fill để lấp đầy tam giác

    // Tạo một đối tượng Path để định hình tam giác
    final Path path = Path();

    // Di chuyển đến điểm đầu tiên của tam giác (đỉnh trên cùng)
    path.moveTo(size.width / 2, size.height / 4);

    // Thêm các đường thẳng để tạo thành hình tam giác
    path.lineTo(size.width / 4, size.height * 3 / 4); // Điểm góc dưới bên trái
    path.lineTo(size.width * 3 / 4, size.height * 3 / 4); // Điểm góc dưới bên phải
    path.close(); // Đóng đường dẫn để tạo thành một hình khép kín

    // Vẽ tam giác
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
