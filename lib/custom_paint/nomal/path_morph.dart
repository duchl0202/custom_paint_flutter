import 'dart:ui' as ui;


import 'package:flutter/material.dart';

class PathMorphPainter extends CustomPainter {
  final double progress;

  PathMorphPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final path = _createMorphPath(size, progress);
    canvas.drawPath(path, paint);
  }

  Path _createMorphPath(Size size, double progress) {
    final path1 = Path()
      ..moveTo(size.width * 0.25, size.height * 0.25)
      ..lineTo(size.width * 0.75, size.height * 0.25)
      ..lineTo(size.width * 0.75, size.height * 0.75)
      ..lineTo(size.width * 0.25, size.height * 0.75)
      ..close();

    final path2 = Path()
      ..addOval(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width * 0.25,
      ));

    return _interpolatePaths(path1, path2, progress);
  }

  Path _interpolatePaths(Path path1, Path path2, double progress) {
    final path = Path();
    final metrics1 = path1.computeMetrics().toList();
    final metrics2 = path2.computeMetrics().toList();

    if (metrics1.isEmpty || metrics2.isEmpty) return path;

    final metric1 = metrics1[0];
    final metric2 = metrics2[0];

    final length1 = metric1.length;
    final length2 = metric2.length;

    final longestLength = length1 > length2 ? length1 : length2;

    for (double i = 0; i <= longestLength; i++) {
      final t1 = i / longestLength * length1;
      final t2 = i / longestLength * length2;

      final pos1 = metric1.getTangentForOffset(t1)?.position ?? Offset.zero;
      final pos2 = metric2.getTangentForOffset(t2)?.position ?? Offset.zero;

      final interpolated = Offset(
        ui.lerpDouble(pos1.dx, pos2.dx, progress)!,
        ui.lerpDouble(pos1.dy, pos2.dy, progress)!,
      );

      if (i == 0) {
        path.moveTo(interpolated.dx, interpolated.dy);
      } else {
        path.lineTo(interpolated.dx, interpolated.dy);
      }
    }

    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
