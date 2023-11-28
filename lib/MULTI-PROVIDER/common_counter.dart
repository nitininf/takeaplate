import 'dart:ui';

import 'package:flutter/foundation.dart';
import '../UTILS/app_images.dart';
import '../UTILS/app_strings.dart';
import '../UTILS/request_string.dart';
import '../UTILS/utils.dart';

class CommonCounter extends ChangeNotifier {
  int count = 1;
  DateTime dateTtime=DateTime.now();
  // Private constructor to prevent external instantiation
  CommonCounter._();

  // Static instance variable to hold the single instance of CommonCounter
  static CommonCounter? _instance;

  // Factory constructor to return the single instance
  factory CommonCounter() {
    if (_instance == null) {
      _instance = CommonCounter._();
    }
    return _instance!;
  }

  getUserId() async {
    String? userId = await Utility.getStringValue(RequestString.USER_ID);
    print("UserId: $userId");
    return userId;
  }

  void updateCount() {
    count++;
    notifyListeners();
  }

}
