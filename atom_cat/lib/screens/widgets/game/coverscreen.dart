import 'package:flutter/material.dart';

class CoverScreen extends StatelessWidget {
  final bool gameHasStarted;

  const CoverScreen({super.key, required this.gameHasStarted});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(0, -0.2),
      child: Text(gameHasStarted ? '' : 'Н А Ж М И Т Е  Д Л Я  И Г Р Ы',
          style: const TextStyle(color: Colors.white)),
    );
  }
}
