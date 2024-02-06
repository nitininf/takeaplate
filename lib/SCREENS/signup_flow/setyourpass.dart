import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_button.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/confirm_pass_felds.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/app_images.dart';
import 'package:takeaplate/UTILS/app_strings.dart';
import 'package:takeaplate/UTILS/fontfamily_string.dart';
import '../../MULTI-PROVIDER/AuthenticationProvider.dart';
import '../../MULTI-PROVIDER/SignUp_StepTwo.dart';
import '../../Response_Model/RegisterResponse.dart';
import '../../UTILS/request_string.dart';
import '../../UTILS/utils.dart';

TextEditingController passwordController = TextEditingController();
TextEditingController confirmPasswordController = TextEditingController();

class SetYourPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var getUserBasicDetails = Provider.of<SignUp_StepTwo>(context);


    double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        // Clear the text fields when the user presses the back button
        passwordController.text = '';
        confirmPasswordController.text = '';

        Navigator.of(context).pop();

        // Allow the back button action
        return true;
      },
      child: Scaffold(
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
                      ConfirmPasswordField(
                        isPassword: true,
                        controller: passwordController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ConfirmPasswordField(
                        isConfirmPassword: true,
                        isPassword: true,
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

                        String pattern =
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                        RegExp regExp = RegExp(pattern);
                        if (getUserBasicDetails.fullName.isNotEmpty &&
                            getUserBasicDetails.email.isNotEmpty &&
                            getUserBasicDetails.phoneNumber.isNotEmpty &&
                            getUserBasicDetails.dob.isNotEmpty &&
                            getUserBasicDetails.gender.isNotEmpty &&
                            passwordController.text.isNotEmpty &&
                            confirmPasswordController.text.isNotEmpty) {
                          if (regExp.hasMatch(passwordController.text)) {
                            if (passwordController.text ==
                                confirmPasswordController.text) {
                              try {
                                var formData = {
                                  RequestString.NAME:
                                      getUserBasicDetails.fullName,
                                  RequestString.EMAIL:
                                      getUserBasicDetails.email,
                                  RequestString.PHONE_NO:
                                      getUserBasicDetails.phoneNumber,
                                  RequestString.DOB: getUserBasicDetails.dob,
                                  RequestString.GENDER:
                                      getUserBasicDetails.gender,
                                  RequestString.USER_IMAGE:
                                      getUserBasicDetails.user_image,
                                  RequestString.PASSWORD:
                                      passwordController.text,
                                  RequestString.CONFIRM_PASSWORD:
                                      confirmPasswordController.text,
                                };

                                formData.forEach((key, value) {
                                });

                                RegisterResponse data =
                                    await Provider.of<AuthenticationProvider>(
                                            context,
                                            listen: false)
                                        .registerUser(formData);

                                if (data.status == true &&
                                    data.message ==
                                        "User registered successfully") {
                                  // Registration successful

                                  int? id = data.data?.id;
                                  String? userToken = data.token;
                                  String? userName = data.data?.name;
                                  String? email = data.data?.email;
                                  String? phoneNo = data.data?.phoneNo;
                                  String? dataOfBirth = data.data?.dOB;
                                  String? userImage =
                                      data.data?.userImage ?? '';
                                  String? gender = data.data?.gender;

                                  // Save user data to SharedPreferences

                                  await Utility.getSharedPreferences();

                                  await Utility.setIntValue(
                                      RequestString.ID, id!);
                                  await Utility.setStringValue(
                                      RequestString.TOKEN, userToken!);
                                  await Utility.setStringValue(
                                      RequestString.NAME, userName!);
                                  await Utility.setStringValue(
                                      RequestString.EMAIL, email!);
                                  await Utility.setStringValue(
                                      RequestString.PHONE_NO, phoneNo!);
                                  await Utility.setStringValue(
                                      RequestString.DOB, dataOfBirth!);
                                  await Utility.setStringValue(
                                      RequestString.USER_IMAGE, userImage);
                                  await Utility.setStringValue(
                                      RequestString.GENDER, gender!);

                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      '/NotificationTurnOnScreen',
                                      (Route route) => false);
                                } else {
                                  // Registration failed

                                  final snackBar = SnackBar(
                                    content: Text('${data.message}'),
                                  );

                                  // Show the SnackBar
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);

                                  // Automatically hide the SnackBar after 1 second
                                  Future.delayed(Duration(milliseconds: 1000),
                                      () {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                  });
                                }
                              } catch (e) {
                                // Display error message
                              }
                            } else {
                              // Password and confirm password do not match
                              final snackBar = SnackBar(
                                content: const Text(
                                    'Password and confirm password do not match.'),
                                action: SnackBarAction(
                                  label: 'Ok',
                                  onPressed: () {
                                    // Some code to undo the change.
                                  },
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          } else {
                            final snackBar = SnackBar(
                              content: const Text(
                                  '\nPassword must be at least 8 characters. \nShould contain at least one character. \nShould contain at least one number. \nShould contain at least one special character.'),
                              action: SnackBarAction(
                                label: 'Ok',
                                onPressed: () {},
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        } else {
                          // Show an error message or handle empty fields
                          final snackBar = SnackBar(
                            content:
                                const Text('Please fill in all the fields.'),
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
      ),
    );
  }
}
