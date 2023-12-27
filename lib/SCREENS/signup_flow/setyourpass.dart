import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_button.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_edit_text.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/app_images.dart';
import 'package:takeaplate/UTILS/app_strings.dart';
import 'package:takeaplate/UTILS/fontfaimlly_string.dart';

import '../../CUSTOM_WIDGETS/common_email_field.dart';
import '../../MULTI-PROVIDER/AuthenticationProvider.dart';
import '../../MULTI-PROVIDER/SignUp_StepTwo.dart';
import '../../Response_Model/RegisterResponse.dart';
import '../../UTILS/request_string.dart';
import '../../UTILS/utils.dart';

class SetYourPasswordScreen extends StatelessWidget {

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    var getUserBasicDetails = Provider.of<SignUp_StepTwo>(context);

    // // Access the user's information
    // var userInformation = SignUp_StepOne();
    print("\nFull Name: ${getUserBasicDetails.fullName}, \nEmail: ${getUserBasicDetails.email}, \nPhone Number: ${getUserBasicDetails.phoneNumber}, \nDOB: ${getUserBasicDetails.dob}, \nGender: ${getUserBasicDetails.gender}, \nimage: ${getUserBasicDetails.user_image}");



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
                    onClick: () async {

                      print("\nFull Name: ${getUserBasicDetails.fullName}, \nEmail: ${getUserBasicDetails.email}, \nPhone Number: ${getUserBasicDetails.phoneNumber}, \nDOB: ${getUserBasicDetails.dob}, \nGender: ${getUserBasicDetails.gender}, \nimage: ${getUserBasicDetails.user_image}");


                      if (getUserBasicDetails.fullName.isNotEmpty &&
                          getUserBasicDetails.email.isNotEmpty &&
                          getUserBasicDetails.phoneNumber.isNotEmpty &&
                          getUserBasicDetails.dob.isNotEmpty &&
                          getUserBasicDetails.gender.isNotEmpty &&
                          getUserBasicDetails.user_image.isNotEmpty &&
                          passwordController.text.isNotEmpty &&
                          confirmPasswordController.text.isNotEmpty) {

                        // Check password length
                        if (passwordController.text.length >= 8) {
                          if (passwordController.text == confirmPasswordController.text) {
                            try {
                              var formData = {
                                RequestString.NAME: getUserBasicDetails.fullName,
                                RequestString.EMAIL: getUserBasicDetails.email,
                                RequestString.PHONE_NO: getUserBasicDetails.phoneNumber,
                                RequestString.DOB: getUserBasicDetails.dob,
                                RequestString.GENDER: getUserBasicDetails.gender,
                                RequestString.USER_IMAGE: getUserBasicDetails.user_image ?? '',
                                RequestString.PASSWORD: passwordController.text,
                                RequestString.CONFIRM_PASSWORD: confirmPasswordController.text,
                              };

                              formData.forEach((key, value) {
                                print('Request: $key: $value');
                              });

                              RegisterResponse data = await Provider.of<AuthenticationProvider>(context, listen: false)
                                  .registerUser(formData);

                              if (data.status == true && data.message == "User registered successfully") {
                                // Registration successful

                                int? id = data.data?.id;
                                String? userToken = data.token;
                                String? userName = data.data?.name;
                                String? email = data.data?.email;
                                String? phoneNo = data.data?.phoneNo;
                                String? dataOfBirth = data.data?.dOB;
                                String? userImage = data.data?.userImage;
                                String? gender = data.data?.gender;

                                // Save user data to SharedPreferences


                                await Utility.getSharedPreferences();

                                await Utility.setIntValue(RequestString.ID, id!);
                                await Utility.setStringValue(RequestString.TOKEN, userToken!);
                                await Utility.setStringValue(RequestString.NAME, userName!);
                                await Utility.setStringValue(RequestString.EMAIL, email!);
                                await Utility.setStringValue(RequestString.PHONE_NO, phoneNo!);
                                await Utility.setStringValue(RequestString.DOB, dataOfBirth!);
                                await Utility.setStringValue(RequestString.USER_IMAGE, userImage!);
                                await Utility.setStringValue(RequestString.GENDER, gender!);




                                print(data);
                                Navigator.pushNamed(context, '/NotificationTurnOnScreen');
                              } else {
                                // Registration failed
                                print("Registration failed: ${data.message}");

                                final snackBar = SnackBar(
                                  content:  Text('${data.message}'),

                                );

// Show the SnackBar
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);

// Automatically hide the SnackBar after 1 second
                                Future.delayed(Duration(milliseconds: 1000), () {
                                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                });
                              }
                            } catch (e) {
                              // Display error message
                              print("Error: $e");
                            }
                          } else {
                            // Password and confirm password do not match
                            final snackBar = SnackBar(
                              content: const Text('Password and confirm password do not match.'),
                              action: SnackBarAction(
                                label: 'Ok',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        } else {
                          // Password is too short
                          final snackBar = SnackBar(
                            content: const Text('Password should be at least 8 characters.'),
                            action: SnackBarAction(
                              label: 'Ok',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }

                      else {
                        // Show an error message or handle empty fields
                        final snackBar = SnackBar(
                          content: const Text('Please fill in all the fields.'),
                          action: SnackBarAction(
                            label: 'Ok',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }

                    }),
              )
            ],
          ),
        ],
      ),
    );
  }
}
