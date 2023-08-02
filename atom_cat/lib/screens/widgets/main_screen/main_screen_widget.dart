import 'package:atom_cat/domain/repositories/auth_repository.dart';
import 'package:atom_cat/screens/navigation/main_navigation.dart';
import 'package:atom_cat/screens/widgets/arrows/carnight_arrows.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

import 'dart:async';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  MainScreenWidgetState createState() => MainScreenWidgetState();
}

class MainScreenWidgetState extends State<MainScreenWidget>
    with SingleTickerProviderStateMixin {
  final _authService = AuthRepository();
  static const _volumeBtnChannel = MethodChannel("mychannel");

  int _index = 5;
  int _counter = 180;
  Timer? _timer;

  @override
  void initState() {
    _volumeBtnChannel.setMethodCallHandler((call) {
      if (call.method == "volumeBtnPressed") {
        if (call.arguments == "volume_down") {
          setState(() {
            _index = 4;
          });
        } else if (call.arguments == "volume_up") {
          setState(() {
            _index = 5;
          });
        }
      }
      return Future.value(null);
    });
    super.initState();
  }

  void _startTimer() {
    _counter = 180;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  Widget getTimerWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${(_counter ~/ 60).toString().padLeft(2, '0')}:${(_counter % 60).toString().padLeft(2, '0')}",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 130,
          ),
        ),
        ElevatedButton(
            onPressed: () {
              _startTimer();
            },
            child: const Text('Start Timer')),
      ],
    );
  }

  Widget getMainButton(String title, String description, String section) {
    return GestureDetector(
      child: Card(
        margin: const EdgeInsets.all(5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        color: const Color.fromARGB(255, 16, 23, 40),
        child: SizedBox(
          width: 290,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/icons/$section.png',
                  height: 70,
                  width: 70,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
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
        setState(() {
          _index = switch (section) {
            "carnight" => 0,
            "paramed" => 1,
            "ai" => 2,
            "game" => 3,
            _ => 0
          };
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 9, 14, 26),
      body: Row(
        children: [
          Container(
            width: 76,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: const Color.fromARGB(255, 16, 23, 40),
            ),
            margin: const EdgeInsets.fromLTRB(10, 30, 5, 10),
            padding: const EdgeInsets.only(top: 7.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/profile.jpg'),
                      radius: 32.0,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      margin: const EdgeInsets.all(5.0),
                      height: 65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: const Color.fromARGB(255, 25, 32, 52),
                      ),
                      child: Center(
                        child: IconButton(
                          icon: SvgPicture.asset('assets/icons/settings.svg'),
                          onPressed: () {},
                          // icon: const Icon(
                          //   Icons.settings,
                          //   color: Colors.white,
                          //   size: 32,
                          // ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(5.0),
                      height: 65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: const Color.fromARGB(255, 25, 32, 52),
                      ),
                      child: Center(
                        child: IconButton(
                          icon: SvgPicture.asset('assets/icons/adds.svg'),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(5.0),
                  height: 65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: const Color.fromARGB(255, 25, 32, 52),
                  ),
                  child: Center(
                    child: IconButton(
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.red,
                        size: 30,
                      ),
                      onPressed: () {
                        _authService.logout();
                        Navigator.of(context).pushReplacementNamed(
                            MainNavigationRouteNames.loaderWidget);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  getMainButton("Ночной водитель",
                      "Помогает не заснуть во время поездки", "carnight"),
                  getMainButton("Парамедик",
                      "Инструкция по оказанию первой помощи", "paramed"),
                  getMainButton("Ассистент",
                      "Анализ дорожного покрытия, аккумулятора и др.", "ai"),
                  getMainButton("Игры", "Время развлечений!", "game"),
                ],
              ),
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: _index,
              children: [
                Center(
                  child: getTimerWidget(),
                ),
                const Center(
                  child: Text(
                    "Paramedic",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Center(
                  child: Image.asset('assets/images/analysis.png'),
                ),
                const Center(
                  //child: Image.asset('assets/images/game')
                  child: Text("game"),
                ),
                const LeftArrowWidget(),
                const RightArrowWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }
}
