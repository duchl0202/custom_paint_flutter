import 'dart:math';

import 'package:flutter/material.dart';

class ColumnChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double barWidth = size.width / 10;
    final double maxWidth = size.width;
    final double maxHeight = size.height;

    var paint = Paint()..style = PaintingStyle.fill;

    // Định nghĩa dữ liệu
    List<Map<String, dynamic>> data = [
      {"label": "A", "value": 150.0, "color": Colors.red},
      {"label": "B", "value": 120.0, "color": Colors.green},
      {"label": "C", "value": 180.0, "color": Colors.blue},
    ];

    // Tính tỷ lệ để vẽ biểu đồ
    final double maxBarHeight = maxHeight * 0.75;
    final highestValue = data.map((e) => e['value'] as double).reduce(max);

    for (int i = 0; i < data.length; i++) {
      final barHeight =
          (data[i]['value'] as double) / highestValue * maxBarHeight;
      final barColor = data[i]['color'] as Color;
      final labelText = data[i]['label'] as String;
      final valueText = data[i]['value'].toString();

      paint.color = barColor;

      // Vẽ cột
      final left = (maxWidth / data.length) * i + barWidth;
      final top = maxHeight - barHeight;
      final right = left + barWidth;
      final bottom = maxHeight;
      canvas.drawRect(Rect.fromLTRB(left, top, right, bottom), paint);

      // Thêm nhãn cho mỗi cột
      final textSpanLabel =
          TextSpan(style: TextStyle(color: Colors.black), text: labelText);
      final textPainterLabel =
          TextPainter(text: textSpanLabel, textDirection: TextDirection.ltr);
      textPainterLabel.layout(minWidth: 0, maxWidth: barWidth);
      textPainterLabel.paint(canvas, Offset(left, maxHeight + 5));

      // Thêm giá trị số ở đỉnh cột
      final textSpanValue =
          TextSpan(style: TextStyle(color: Colors.black), text: valueText);
      final textPainterValue =
          TextPainter(text: textSpanValue, textDirection: TextDirection.ltr);
      textPainterValue.layout(minWidth: 0, maxWidth: barWidth);
      textPainterValue.paint(canvas, Offset(left, top - 20));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
