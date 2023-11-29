import 'package:flutter/material.dart';
import 'package:takeaplate/UTILS/app_images.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
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
                    height: 200,
                    width: screenWidth*0.5,
                  ),
                  Image.asset(
                    textImage, // Replace with your second small image path
                    height: 140,
                    width: screenWidth*0.5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
