import 'package:flutter/material.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_button.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/app_images.dart';
import 'package:takeaplate/UTILS/app_strings.dart';

class CreateOrLogInScreen extends StatelessWidget {
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
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
               Column(
                 children: [
                   Image.asset(
                     appLogo, // Replace with your first small image path
                     height: 100,
                     width: 100,
                   ),
                   SizedBox(height: 40,),
                   Image.asset(
                     textImage, // Replace with your second small image path,
                     width: screenWidth*0.5,
                   ),
                 ],
               ),
               Padding(
                 padding: const EdgeInsets.all(50),
                 child: Column(
                   children: [
                     CommonButton(btnBgColor: btnbgColor, btnText: login, onClick: (){
                       Navigator.pushNamed(context, '/Login');
                     }),

                     SizedBox(height: 20,),
                     CommonButton(btnBgColor: btnbgColor, btnText: createaccount, onClick: (){}),
                   ],
                 ),
               )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
