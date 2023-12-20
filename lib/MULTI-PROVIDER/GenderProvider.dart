import 'package:flutter/material.dart';

class GenderProvider extends ChangeNotifier {
  String _selectedGender = ''; // Initially empty, you can set a default value.

  String get selectedGender => _selectedGender;

  void setSelectedGender(String gender) {
    _selectedGender = gender;
    notifyListeners();
  }
}
