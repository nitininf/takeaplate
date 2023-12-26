import 'dart:convert';

import 'package:flutter/material.dart';

class PlaceListProvider extends ChangeNotifier {
  List<Map<String, dynamic>> items =
  [
    {
      "title": "Salad & Co.",
      "category": "Health Foods",
      "offers": "3 offers available",
      "rating": 4,
      "image": "assets/restrorent_img.png"
    },
    {
      "title": "Smoothie Bar",
      "category": "Beverages",
      "offers": "2 offers available",
      "rating": 5,
      "image": "assets/smoothie_bar.png"
    },
    {
      "title": "Pizza Paradise",
      "category": "Italian",
      "offers": "5 offers available",
      "rating": 3.5,
      "image": "assets/pizza_paradise.png"
    },
    {
      "title": "Sushi House",
      "category": "Japanese",
      "offers": "4 offers available",
      "rating": 4.8,
      "image": "assets/sushi_house.png"
    }


  ];

  Future<void> loadJsonData(BuildContext context) async {
    // Replace this with your actual JSON data
    items =
      [
        {
          "title": "Salad & Co.",
          "category": "Health Foods",
          "offers": "3 offers available",
          "rating": 4,
          "image": "assets/restrorent_img.png"
        },
        {
          "title": "Smoothie Bar",
          "category": "Beverages",
          "offers": "2 offers available",
          "rating": 5,
          "image": "assets/smoothie_bar.png"
        },
        {
          "title": "Pizza Paradise",
          "category": "Italian",
          "offers": "5 offers available",
          "rating": 3.5,
          "image": "assets/pizza_paradise.png"
        },
        {
          "title": "Sushi House",
          "category": "Japanese",
          "offers": "4 offers available",
          "rating": 4.8,
          "image": "assets/sushi_house.png"
        }


    ];

    notifyListeners(); // Notify listeners that the data has changed
  }
}