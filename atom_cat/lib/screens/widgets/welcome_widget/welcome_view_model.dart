import 'package:atom_cat/domain/repositories/auth_repository.dart';
import 'package:atom_cat/screens/navigation/main_navigation.dart';
import 'package:flutter/material.dart';

class WelcomeViewModel {
  final BuildContext context;
  final _authService = AuthRepository();

  WelcomeViewModel(this.context) {
    asyncInit();
  }

  Future<void> asyncInit() async {
    await checkAuth();
  }

  Future<void> checkAuth() async {
    final isAuth = await _authService.isAuth();
    final String nextScreen;
    if(isAuth){
      nextScreen = MainNavigationRouteNames.mainScreen;
    } else{
      nextScreen = MainNavigationRouteNames.auth;
    }
    goToNextScreen(nextScreen);
  }

  void goToNextScreen(String nextScreen){
    Navigator.of(context).pushReplacementNamed(nextScreen);
  }
}