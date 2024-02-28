import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:take_a_plate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:take_a_plate/SCREENS/home_screens/profile_screen/profile_screen.dart';
import 'package:take_a_plate/SCREENS/home_screens/restrurent.dart';
import 'package:take_a_plate/SCREENS/home_screens/search_screen.dart';
import 'package:take_a_plate/SCREENS/home_screens/your_cart/yourcart_screen.dart';
import 'package:take_a_plate/UTILS/app_color.dart';
import 'package:take_a_plate/UTILS/app_images.dart';
import 'package:take_a_plate/UTILS/dialog_helper.dart';
import 'package:take_a_plate/UTILS/fontfamily_string.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../MULTI-PROVIDER/common_counter.dart';
import '../../main.dart';
import '../contact_us/contact_us.dart';
import '../notification/your_notifcation.dart';
import '../setting_screen/settings_screen.dart';
import 'home_screen.dart';




class BaseHome extends StatefulWidget {

  static bool isSearch = false;


  @override
  _BaseHomeScreen createState() => _BaseHomeScreen();
}

class _BaseHomeScreen extends State<BaseHome> {
   int _selectedIndex = 2;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

@override
  void initState() {
    // TODO: implement initState
    super.initState();





   if(BaseHome.isSearch == true){

    setState(() {
      _selectedIndex = 0;
    });

   }


  }

  static final List<Widget> _widgetOptions = <Widget>[
    const SearchScreen(),
    const YourCardScreen(),
    const HomeScreen(),
    RestaurantsScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if(_selectedIndex==4) {
        _widgetOptions[4] =   const ProfileScreen();
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    var counterProvider=Provider.of<CommonCounter>(navigatorKey.currentContext!, listen: false);
    if(counterProvider.count=="Click"){
      setState(() {
        _selectedIndex=3;
        counterProvider.count="";
      });

    }
    return WillPopScope(
      onWillPop: () async {

        return false; // Let the back button handle navigation normally
      },
      child: Scaffold(
        key: _scaffoldKey,
        extendBody: true,
        resizeToAvoidBottomInset: false,
        endDrawer: Drawer(
          elevation: 3.0,
          width: screenWidth,
          child: RightDrawerMenuWidget(onClick: (index1) {
            setState(() {
              _selectedIndex = index1;

              if (_selectedIndex == 5) {
                _selectedIndex = 4;
                _widgetOptions[4] = YourNotificationScreen();
              } else if (_selectedIndex == 6) {
                _selectedIndex = 4;
                _widgetOptions[4] = const SettingScreen();
              } else if (_selectedIndex == 7) {
                _selectedIndex = 4;
                _widgetOptions[4] = ContactUs();
              }
              else if(_selectedIndex==4){
                _selectedIndex = 4;
                _widgetOptions[4] = const ProfileScreen();
              }
            });
          }),
        ),
        body: WillPopScope(
          onWillPop: () async {

            return false; // Let the back button handle navigation normally
          },
          child: Scaffold(
            backgroundColor: bgColor,
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0, right: 30, top: 6),
                    child: CustomAppBar(
                      index: 2,
                      onTap: () {
                        _scaffoldKey.currentState!.openEndDrawer();
                      },
                      onTap_one: () {
                        if (_selectedIndex == 2) {
                          DialogHelper.showExitDialog(context, "Exit !", "Do You want to Exit ?");
                         // SystemNavigator.pop();
                        }

                        setState(() {
                          _selectedIndex = 2;
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
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Container(

            padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
            decoration: BoxDecoration(
              color: hintColor,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              border: Border.all(width: 0, color: hintColor),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Image.asset(
                    search_icon,
                    height: 25,
                    width: 25,
                    color: _selectedIndex == 0 ? btnbgColor : viewallColor,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    bag_icon,
                    height: 25,
                    width: 25,
                    color: _selectedIndex == 1 ? btnbgColor : viewallColor,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    home_icon,
                    height: 25,
                    width: 25,
                    color: _selectedIndex == 2 ? btnbgColor : viewallColor,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    restrureent_icon,
                    height: 25,
                    width: 25,
                    color: _selectedIndex == 3 ? btnbgColor : viewallColor,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    profile_icon,
                    height: 25,
                    width: 25,
                    color: _selectedIndex == 4 ? btnbgColor : viewallColor,
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
    "NOTIFICATIONS",
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
                  icon:  Image.asset(
                    back_arrow,
                    height: 27,
                    width: 17,
                    color: btnbgColor,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.07,
              ),
              for (int index1 = 0; index1 < listOfItems.length; index1++)
                ListTile(
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
                      onClick(5);
                    } else if (index1 == 5) {
                      onClick(6);
                    } else if (index1 == 6) {
                      onClick(7);
                    }
                  },
                  title: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          index1 == 4 ? Image.asset(eclipse, height: 14, width: 14,) : const Text(""),
                          const SizedBox(width: 5,),
                          CustomText(
                            text: listOfItems[index1],
                            fontfamilly: montHeavy,
                            sizeOfFont: 22,
                            color: hintColor,
                          ),
                        ],
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
