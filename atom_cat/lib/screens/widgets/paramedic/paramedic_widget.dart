import 'package:atom_cat/screens/navigation/main_navigation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

class ParamedicWidget extends StatefulWidget {
  const ParamedicWidget({Key? key}) : super(key: key);

  @override
  ParamedicWidgetState createState() => ParamedicWidgetState();
}

class ParamedicWidgetState extends State<ParamedicWidget> {
  Position? _currentPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 9, 14, 26),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(
                        MainNavigationRouteNames.mainScreen);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: GestureDetector(
                          child: Image.asset(
                            "assets/icons/phone.png",
                            height: 90.0,
                            width: 90.0,
                          ),
                          onTap: () async {
                            LocationPermission permission;
                            permission = await Geolocator.checkPermission();
                            if (permission == LocationPermission.denied) {
                              permission = await Geolocator.requestPermission();
                              if (permission ==
                                  LocationPermission.deniedForever) {
                                return;
                              }
                            }
                            Geolocator.getCurrentPosition(
                                    desiredAccuracy: LocationAccuracy.best,
                                    forceAndroidLocationManager: true)
                                .then((Position position) {
                              setState(() {
                                _currentPosition = position;
                                print(
                                    "LAT: ${_currentPosition!.latitude}, LNG: ${_currentPosition!.longitude}");
                              });
                            }).catchError((e) {
                              print(e);
                            });
                          })),
                ),
                const Expanded(flex: 5, child: Text("HELP HELP HELP!")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
