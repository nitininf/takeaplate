import 'package:flutter/cupertino.dart';

class FavCardsProvider extends ChangeNotifier {
  List<Map<String, dynamic>> items = [
    {
      'name': 'Surprise Pack',
      'restaurant': 'Salad & Co',
      'time': 'Tomorrow-7:35-8:40 Am',
      'rating': 4,
      'distance': '84 Km',
      'price': '9.99',
      'image': 'assets/food_image.png',
    },
    {
      'name': 'Elite Pack',
      'restaurant': 'Eat Fit',
      'time': 'Tomorrow-10:35-11:40 Am',
      'rating': 3,
      'distance': '14 Km',
      'price': '5.99',
      'image': 'assets/food_image.png',
    },
    {
      'name': 'Golden Pack',
      'restaurant': 'Champaran House',
      'time': 'Tomorrow-10:35-11:40 Am',
      'rating': 5,
      'distance': '14 Km',
      'price': '15.99',
      'image': 'assets/food_image.png',
    },
    // Add more dummy data as needed
  ];
}