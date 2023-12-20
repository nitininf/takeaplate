import 'package:flutter/material.dart';

class SelectImageProvider extends ChangeNotifier {
  String _selectedImage = ''; // Initially empty, you can set a default value.

  String get selectedImage => _selectedImage;

  void setSelectedImage(String image) {
    _selectedImage = image;
    notifyListeners();
  }
}
