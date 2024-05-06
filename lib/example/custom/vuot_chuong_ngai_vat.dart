import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  double playerY = 0;
  final int numberOfObstacles = 3;
  final List<double> obstaclesX = [2, 2.5, 3];
  final List<double> obstaclesY = [0, 0, 0];
  double height = 0;
  double width = 0;
  bool gameHasStarted = false;
  Timer? timer;
  int score = 0;

  void startGame() {
    gameHasStarted = true;
    timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      updateGame();
    });
    score = 0;
  }

  void resetGame() {
    Navigator.pop(context); // Close the dialog
    setState(() {
      playerY = 0;
      obstaclesX.setAll(0, [2, 2.5, 3]);
      obstaclesY.setAll(0, [0, 0, 0]);
      gameHasStarted = false;
      score = 0;
    });
  }

  void updateGame() {
    setState(() {
      for (int i = 0; i < numberOfObstacles; i++) {
        obstaclesX[i] -= 0.05;
        if (obstaclesX[i] < -1.5) {
          obstaclesX[i] += 3.5;
          obstaclesY[i] = Random().nextDouble() * 2 - 1;
          score++;
        }
      }

      if (checkForCollision()) {
        timer?.cancel();
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Game Over'),
              content: Text('Your score: $score'),
              actions: <Widget>[
                TextButton(
                  onPressed: resetGame,
                  child: Text('Play Again'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  bool checkForCollision() {
    for (int i = 0; i < numberOfObstacles; i++) {
      if (obstaclesX[i] < -0.2 && obstaclesX[i] > -1.2) {
        double diffY = obstaclesY[i] - playerY;
        if (diffY.abs() < 0.1) return true;
      }
    }
    return false;
  }

  void movePlayer(double dy) {
    setState(() {
      playerY += 0.1 * dy;
      if (playerY > 1) playerY = 1;
      if (playerY < -1) playerY = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: GestureDetector(
        onTap: () {
          if (!gameHasStarted) startGame();
        },
        onVerticalDragUpdate: (details) {
          if (details.delta.dy > 0) {
            movePlayer(1);
          } else if (details.delta.dy < 0) {
            movePlayer(-1);
          }
        },
        child: Stack(
          children: [
            AnimatedContainer(
              alignment: Alignment(0, playerY),
              duration: Duration(milliseconds: 0),
              child: MyPlayer(),
            ),
            ...List.generate(numberOfObstacles, (index) {
              return AnimatedContainer(
                alignment: Alignment(obstaclesX[index], obstaclesY[index]),
                duration: Duration(milliseconds: 0),
                child: MyObstacle(),
              );
            }),
            Positioned(
              top: 80,
              right: 20,
              child: Text(
                'Score: $score',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: Colors.green,
        shape: BoxShape.circle,
      ),
    );
  }
}

class MyObstacle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: Colors.red,
        shape: BoxShape.rectangle,
      ),
    );
  }
}
