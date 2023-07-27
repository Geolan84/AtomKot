import 'package:flutter/material.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  MainScreenWidgetState createState() => MainScreenWidgetState();
}

class MainScreenWidgetState extends State<MainScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 9, 14, 26),
      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset(
                "assets/animations/car.gif",
                height: 200.0,
                width: 200.0,
              ),
            ),
          ),
          const _MainButtons()
        ],
      ),
    );
  }
}

class _MainButtons extends StatelessWidget {
  const _MainButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              _MainButton("Ночной водитель",
                  "Помогает не заснуть во время поездки", "carnight"),
              _MainButton("Парамедик", "Инструкция по оказанию первой помощи",
                  "paramed"),
            ],
          ),
          Row(
            children: [
              _MainButton("Ассистент",
                  "Анализ дорожного покрытия, аккумулятора и др.", "ai"),
              _MainButton("Игры", "Время развлечений!", "game"),
            ],
          ),
        ],
      ),
    );
  }
}

class _MainButton extends StatelessWidget {
  final String title;
  final String description;
  final String section;

  //const _MainButton({Key? key}) : super(key: key);
  const _MainButton(this.title, this.description, this.section);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        margin: const EdgeInsets.all(5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        color: const Color.fromARGB(255, 22, 28, 44),
        child: SizedBox(
          width: 300,
          height: 190,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/icons/$section.png',
                  height: 79,
                  width: 94,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(
                    title,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 22),
                  ),
                ),
                Text(
                  description,
                  textAlign: TextAlign.start,
                  style: const TextStyle(color: Colors.white, fontSize: 17),
                )
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        print("Replace to /$section");
        Navigator.of(context).pushReplacementNamed('/$section');
      },
    );
  }
}
