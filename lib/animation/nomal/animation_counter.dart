import 'package:flutter/material.dart';

class AnimatedFlipCounter extends StatelessWidget {
  final int value;

  const AnimatedFlipCounter({
    Key? key,
    required this.value,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final prototypeDigit = TextPainter(
      text: TextSpan(text: '0', style: TextStyle(fontSize: 20)),
      textDirection: TextDirection.ltr,
    )..layout();

    final int intValue = value.round();
    final List<int> digits =
        intValue.toString().split('').map(int.parse).toList();

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      textDirection: TextDirection.ltr,
      children: digits.map((digit) {
        return _SingleDigitFlipCounter(
          value: digit.toDouble(),
          size: prototypeDigit.size,
        );
      }).toList(),
    );
  }
}

class _SingleDigitFlipCounter extends StatelessWidget {
  final double value;
  final Size size;

  const _SingleDigitFlipCounter({
    Key? key,
    required this.value,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(end: value),
      duration: const Duration(milliseconds: 300),
      builder: (_, double value, __) {
        final whole = value ~/ 1;
        final decimal = value - whole;
        final w = size.width;
        final h = size.height;

        return SizedBox(
          width: w,
          height: h,
          child: Stack(
            children: <Widget>[
              _buildSingleDigit(
                digit: whole % 10,
                offset: h * decimal,
                opacity: 1 - decimal,
              ),
              _buildSingleDigit(
                digit: (whole + 1) % 10,
                offset: h * decimal - h,
                opacity: decimal,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSingleDigit({
    required int digit,
    required double offset,
    required double opacity,
  }) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: offset,
      child: Opacity(
        opacity: opacity.clamp(0, 1),
        child: Text(
          '$digit',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter = _counter + 123;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedFlipCounter(value: _counter),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                onPressed: _decrementCounter,
                tooltip: 'Decrement',
                child: Icon(Icons.remove),
              ),
              SizedBox(width: 20),
              FloatingActionButton(
                onPressed: _incrementCounter,
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
