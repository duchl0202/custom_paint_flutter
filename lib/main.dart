import 'package:flutter/material.dart';
import 'package:flutter_custom_pain/custom_paint_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Custom Pain"),
        ),
        body: Center(
          child: Container(
            color: Colors.grey.shade300,
            child: CustomPaintWidget(),
          ),
        ),
      ),
    );
  }
}
