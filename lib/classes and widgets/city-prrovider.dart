import 'package:flutter/material.dart';

class CityProvider extends ChangeNotifier {
  String _selectedCity = "Jerusalem";

  String get selectedCity => _selectedCity;
  void changeSelectedCity(String city){
    _selectedCity = city;
    notifyListeners();
  }
}