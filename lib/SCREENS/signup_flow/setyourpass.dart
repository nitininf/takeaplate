import 'package:flutter/material.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_button.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_edit_text.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/app_images.dart';
import 'package:takeaplate/UTILS/app_strings.dart';
import 'package:takeaplate/UTILS/fontfaimlly_string.dart';

import '../../CUSTOM_WIDGETS/common_email_field.dart';

class SetYourPasswordScreen extends StatelessWidget {

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String? _validatePassword(String value) {
    // Password validation logic goes here
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    // Add more validation rules as needed
    return null;
  }

  String? _validateConfirmPassword(String value) {
    // Confirm password validation logic goes here
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                padding: const EdgeInsets.only(left: 40.0, right: 40),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    Image.asset(
                      appLogo, // Replace with your first small image path
                      height: 80,
                      width: 80,
                    ),
                    SizedBox(
                      height: screenHeight * 0.04,
                    ),
                    const Align(
                        alignment: Alignment.topLeft,
                        child: CustomText(
                          text: setyourpassword,
                          color: readybgColor,
                          fontfamilly: montHeavy,
                          sizeOfFont: 20,
                        )),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    CommonEmailField(
                      hintText: password,
                      controller: passwordController,


                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CommonEmailField(
                      hintText: conpassword,
                      controller: confirmPasswordController,

                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: CommonButton(
                    btnBgColor: btnbgColor,
                    btnText: next,
                    onClick: () {

                      print("password:${passwordController.text} \n Confirm Password:${confirmPasswordController.text}");

                      Navigator.pushNamed(context, '/NotificationTurnOnScreen');
                    }),
              )
            ],
          ),
        ],
      ),
    );
  }
}
