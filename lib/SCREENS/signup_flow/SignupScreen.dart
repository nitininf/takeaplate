import 'package:flutter/material.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_button.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_edit_text.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_email_field.dart';
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
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: true, // Set this to true
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(appBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView( // Wrap your Column with SingleChildScrollView
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 40),
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight * 0.04),
                      Image.asset(
                        appLogo,
                        height: 80,
                        width: 80,
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: CustomText(
                          text: createyouraccount,
                          color: hintColor,
                          fontfamilly: montHeavy,
                          sizeOfFont: 20,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      CommonEmailField(hintText: fullName),
                      const SizedBox(height: 20),
                      CommonEmailField(hintText: email),
                      const SizedBox(height: 20),
                      CommonEmailField(hintText: phoneNumber,),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(child: CommonEditText(hintText: dob)),
                          SizedBox(width: 10),
                          Expanded(
                            child: CommonEditText(
                              hintText: gender,
                              isPassword: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight*0.170,),
                Padding(
                  padding: EdgeInsets.only(left: 40, right: 40, bottom: 20),
                  child: CommonButton(
                    btnBgColor: btnbgColor,
                    btnText: next,
                    onClick: () {
                      Navigator.pushNamed(context, '/UploadPhoto');
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),


    /*   bottomNavigationBar:  Padding(
      padding:EdgeInsets.only(left: 40,right: 40,bottom: 20) ,
      child: CommonButton(
        btnBgColor: btnbgColor,
        btnText: next,
        onClick: () {
          Navigator.pushNamed(context, '/UploadPhoto');
        },
      ),
    ),*/

    );
  }
}
