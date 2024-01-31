import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_button.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_pass_felds.dart';
import 'package:takeaplate/MULTI-PROVIDER/AuthenticationProvider.dart';
import 'package:takeaplate/Response_Model/ForgotPasswordResponse.dart';
import 'package:takeaplate/Response_Model/LogInResponse.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/app_images.dart';
import 'package:takeaplate/UTILS/app_strings.dart';
import 'package:takeaplate/UTILS/dialog_helper.dart';
import 'package:takeaplate/UTILS/fontfamily_string.dart';

import '../../CUSTOM_WIDGETS/common_email_field.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../UTILS/request_string.dart';
import '../../UTILS/utils.dart';
import '../../UTILS/validation.dart';


TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class ForgotPasswordScreen extends StatelessWidget {



  ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;



    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            appBackground, // Replace with your background image path
            fit: BoxFit.cover,
          ),

          // Centered Widgets
          SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(height: screenHeight*0.100,),
                    Image.asset(
                      appLogo, // Replace with your first small image path
                      height: 100,
                      width: 100,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 40,),
                    Image.asset(
                      textImage, // Replace with your second small image path,
                      width: screenWidth*0.5,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40,right: 40,top: 20,bottom: 20),
                  child: Column(
                    children: [
                      CommonEmailField(hintText: email,controller: emailController,),
                      const SizedBox(height: 30,),

                      CommonButton(btnBgColor: btnbgColor, btnText: reset, onClick: () async {




                        if (emailController.text.isNotEmpty) {
                          try {
                            var formData = {
                              RequestString.EMAIL: emailController.text,


                            };

                            ForgotPasswordResponse data = await Provider.of<
                                AuthenticationProvider>(context, listen: false)
                                .forgotPassword(formData);

                            if (data.status == true &&
                                data.message == "Reset link sent to your email.") {
                              // Login successful
                              DialogHelper.showCommonPopup(context,title: sentPss,subtitle: checkInbox);


                              // Print data to console
                              print(data);

                              // Navigate to the next screen or perform other actions after login
                            } else {
                              // Login failed
                              print("Something went wrong: ${data.message}");
                            }
                          } catch (e) {
                            // Display error message
                            print("Error: $e");
                          }
                        }

                        else {
                          // Show an error message or handle empty fields
                          final snackBar = SnackBar(
                            content: const Text('Please email id to reset your password.'),
                            action: SnackBarAction(
                              label: 'Ok',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );

                          // Find the ScaffoldMessenger in the widget tree
                          // and use it to show a SnackBar.
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }




                      }),


                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
