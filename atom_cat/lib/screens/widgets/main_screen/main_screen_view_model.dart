import 'package:flutter/material.dart';
import 'package:atom_cat/domain/api_client/api_client.dart';
// import 'package:atom_cat/domain/repositories/paramed_repository.dart';
// import 'package:flutter/services.dart' show rootBundle;

class MainScreenViewModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  //final _paramedRepo = ParamedRepository();
  String _address = "Нажмите верхнюю кнопку для определения геолокации";
  String _coords = "Координаты: -";
  bool _progress = false;

  String get address => _address;
  String get coords => _coords;
  bool get progress => _progress;

  Future<void> updateAddress(double lat, double lon, {int radius = 50}) async {
    _address = await _apiClient.getGeoAddress(lat, lon, radius);
    _coords = "$lat, $lon";
    _progress = false;
    notifyListeners();
  }

  // Future<String> loadAsset(String title) async {
  //   return await rootBundle.loadString('assets/texts/$title.txt');
  // }

  void startProgress() {
    _progress = true;
    notifyListeners();
  }
}
