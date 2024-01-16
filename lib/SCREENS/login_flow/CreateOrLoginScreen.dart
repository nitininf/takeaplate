import 'package:flutter/material.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_button.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/app_images.dart';
import 'package:takeaplate/UTILS/app_strings.dart';

class CreateOrLogInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

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
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
             Column(
               children: [
                 Image.asset(
                   appLogo, // Replace with your first small image path
                   height: 138,
                   width: 130,
                   fit: BoxFit.contain,
                 ),
                 SizedBox(height: 40,),
                 Image.asset(
                   textImage, // Replace with your second small image path,
                   width: 270,
                   height: 80,
                   fit: BoxFit.contain,
                 ),
               ],
             ),
             Padding(
               padding: const EdgeInsets.all(40),
               child: Column(
                 children: [
                   CommonButton(btnBgColor: btnbgColor, btnText: login,sizeOfFont: 18, onClick: (){
                     Navigator.of(context).pushNamedAndRemoveUntil('/Login', (Route route) => false);
                   }),
                   SizedBox(height: 20,),
                   CommonButton(btnBgColor: btnbgColor, sizeOfFont:17,btnText: createAnaccount, onClick: (){
                     Navigator.of(context).pushNamedAndRemoveUntil('/SignupScreen', (Route route) => false);

                   }),
                 ],
               ),
             )
            ],
          ),
        ],
      ),
    );
  }
}
