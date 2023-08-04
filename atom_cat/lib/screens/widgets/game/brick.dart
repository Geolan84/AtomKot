import 'package:flutter/material.dart';

class MyBrick extends StatelessWidget {
  final double x;
  final double y;
  final double brickWidth; // out of 2
  final thisIsEnemy;

  const MyBrick({super.key, required this.x, required this.y, required this.brickWidth, this.thisIsEnemy});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment((2 * x + brickWidth) / (2 - brickWidth), y),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: thisIsEnemy ? const Color.fromARGB(255, 55, 15, 124): const Color.fromARGB(255, 157, 11, 60),
            height: 20,
            width: MediaQuery.of(context).size.width *brickWidth/2,
          ),
        ));
  }
}
