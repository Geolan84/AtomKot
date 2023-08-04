import 'dart:async';

import 'package:atom_cat/screens/widgets/game/brick.dart';
import 'package:atom_cat/screens/widgets/game/scorescreen.dart';
import 'package:flutter/material.dart';
import 'package:atom_cat/screens/widgets/game/ball.dart';
import 'package:atom_cat/screens/widgets/game/coverscreen.dart';
import 'package:flutter/services.dart';

enum direction { UP, DOWN, LEFT, RIGHT }

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //player varibles (botoom brick)
  double playerX = -0.2;
  double brickWidth = 0.4; //out of 2
  int playerScore = 0;

  //enemy variables (top brick)
  double enemyX = -0.2;
  int enemyScore = 0;

  //ball variables
  double ballX = 0;
  double ballY = 0;
  var ballYDirection = direction.DOWN;
  var ballXDirection = direction.LEFT;
  //game settings
  bool gameHasStarted = false;

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 1), (timer) {
      // update direction
      updateDirection();

      // move ball
      moveBall();

      //move enemy
      moveEnemy();

      // check if player is dead
      if (isPlayerDead()) {
        enemyScore++;
        timer.cancel();
        _showDiaolog(false);
      }

      if (isEnemyDead()) {
        playerScore++;
        timer.cancel();
        _showDiaolog(true);
      }
    });
  }

  bool isEnemyDead() {
    if (ballY <= -1) {
      return true;
    }
    return false;
  }

  void moveEnemy() {
    setState(() {
      enemyX = ballX;
    });
  }

  void _showDiaolog(bool enemyDied) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 178, 137, 250),
            title: Center(
                child: Text(
              enemyDied ? "РОЗОВЫЕ ВЫИГРАЛИ" : "ФИОЛЕТОВЫЕ ВЫИГРАЛИ",
              style: const TextStyle(color: Colors.white),
            )),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    color: enemyDied
                        ? const Color.fromARGB(255, 225, 88, 88)
                        : const Color.fromARGB(255, 57, 14, 136),
                    child: Text(
                      'ИГРАТЬ СНОВА',
                      style: TextStyle(
                          color: enemyDied
                              ? Colors.pink[600]
                              : const Color.fromARGB(255, 191, 173, 226)),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      gameHasStarted = false;
      ballX = 0;
      ballY = 0;
      playerX = -0.2;
      enemyX = -0.2;
    });
  }

  bool isPlayerDead() {
    if (ballY >= 1) {
      return true;
    }
    return false;
  }

  void updateDirection() {
    //update vertical direction
    setState(() {
      if (ballY >= 0.9 && playerX + brickWidth >= ballX && playerX <= ballX) {
        ballYDirection = direction.UP;
      } else if (ballY <= -0.9) {
        ballYDirection = direction.DOWN;
      }

      // update horizontal direction
      if (ballX >= 1) {
        ballXDirection = direction.LEFT;
      } else if (ballX <= -1) {
        ballXDirection = direction.RIGHT;
      }
    });
  }

  void moveBall() {
    setState(() {
      //vertical movement
      if (ballYDirection == direction.DOWN) {
        ballY += 0.001;
      } else if (ballYDirection == direction.UP) {
        ballY -= 0.001;
      }

      //horizontal movement
      if (ballXDirection == direction.LEFT) {
        ballX -= 0.001;
      } else if (ballXDirection == direction.RIGHT) {
        ballX += 0.001;
      }
    });
  }

  void moveLeft() {
    setState(() {
      if (!(playerX - 0.1 <= -1)) {
        playerX -= 0.1;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (!(playerX + brickWidth >= 1)) {
        playerX += 0.1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        }
      },
      child: GestureDetector(
        onTap: (){
          if(!gameHasStarted){
              startGame();
          }
        },
        child: Scaffold(
            backgroundColor: const Color.fromRGBO(9, 14, 26, 1),
            body: Center(
                child: Stack(
              children: [
                //tap to play
                CoverScreen(
                  gameHasStarted: gameHasStarted,
                ),

                //score screen
                ScoreScreen(
                  gameHasStarted: gameHasStarted,
                  enemyScore: enemyScore,
                  playerScore: playerScore,
                ),

                //enemy (top brick)
                MyBrick(
                  x: enemyX,
                  y: -0.9,
                  brickWidth: brickWidth,
                  thisIsEnemy: true,
                ),

                //player (bottom brick)
                MyBrick(
                    x: playerX,
                    y: 0.9,
                    brickWidth: brickWidth,
                    thisIsEnemy: false),

                //ball
                MyBall(
                  x: ballX,
                  y: ballY,
                  gameHasStarted: gameHasStarted,
                ),
              ],
            ))),
      ),
    );
  }
}
