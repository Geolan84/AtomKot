import 'package:flutter/material.dart';
import 'package:atom_cat/screens/navigation/main_navigation.dart';

class AtomApp extends StatelessWidget {
  static final mainNavigation = MainNavigation();
  const AtomApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AtomCat',
      routes: mainNavigation.routes,
      //onGenerateRoute: mainNavigation.onGenerateRoute,
    );
  }
}