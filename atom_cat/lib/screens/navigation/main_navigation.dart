import 'package:atom_cat/domain/screen_factory.dart';
import 'package:flutter/material.dart';

abstract class MainNavigationRouteNames {
  static const loaderWidget = '/';
  static const auth = '/auth';
  static const mainScreen = '/main_screen';
  static const ai = 'ai';
  static const carnight = '/carnight';
  static const game = '/game';
  static const paramed = '/paramed';
  static const userProfileSettings = '/main_screen/profile';
}

class MainNavigation {
  static final _screenFactory = ScreenFactory();

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.loaderWidget: (_) => _screenFactory.makeLoader(),
    MainNavigationRouteNames.auth: (_) => _screenFactory.makeAuth(),
    MainNavigationRouteNames.mainScreen: (_) => _screenFactory.makeMainScreen(),
    MainNavigationRouteNames.carnight: (_) => _screenFactory.makeCarNight(),
  };

  // Route<Object> onGenerateRoute(RouteSettings settings) {
  //   switch (settings.name) {
  //     case MainNavigationRouteNames.userProfileSettings:
  //       return MaterialPageRoute(
  //         builder: (_) => _screenFactory.makeProfile(),
  //       );
  //     default:
  //       const widget = Text('Navigation error!!!');
  //       return MaterialPageRoute(builder: (_) => widget);
  //   }
  // }

  static void resetNavigation(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      MainNavigationRouteNames.loaderWidget,
      (route) => false,
    );
  }
}