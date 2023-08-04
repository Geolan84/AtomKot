import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class MyBall extends StatelessWidget {
  final double x;
  final double y;
  final bool gameHasStarted;

  const MyBall({super.key, required this.x, required this.y, required this.gameHasStarted});

  @override
  Widget build(BuildContext context) {
    return gameHasStarted
        ? Container(
            alignment: Alignment(x, y),
            child: Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                width: 60,
                height: 60,
                child: Image.asset('assets/icons/atomlogo.png')),
          )
        : Container(
            alignment: Alignment(x, y),
            child: AvatarGlow(
              glowColor: const Color.fromARGB(0, 0, 255, 251),
              endRadius: 60.0,
              child: Material(
                elevation: 8.0,
                shape: const CircleBorder(),
                child: CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  radius: 30.0,
                  child: Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    width: 60,
                    height: 60,
                    child: Image.asset('assets/icons/atomlogo.png'),
                  ),
                ),
              ),
            ),
          );
  }
}
