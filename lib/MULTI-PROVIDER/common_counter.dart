import 'dart:ui';

import 'package:flutter/foundation.dart';
import '../UTILS/request_string.dart';
import '../UTILS/utils.dart';

class CommonCounter extends ChangeNotifier {
  int count = 1;
  DateTime dateTtime=DateTime.now();
   String btnName="SAVE";
  bool isSaved=true;
  String textName="VIEW MORE";
  bool isViewMore=true;
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

  void updateView(String btName) {
     btnName=btName;
     if(btnName=="SAVE"){
       isSaved=false;
     }else{
       isSaved=true;
     }
    notifyListeners();
  }

  void viewMoreLess(String txtname) {
    textName=txtname;
    if(textName=="VIEW MORE"){
      isViewMore=false;
    }else{
      isViewMore=true;
    }
    notifyListeners();
  }
}
