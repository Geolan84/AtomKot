import 'package:flutter/material.dart';
import 'package:atom_cat/domain/api_client/api_client.dart';



class MainScreenViewModel extends ChangeNotifier{
  final _apiClient = ApiClient();
  String _address = "Нажмите верхнюю кнопку для определения геолокации";
  String _coords = "Координаты: -";
  bool _progress = false;

  String get address => _address;
  String get coords => _coords;
  bool get progress => _progress;

  Future<void> updateAddress(double lat, double lon, {int radius=50}) async{
    _address = await _apiClient.getGeoAddress(lat, lon, radius);
    _coords = "$lat, $lon";
    _progress = false;
    notifyListeners();
  }

  void startProgress(){
    _progress = true;
    notifyListeners();
  }

}