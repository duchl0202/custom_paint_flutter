import 'package:flutter/material.dart';

class MultipleTicker extends StatefulWidget {
  @override
  _MultipleTickerState createState() => _MultipleTickerState();
}

class _MultipleTickerState extends State<MultipleTicker> with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;

  @override
  void initState() {
    super.initState();
    _controller1 = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this, // Sử dụng TickerProviderStateMixin để cung cấp Ticker
    )..repeat(reverse: true);
    _controller2 = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    _controller1.addListener(() {
      // Thêm listener để cập nhật UI khi giá trị thay đổi
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Multiple Ticker ')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FadeTransition(
              opacity: _controller1,
              child: FlutterLogo(size: 100),
            ),
            SizedBox(height: 20),
            FadeTransition(
              opacity: _controller2,
              child: FlutterLogo(size: 100),
            ),
          ],
        ),
      ),
    );
  }
}
