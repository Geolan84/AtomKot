import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:atom_cat/screens/widgets/welcome_widget/welcome_view_model.dart';
import 'package:atom_cat/screens/widgets/welcome_widget/welcome_widget.dart';
import 'package:atom_cat/screens/widgets/login/login_view_model.dart';
import 'package:atom_cat/screens/widgets/login/login_widget.dart';
import 'package:atom_cat/screens/widgets/main_screen/main_screen_widget.dart';
// import 'package:atom_cat/screens/widgets/carnight/car_night_view_model.dart';
import 'package:atom_cat/screens/widgets/carnight/car_night_widget.dart';
import 'package:atom_cat/screens/widgets/paramedic/paramedic_widget.dart';
import 'package:atom_cat/screens/widgets/paramedic/paramedic_view_model.dart';
import 'package:atom_cat/screens/widgets/main_screen/main_screen_view_model.dart';


class ScreenFactory {
  Widget makeLoader() {
    return Provider(
      create: (context) => WelcomeViewModel(context),
      lazy: false,
      child: const WelcomeWidget(),
    );
  }

  Widget makeAuth() {
    return ChangeNotifierProvider(
      create: (_) => AuthViewModel(),
      child: const AuthWidget(),
    );
  }



  // Widget makeCarNight() {
  //   return ChangeNotifierProvider(
  //     create: (_) => AuthViewModel(),
  //     child: const AuthWidget(),
  //   );
  // }

  // Widget makeProfile() {
  //   return ChangeNotifierProvider(
  //     create: (_) => ProfileViewModel(),
  //     child: const ProfileWidget(),
  //   );
  // }


  Widget makeParamedic() {
    return ChangeNotifierProvider(
      create: (_) => ParamedicViewModel(),
      child: const ParamedicWidget(),
    );
  }
  //   Widget makeParamedic() {
  //   return const ParamedicWidget();
  // }

  Widget makeMainScreen() {
    return ChangeNotifierProvider(
      create: (_) => MainScreenViewModel(),
      child: const MainScreenWidget(),
    );
    // return const MainScreenWidget();
  }

  Widget makeCarNight(){
    return const CarNightWidget();
  }

  // Widget makeSettings() {
  //   return ChangeNotifierProvider(
  //     create: (_) => SettingsViewModel(),
  //     child: const SettingsPage(),
  //   );
  // }

}