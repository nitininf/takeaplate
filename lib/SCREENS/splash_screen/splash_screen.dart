import 'package:flutter/material.dart';
import 'package:takeaplate/UTILS/app_images.dart';

class SplashScreen extends StatelessWidget {
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
          ),

          // Centered Widgets
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // First Small Image
                Image.asset(
                  appLogo, // Replace with your first small image path
                  height: 207,
                  width: 219,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 50,),
                Image.asset(
                  textImage, // Replace with your second small image path
                  height: 80,
                  width: 283,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
