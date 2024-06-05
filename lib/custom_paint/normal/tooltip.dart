import 'package:flutter/material.dart';

class TooltipWidget extends StatefulWidget {
  const TooltipWidget({
    super.key,
  });

  @override
  State<TooltipWidget> createState() => _TooltipWidgetState();
}

class _TooltipWidgetState extends State<TooltipWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 8).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
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
        title: const Text('Tooltip Widget'),
      ),
      body: Center(
        child: Transform.translate(
          offset: Offset(0, _animation.value - 18),
          child: CustomPaint(
            size: Size(300, 300),
            painter: RoundedRectPainter(
              text: 'Flutter custom paint widget',
              padding: 4.0,
            ),
          ),
        ),
      ),
    );
  }
}

class RoundedRectPainter extends CustomPainter {
  final String text;
  final double padding;

  RoundedRectPainter({
    required this.text,
    this.padding = 10.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.amber
      ..style = PaintingStyle.fill;

    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 16,
    );
    final textSpan = TextSpan(text: text, style: textStyle);

    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    final textWidth = textPainter.width;
    final textHeight = textPainter.height;

    final rectWidth = textWidth + 2 * padding;
    final rectHeight = textHeight + 2 * padding;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        (size.width - rectWidth) / 2,
        (size.height - rectHeight) / 2,
        rectWidth,
        rectHeight,
      ),
      const Radius.circular(4),
    );

    canvas.drawRRect(rect, paint);

    final offset = Offset(
      (size.width - textWidth) / 2,
      (size.height - textHeight) / 2,
    );

    final path = Path();

    path.moveTo(rect.right - 10, rect.bottom);
    path.lineTo(rect.right - 20, rect.bottom + 10);
    path.lineTo(rect.right - 30, rect.bottom);
    path.close();

    canvas.drawPath(path, paint);

    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
