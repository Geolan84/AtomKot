import 'package:atom_cat/domain/repositories/auth_repository.dart';
import 'package:atom_cat/screens/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  

  @override
  MainScreenWidgetState createState() => MainScreenWidgetState();
}

class MainScreenWidgetState extends State<MainScreenWidget> {

  final _authService = AuthRepository();

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
                      backgroundImage: AssetImage('assets/images/cat.jpg'),
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
                          icon: const Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: 32,
                          ),
                          onPressed: () {},
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
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 32,
                          ),
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
          //),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            child: const SingleChildScrollView(
              child: Column(
                children: [
                  _MainButton("Ночной водитель",
                      "Помогает не заснуть во время поездки", "carnight"),
                  _MainButton("Парамедик",
                      "Инструкция по оказанию первой помощи", "paramed"),
                  _MainButton("Ассистент",
                      "Анализ дорожного покрытия, аккумулятора и др.", "ai"),
                  _MainButton("Игры", "Время развлечений!", "game"),
                ],
              ),
            ),
          ),
          const Expanded(
            child: IndexedStack(index: 1, children: [],)
            
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

  const _MainButton(this.title, this.description, this.section);

  @override
  Widget build(BuildContext context) {
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
        Navigator.of(context).pushReplacementNamed('/$section');
      },
    );
  }
}
