import 'package:flutter/foundation.dart';

class CommonCounter extends ChangeNotifier {
  String count = "";
  DateTime dateTtime=DateTime.now();
   String btnName="SAVE";
  bool isSaved=true;
  String textName="VIEW MORE";
  bool isViewMore=false;
  bool isNotification=true;
  bool isNotification_one=true;
  bool isNotification_two=true;
    List<bool> isNoti=[true,true,true,true,true];
  //List<int> myIntList = [];
  bool isDeal=true;
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

  void getscreen(){
    count="Click";
    notifyListeners();
  }
  void gettodayDeal(bool _isDeal){
    isDeal=_isDeal;
    notifyListeners();
  }
  getUserId() async {
    String? userId = "";//await Utility.getStringValue(RequestString.USER_ID);
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
  void notificationShowOn(bool isNotify) {
    isNotification=isNotify;
    notifyListeners();
  }
  void notificationShowOn_one(bool isNotify) {
    isNotification_one=isNotify;
    notifyListeners();
  }
  void notificationShowOn_two(bool isNotify) {
    isNotification_two=isNotify;
    notifyListeners();
  }
  void notificationCenter(bool isNotify,{int pos=0}) {
      isNoti[pos]=isNotify;
      print("nbbb${pos}");
    // myIntList.add(count!);
    notifyListeners();
  }
}
