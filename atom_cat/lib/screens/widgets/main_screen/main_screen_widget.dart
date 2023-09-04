import 'package:audioplayers/audioplayers.dart';
import 'package:atom_cat/domain/repositories/auth_repository.dart';
import 'package:atom_cat/screens/navigation/main_navigation.dart';
import 'package:atom_cat/screens/widgets/arrows/carnight_arrows.dart';
import 'package:atom_cat/screens/widgets/main_screen/main_screen_view_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:atom_cat/screens/widgets/game/homepage.dart';

import 'dart:async';
import 'dart:math';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  MainScreenWidgetState createState() => MainScreenWidgetState();
}

class MainScreenWidgetState extends State<MainScreenWidget>
    with SingleTickerProviderStateMixin {
  final _authService = AuthRepository();
  final player = AudioPlayer();
  final randomNumberGenerator = Random();
  static const _volumeBtnChannel = MethodChannel("mychannel");
  static const _defaultTime = 5;

  int _index = 0;

  bool _carNightWorks = false;
  String _paramedTitle = "";
  String _paramedText = "";
  int _counter = _defaultTime;
  Timer? _timer;

  @override
  void initState() {
    _volumeBtnChannel.setMethodCallHandler((call) {
      if (call.method == "volumeBtnPressed") {
        if (call.arguments == "volume_down") {
          if (_index == 4) {
            player.stop();
            setState(() {
              _index = 0;
            });
            _counter = _defaultTime;
            _startTimer();
          }
        } else if (call.arguments == "volume_up") {
          if (_index == 5) {
            player.stop();
            setState(() {
              _index = 0;
            });
            _counter = _defaultTime;
            _startTimer();
          }
        }
      }
      return Future.value(null);
    });
    super.initState();
  }

  void _checkDriver() {
    var arrow = randomNumberGenerator.nextInt(2) + 4;
    player.play(AssetSource('audio/alarm.mp3'));
    setState(() {
      _index = arrow;
    });
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        _timer?.cancel();
        _checkDriver();
      }
    });
  }

  Future<void> getData() async {
    var res = await rootBundle.loadString('assets/texts/$_paramedTitle.txt');
    setState(() {
      _paramedText = res;
    });
  }

  Widget _getArticleWidget(BuildContext ctx) {
    //final model = context.watch<MainScreenViewModel>();

    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 30, 5.0, 5.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _paramedTitle,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              _paramedText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getParamedicSection(String title) {
    return GestureDetector(
      child: Card(
        margin: const EdgeInsets.all(5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        color: const Color.fromARGB(255, 25, 32, 52),
        child: SizedBox(
          width: 250,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    title,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        _paramedTitle = title;
        getData();
        setState(() {
          _index = 6;
        });
      },
    );
  }

  Widget _getParamedicSections() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _getParamedicSection("Порядок вызова скорой"),
        _getParamedicSection("Извлечение пострадавшего"),
        _getParamedicSection("Оценка состояния пострадавшего"),
        _getParamedicSection("Как общаться с пострадавшим"),
        _getParamedicSection("Общие принципы оказания первой помощи"),
        _getParamedicSection("Артериальное кровотечение"),
      ],
    );
  }

  Widget _getGeoButtons(BuildContext ctx) {
    final model = context.watch<MainScreenViewModel>();
    return Row(
      children: [
        Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: const Color.fromARGB(255, 25, 32, 52),
              ),
              child: Center(
                child: IconButton(
                  icon: SvgPicture.asset('assets/icons/geo.svg'),
                  onPressed: () async {
                    model.startProgress();
                    LocationPermission permission;
                    permission = await Geolocator.checkPermission();
                    if (permission == LocationPermission.denied) {
                      permission = await Geolocator.requestPermission();
                      if (permission == LocationPermission.deniedForever) {
                        return;
                      }
                    }
                    var res = await Geolocator.getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.best);
                    model.updateAddress(res.latitude, res.longitude);
                  },
                  iconSize: 80,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: const Color.fromARGB(255, 25, 32, 52),
              ),
              child: Center(
                child: IconButton(
                  icon: SvgPicture.asset('assets/icons/share.svg'),
                  onPressed: () {},
                  iconSize: 80,
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Container(
            height: 210,
            margin: const EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: const Color.fromARGB(255, 25, 32, 52),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: model.progress
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "Место ДТП",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          model.address,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 30),
                        ),
                        Text(
                          model.coords,
                          style: const TextStyle(
                              color: Colors.white54, fontSize: 30),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getCallField() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 30, bottom: 100),
            child: Text(
              "Медицинская\nпомощь",
              style: TextStyle(color: Colors.white, fontSize: 40),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 100,
            width: 370,
            child: ElevatedButton(
              onPressed: () async {
                await launchUrl(Uri.parse("tel://112"));
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(1.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.call,
                      size: 50,
                    ),
                    Text(
                      'Вызвать скорую',
                      style: TextStyle(fontSize: 30),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getParamedicWidget() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 30, 5, 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(child: _getCallField()),
                _getGeoButtons(context),
              ],
            ),
          ),
          SingleChildScrollView(child: _getParamedicSections())
        ],
      ),
    );
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
            fontSize: 150,
          ),
        ),
        RawMaterialButton(
          onPressed: () {
            if (_carNightWorks) {
              _timer?.cancel();
            } else {
              _startTimer();
            }
            setState(() {
              //_counter = 5;
              _carNightWorks = !_carNightWorks;
            });
          },
          elevation: 2.0,
          fillColor: Colors.white,
          padding: const EdgeInsets.all(15.0),
          shape: const CircleBorder(),
          child: Icon(
            _carNightWorks ? Icons.pause : Icons.play_arrow,
            size: 75.0,
          ),
        )
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
          width: 260,
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
                          iconSize: 40,
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
                  getMainButton("Советы при ДТП",
                      "Инструкция по оказанию первой помощи", "paramed"),
                  getMainButton("Дорожный ассистент",
                      "Анализ дорожного покрытия и др.", "ai"),
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
                _getParamedicWidget(),
                Center(
                  child: Image.asset('assets/images/analysis.png'),
                ),
                const HomePage(),
                const LeftArrowWidget(),
                const RightArrowWidget(),
                _getArticleWidget(context),
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
