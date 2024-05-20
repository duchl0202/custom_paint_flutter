import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Resizable & Rotatable Widget'),
        ),
        body: Center(
          child: ResizableRotatableWidget(),
        ),
      ),
    );
  }
}

class ResizableRotatableWidget extends StatefulWidget {
  @override
  _ResizableRotatableWidgetState createState() => _ResizableRotatableWidgetState();
}

class _ResizableRotatableWidgetState extends State<ResizableRotatableWidget> {
  double _scale = 1.0;
  double _rotation = 0.0;
  Offset _initialPosition = Offset.zero;

  void _onPanStart(DragStartDetails details) {
    _initialPosition = details.globalPosition;
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      Offset currentPosition = details.globalPosition;
      Offset delta = currentPosition - _initialPosition;

      // Tính toán scale dựa trên độ dài của delta
      double newScale = 1.0 + delta.distance / 200.0;
      _scale = newScale < 1.0 ? 1.0 : newScale;

      // Tính toán góc quay dựa trên sự thay đổi theo trục y của delta
      _rotation = delta.dy / 100.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform(
          transform: Matrix4.identity()
            ..scale(_scale)
            ..rotateZ(_rotation),
          alignment: FractionalOffset.center,
          child: Container(
            width: 200,
            height: 200,
            color: Colors.blue,
            child: Stack(
              children: [
                Center(
                  child: Text(
                    'Drag the red box',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onPanStart: _onPanStart,
                    onPanUpdate: _onPanUpdate,
                    child: Container(
                      width: 30,
                      height: 30,
                      color: Colors.red,
                      child: Center(
                        child: Icon(
                          Icons.open_with,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
