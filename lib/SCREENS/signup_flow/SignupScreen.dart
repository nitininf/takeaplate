import 'package:flutter/material.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_button.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_edit_text.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/app_images.dart';
import 'package:takeaplate/UTILS/app_strings.dart';
import 'package:takeaplate/UTILS/fontfaimlly_string.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(

        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              appBackground,
              fit: BoxFit.cover,
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40.0,right: 40),
                  child: Column(
                    children: [
                       SizedBox(height: screenHeight*0.04,),
                      Image.asset(
                        appLogo, // Replace with your first small image path
                        height: 80,
                        width: 80,
                      ),
                      SizedBox(height: screenHeight*0.01,),
                      const Align(
                        alignment: Alignment.topLeft,
                          child: CustomText(text: createaccount,color: Colors.white,fontfamilly: montBold,sizeOfFont: 14,)),
                      SizedBox(height: screenHeight*0.04,),
                      CommonEditText(hintText: fullName,),
                      const SizedBox(height: 20,),
                      CommonEditText(hintText: email,),
                      const SizedBox(height: 20,),
                      CommonEditText(hintText: phoneNumber,),
                      const SizedBox(height: 30,),
                      Row(
                        children: [
                          Expanded(child: CommonEditText(hintText: dob,)),
                          SizedBox(width: 10,),
                          Expanded(child: CommonEditText(hintText: gender,isPassword: true,)),
                        ],
                      ),
                    ],
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: CommonButton(btnBgColor: btnbgColor, btnText: next, onClick: (){
                    Navigator.pushNamed(context, '/UploadPhoto');
                  }),
                )

              ],
            ),
                  ],
                ),

      ),
    );
  }
}
