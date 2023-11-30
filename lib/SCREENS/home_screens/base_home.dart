import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
     HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
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
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(

          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset(
                search_icon,
                height: 30,
                width: 30,
                color: _selectedIndex == 0 ? btnbgColor : blackColor,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                bag_icon,
                height: 30,
                width: 30,
                color: _selectedIndex == 1 ? btnbgColor : blackColor,
              ),
              label:'',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                home_icon,
                height: 30,
                width: 30,
                color: _selectedIndex == 2 ? btnbgColor : blackColor,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                restrureent_icon,
                height: 30,
                width: 30,
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
          backgroundColor: Colors.white,
          currentIndex: _selectedIndex,
          selectedItemColor: btnbgColor,
          onTap: _onItemTapped,
          iconSize: 28,
          elevation: 5,
          selectedLabelStyle: TextStyle(fontSize: 16.0),
          // Increase the font size
          unselectedLabelStyle: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
