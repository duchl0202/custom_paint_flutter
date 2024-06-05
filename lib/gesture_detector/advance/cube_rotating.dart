import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class CubePainter extends CustomPainter {
  final double angleX;
  final double angleY;

  CubePainter({required this.angleX, required this.angleY});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke;

    final double cubeSize = 100;
    final double halfCubeSize = cubeSize / 2;

    // Define the 8 vertices of the cube
    final vertices = [
      math.Vector3(-halfCubeSize, -halfCubeSize, -halfCubeSize),
      math.Vector3(halfCubeSize, -halfCubeSize, -halfCubeSize),
      math.Vector3(halfCubeSize, halfCubeSize, -halfCubeSize),
      math.Vector3(-halfCubeSize, halfCubeSize, -halfCubeSize),
      math.Vector3(-halfCubeSize, -halfCubeSize, halfCubeSize),
      math.Vector3(halfCubeSize, -halfCubeSize, halfCubeSize),
      math.Vector3(halfCubeSize, halfCubeSize, halfCubeSize),
      math.Vector3(-halfCubeSize, halfCubeSize, halfCubeSize),
    ];

    // Create rotation matrices
    final rotationX = math.Matrix4.rotationX(angleX);
    final rotationY = math.Matrix4.rotationY(angleY);

    // Apply the rotations to the vertices
    for (var vertex in vertices) {
      vertex.applyMatrix4(rotationX);
      vertex.applyMatrix4(rotationY);
    }

    // Center the cube in the middle of the canvas
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Draw the edges of the cube
    void drawLine(int start, int end) {
      final p1 =
          Offset(centerX + vertices[start].x, centerY + vertices[start].y);
      final p2 = Offset(centerX + vertices[end].x, centerY + vertices[end].y);
      canvas.drawLine(p1, p2, paint);
    }

    drawLine(0, 1);
    drawLine(1, 2);
    drawLine(2, 3);
    drawLine(3, 0);
    drawLine(4, 5);
    drawLine(5, 6);
    drawLine(6, 7);
    drawLine(7, 4);
    drawLine(0, 4);
    drawLine(1, 5);
    drawLine(2, 6);
    drawLine(3, 7);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RotatingCube extends StatefulWidget {
  @override
  _RotatingCubeState createState() => _RotatingCubeState();
}

class _RotatingCubeState extends State<RotatingCube> {
  double angleX = 0;
  double angleY = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          angleX += details.delta.dy * 0.01;
          angleY += details.delta.dx * 0.01;
        });
      },
      child: CustomPaint(
        size: Size(double.infinity, double.infinity),
        painter: CubePainter(angleX: angleX, angleY: angleY),
      ),
    );
  }
}

class CubeRotating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('3D Rotating Cube')),
      body: RotatingCube(),
    );
  }
}
