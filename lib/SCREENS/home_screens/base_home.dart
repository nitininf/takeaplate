import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:takeaplate/SCREENS/home_screens/profile_screen/profile_screen.dart';
import 'package:takeaplate/SCREENS/home_screens/restrurent.dart';
import 'package:takeaplate/SCREENS/home_screens/search_screen.dart';
import 'package:takeaplate/SCREENS/home_screens/your_cart/yourcart_screen.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/app_images.dart';

import 'home_screen.dart';

class BaseHome extends StatefulWidget {
  @override
  _BaseHomeScreen createState() => _BaseHomeScreen();
}

class _BaseHomeScreen extends State<BaseHome> {
  int _selectedIndex = 0;
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
    return WillPopScope(
      onWillPop: () async {
        //SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar:
        SafeArea(
          child: Container(padding: const EdgeInsets.only(left: 8,right: 8, top: 10),
            decoration: BoxDecoration(

              borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
              border: Border.all(width: 0, color:grayColor),
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
