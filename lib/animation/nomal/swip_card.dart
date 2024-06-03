import 'package:flutter/material.dart';

class SwipeCardDemo extends StatefulWidget {
  @override
  _SwipeCardDemoState createState() => _SwipeCardDemoState();
}

class _SwipeCardDemoState extends State<SwipeCardDemo> {
  List<String> cards = ["Card 1", "Card 2", "Card 3", "Card 4"].reversed.toList();
  Offset cardOffset = Offset.zero;
  double rotationAngle = 0.0;
  int cardCount = 4;

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      cardOffset += details.delta;
      rotationAngle = 0.1 * (cardOffset.dx / 100);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (cardOffset.dx > 100 || cardOffset.dx < -100) {
      setState(() {
        cards.removeLast();
        cardOffset = Offset.zero;
        rotationAngle = 0.0;
        cardCount++;
        cards.insert(0, "Card $cardCount");
      });
    } else {
      setState(() {
        cardOffset = Offset.zero;
        rotationAngle = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: cards.asMap().entries.map((entry) {
          int index = entry.key;
          String card = entry.value;
          return Positioned(
            top: 50.0 + index * 10,
            left: 20.0 + index * 10,
            child: index == cards.length - 1
                ? DraggableCard(
                    card: card,
                    onPanUpdate: _onPanUpdate,
                    onPanEnd: _onPanEnd,
                    cardOffset: cardOffset,
                    rotationAngle: rotationAngle,
                  )
                : StaticCard(card: card),
          );
        }).toList(),
      ),
    );
  }
}

class DraggableCard extends StatelessWidget {
  final String card;
  final Function onPanUpdate;
  final Function onPanEnd;
  final Offset cardOffset;
  final double rotationAngle;

  DraggableCard({
    required this.card,
    required this.onPanUpdate,
    required this.onPanEnd,
    required this.cardOffset,
    required this.rotationAngle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) => onPanUpdate(details),
      onPanEnd: (details) => onPanEnd(details),
      child: Transform.translate(
        offset: cardOffset,
        child: Transform.rotate(
          angle: rotationAngle,
          child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              width: 300,
              height: 400,
              child: Center(
                child: Text(
                  card,
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StaticCard extends StatelessWidget {
  final String card;

  StaticCard({required this.card});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        width: 300,
        height: 400,
        child: Center(
          child: Text(
            card,
            style: TextStyle(fontSize: 24.0),
          ),
        ),
      ),
    );
  }
}

