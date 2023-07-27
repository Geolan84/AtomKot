import 'package:atom_cat/domain/api_client/api_client.dart';
import 'package:atom_cat/domain/repositories/auth_repository.dart';
import 'package:atom_cat/screens/navigation/main_navigation.dart';
import 'package:atom_cat/screens/utils.dart';
import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  final _authService = AuthRepository();

  final TextEditingController emailTextInputController =
      TextEditingController();
  final TextEditingController passwordTextInputController =
      TextEditingController();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  //BuildContext? _context;

  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  Future<String?> _login(String login, String password) async {
    await _authService.login(login, password);
    return null;
  }

  Future<void> auth(BuildContext context) async {
    final login = emailTextInputController.text;
    final password = passwordTextInputController.text;

    if (!validateEmail(login) || !validatePassword(password)) {
      _updateState("Некорректный формат данных!", false);
      return;
    }
    //_context = context;
    _updateState(null, true);
    //Try to auth.
    _errorMessage = await _login(login, password);
    if (_errorMessage == null) {
      MainNavigation.resetNavigation(context);
    } else {
      _updateState(_errorMessage, false);
    }
  }

  void _updateState(String? errorMessage, bool isAuthProgress) {
    if (_errorMessage == errorMessage && _isAuthProgress == isAuthProgress) {
      return;
    }
    _errorMessage = errorMessage;
    _isAuthProgress = isAuthProgress;
    notifyListeners();
  }
}