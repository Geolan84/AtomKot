import 'package:flutter/material.dart';

class ScoreScreen extends StatelessWidget {
  final bool gameHasStarted;
  final dynamic enemyScore;
  final dynamic playerScore;

  const ScoreScreen(
      {super.key, required this.gameHasStarted, this.enemyScore, this.playerScore});

  @override
  Widget build(BuildContext context) {
    return gameHasStarted
        ? Stack(
            children: [
              Container(
                alignment: const Alignment(0, 0),
                child: Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width / 3,
                  color: Colors.grey[800],
                ),
              ),
              Container(
                alignment: const Alignment(0, -0.3),
                child: Text(enemyScore.toString(),
                    style: TextStyle(color: Colors.grey[800], fontSize: 50)),
              ),
              Container(
                alignment: const Alignment(0, 0.3),
                child: Text(playerScore.toString(),
                    style: TextStyle(color: Colors.grey[800], fontSize: 50)),
              ),
            ],
          )
        : Container();
  }
}
