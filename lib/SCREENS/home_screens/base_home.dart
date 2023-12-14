import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:takeaplate/SCREENS/home_screens/profile_screen/profile_screen.dart';
import 'package:takeaplate/SCREENS/home_screens/restrurent.dart';
import 'package:takeaplate/SCREENS/home_screens/search_screen.dart';
import 'package:takeaplate/SCREENS/home_screens/your_cart/yourcart_screen.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/app_images.dart';
import 'package:takeaplate/UTILS/fontfaimlly_string.dart';

import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import 'home_screen.dart';

class BaseHome extends StatefulWidget {
  @override
  _BaseHomeScreen createState() => _BaseHomeScreen();
}

class _BaseHomeScreen extends State<BaseHome> {
  int _selectedIndex = 2;
  static final List<Widget> _widgetOptions = <Widget>[
    SearchScreen(),
    YourCardScreen(),
    HomeScreen(),
    RestrurentScreen(),
    ProfileScreen(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        if(_selectedIndex==2)
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        key: _scaffoldKey,
        extendBody: true,
        resizeToAvoidBottomInset: false,
        endDrawer: Drawer(
          elevation: 3.0,
          width: screenWidth,
          child: RightDrawerMenuWidget(onClick: (index1) {
            print("========$index1");
            setState(() {
              _selectedIndex = index1;
              print("selectedincdex========$_selectedIndex");

              if(_selectedIndex==5){
                _selectedIndex=4;
                //_widgetOptions[4]= YourNotificationScreen();
              }else if(_selectedIndex==6){
                _selectedIndex=4;
                //_widgetOptions[4]= SettingScreen();
              }
              else if(_selectedIndex==7){
                _selectedIndex=4;
               // _widgetOptions[4]=ContactUs();
              }

            });
          }),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 28.0, right: 30,top: 10),
                child: CustomAppBar(
                  onTap: () {
                    _scaffoldKey.currentState!.openEndDrawer();
                  },
                  onTap_one: (){
                 if(_selectedIndex==2) {
                   SystemNavigator.pop();
                 }
                    setState(() {
                      _selectedIndex=2;


                    });
                  },
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: _widgetOptions.elementAt(_selectedIndex),
                ),
              ),
            ],
          ),
        ),

        bottomNavigationBar: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              border: Border.all(width: 0, color: grayColor),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Image.asset(
                    search_icon,
                    height: 25,
                    width: 25,
                    color: _selectedIndex == 0 ? btnbgColor : blackColor,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    bag_icon,
                    height: 25,
                    width: 25,
                    color: _selectedIndex == 1 ? btnbgColor : blackColor,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    home_icon,
                    height: 25,
                    width: 25,
                    color: _selectedIndex == 2 ? btnbgColor : blackColor,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    restrureent_icon,
                    height: 25,
                    width: 25,
                    color: _selectedIndex == 3 ? btnbgColor : blackColor,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    profile_icon,
                    height: 30,
                    width: 30,
                    color: _selectedIndex == 4 ? btnbgColor : blackColor,
                  ),
                  label: '',
                ),
              ],

              currentIndex: _selectedIndex,
              // selectedItemColor: btnbgColor,
              backgroundColor: Colors.transparent,
              onTap: _onItemTapped,
              elevation: 0,
            ),
          ),
        ),
      ),
    );
  }
}

class RightDrawerMenuWidget extends StatelessWidget {
  RightDrawerMenuWidget({super.key, required this.onClick});

  final Function(int index1) onClick;

  final listOfItems = [
    "HOME",
    "PROFILE",
    "RESTAURANTS",
    "MY CART",
    "NOTIFICATONS",
    "SETTINGS",
    "HELP"
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            appBackground, // Replace with your background image path
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.07,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: btnbgColor,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.07,
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: listOfItems.length,
                  itemBuilder: (context, index1) => ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      if (index1 == 2) {
                        onClick(3);
                      } else if (index1 == 0) {
                        onClick(2);
                      } else if (index1 == 1) {
                        onClick(4);
                      } else if (index1 == 3) {
                        onClick(1);
                      } else if (index1 == 4) {
                        //onClick(5);
                        Navigator.pushNamed(context, '/YourNotificationScreen');
                      } else if (index1 == 5) {
                       // onClick(6);
                        Navigator.pushNamed(context, '/SettingScreen');
                      } else if (index1 == 6) {
                        //onClick(7);
                        Navigator.pushNamed(context, '/ContactUs');
                      }
                    },
                    dense: true,
                    title: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: CustomText(
                          text: listOfItems[index1],
                         fontfamilly: montHeavy,
                          sizeOfFont: 22,
                          color: hintColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
          Positioned(
            bottom: screenHeight * 0.050,
            left: screenHeight * 0.050,
            child: Image.asset(
              appLogo,
              height: screenWidth * 0.30,
              width: screenWidth * 0.30,
              color: btnbgColor,
            ),
          ),
        ],
      ),
    );
  }
}
