import 'package:atom_cat/screens/navigation/main_navigation.dart';
import 'package:atom_cat/screens/widgets/paramedic/paramedic_view_model.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:atom_cat/domain/models/article.dart';

class ParamedicWidget extends StatefulWidget {
  const ParamedicWidget({Key? key}) : super(key: key);

  @override
  ParamedicWidgetState createState() => ParamedicWidgetState();
}

class ParamedicWidgetState extends State<ParamedicWidget> {
  int _index = 0;
  List<Article> articlesList = [
    Article('assets/images/plast.png', 'Отморожение и переохлаждение',
        'Утеплить пораженные участки тела и обездвижить их, укутать пострадавшего теплой одеждой или пледом, дать теплое питье, переместить в теплое помещение.'),
    Article('assets/images/plast.png', 'Кровотечение', 'Нужно остановить'),
    Article('assets/images/plast.png', 'Кровотечение', 'Нужно остановить'),
    Article('assets/images/plast.png', 'Кровотечение', 'Нужно остановить'),
    Article('assets/images/plast.png', 'Кровотечение', 'Нужно остановить'),
    Article('assets/images/plast.png', 'Кровотечение', 'Нужно остановить'),
  ];

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ParamedicViewModel>();
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
                    padding: const EdgeInsets.all(35.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(model.address,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                                child: Image.asset(
                                  "assets/icons/phone.png",
                                  height: 90.0,
                                  width: 90.0,
                                ),
                                onTap: () {}),
                            GestureDetector(
                              child: Image.asset(
                                "assets/icons/geolocation.png",
                                height: 90.0,
                                width: 90.0,
                              ),
                              onTap: () async {
                                LocationPermission permission;
                                permission = await Geolocator.checkPermission();
                                if (permission == LocationPermission.denied) {
                                  permission =
                                      await Geolocator.requestPermission();
                                  if (permission ==
                                      LocationPermission.deniedForever) {
                                    return;
                                  }
                                }
                                var res = await Geolocator.getCurrentPosition(
                                    desiredAccuracy: LocationAccuracy.best);
                                model.updateAddress(
                                    res.latitude, res.longitude);
                              },
                            ),
                          ],
                        ),
                        const Text(
                            "Указать место ДТП, количество пострадавших, их пол, примерный возраст, наличие у них сознания, дыхания, кровотечения, переломов и других травм.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ),
                ),
                const Expanded(
                  flex: 5,
                  child: Center(child: Text("djfnvdjf")
                      // child: SizedBox(
                      //   height: 550, // card height
                      //   child: PageView.builder(
                      //     itemCount: 10,
                      //     controller: PageController(viewportFraction: 0.7),
                      //     onPageChanged: (int index) =>
                      //         setState(() => _index = index),
                      //     itemBuilder: _buildListItem,
                      //   ),
                      // ),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int i) {
    print(i);
    Article product = articlesList[i];

    return Transform.scale(
      scale: i == _index ? 1 : 0.9,
      child: Card(
        elevation: 6,
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: Column(children: [
          Image.asset(
            product.imagePath,
            fit: BoxFit.fill,
            // width: 150,
            // height: 100,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              product.title,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              product.text,
              style: TextStyle(fontSize: 22),
            ),
          ),
        ])),
      ),
    );
  }
}
