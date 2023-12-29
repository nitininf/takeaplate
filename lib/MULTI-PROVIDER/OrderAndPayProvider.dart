import 'package:flutter/material.dart';

class OrderAndPayProvider extends ChangeNotifier {
  List<Map<String, dynamic>> foodData = [
    {
      "image": "assets/images/food_image.jpg",
      "name": "Surprise Pack",
      "category": "Health Foods",
      "pickUpTime": "Pick up Time: 11:00 am",
      "rating": 4.0,
      "distance": "84 Km",
      "address": "23 Dreamland Av.., Australia",
      "description": "Ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation",
      "features": [ "Soy-Free", "Location-Free"],
      "price": "\$9.99",
    },
    // Add more food items as needed
  ];

  bool isViewMore = false;
  String textName = "VIEW MORE";

  void viewMoreLess(String text) {
    isViewMore = !isViewMore;
    textName = text;
    notifyListeners();
  }
}
