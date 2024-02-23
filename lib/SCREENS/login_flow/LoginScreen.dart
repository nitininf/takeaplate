import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:take_a_plate/CUSTOM_WIDGETS/common_button.dart';
import 'package:take_a_plate/CUSTOM_WIDGETS/common_pass_felds.dart';
import 'package:take_a_plate/MULTI-PROVIDER/AuthenticationProvider.dart';
import 'package:take_a_plate/Response_Model/LogInResponse.dart';
import 'package:take_a_plate/UTILS/app_color.dart';
import 'package:take_a_plate/UTILS/app_images.dart';
import 'package:take_a_plate/UTILS/app_strings.dart';
import 'package:take_a_plate/UTILS/fontfamily_string.dart';
import '../../CUSTOM_WIDGETS/common_email_field.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../UTILS/PushNotificationService.dart';
import '../../UTILS/request_string.dart';
import '../../UTILS/utils.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();



class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        // Clear the text fields when the user presses the back button
        emailController.clear();
        passwordController.clear();

        Navigator.of(context)
            .pushNamedAndRemoveUntil('/Create_Login', (Route route) => false);

        // Allow the back button action
        return true;
      },
      child: Scaffold(
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
                      SizedBox(
                        height: screenHeight * 0.100,
                      ),
                      Image.asset(
                        appLogo, // Replace with your first small image path
                        height: 100,
                        width: 100,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Image.asset(
                        textImage, // Replace with your second small image path,
                        width: 270,
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 40, right: 40, top: 20, bottom: 20),
                    child: Column(
                      children: [
                        CommonEmailField(
                          hintText: email,
                          controller: emailController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CommonPasswordField(
                          isPassword: true,
                          controller: passwordController,
                          isConfirmPassword: false,
                        ),
                        const SizedBox(
                          height: 30,
                        ),



                        CommonButton(
                            btnBgColor: btnbgColor,
                            btnText: login,
                            onClick: () async {


                            var fcmToken =  await Utility.getStringValue(RequestString.FCM_TOKEN);

                             FocusScope.of(context).unfocus();


                              if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
                                try {

                                  var formData = {
                                    RequestString.EMAIL: emailController.text,
                                    RequestString.PASSWORD: passwordController.text,
                                    RequestString.FCM_TOKEN: fcmToken,

                                  };


                                  LoginResponse data =
                                      await Provider.of<AuthenticationProvider>(
                                      context,
                                      listen: false)
                                      .loginUser(formData);

                                  if (data.status == true && data.message == "User login successfully") {
                                    // Login successful
                                    int? id = data.data?.id;
                                    String? userToken = data.token;
                                    String? userName = data.data?.name;
                                    String? email = data.data?.email;
                                    String? phoneNo =
                                    data.data?.phoneNo.toString();
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

                                    emailController.text = '';
                                    passwordController.text = '';

                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil('/BaseHome',
                                            (Route route) => false);

                                    // Print data to console

                                    // Navigate to the next screen or perform other actions after login
                                  }

                                  else {
                                    // Login failed

                                    final snackBar = SnackBar(
                                      content: Text('${data.message}'),
                                    );

                                    // Show the SnackBar
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);

                                    // Automatically hide the SnackBar after 1 second
                                    Future.delayed(const Duration(milliseconds: 1000),
                                            () {
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();
                                        });
                                  }


                                } catch (e) {
                                  // Display error message
                                }
                              }
                              else {
                                // Show an error message or handle empty fields
                                final snackBar = SnackBar(
                                  content: const Text('Please enter both email and password.'),
                                  action: SnackBarAction(
                                    label: 'Ok',
                                    onPressed: () {
                                      // Some code to undo the change.
                                    },
                                  ),
                                );

                                // Find the ScaffoldMessenger in the widget tree
                                // and use it to show a SnackBar.
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            }

                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          child: const CustomText(
                            text: forgotpss,
                            color: hintColor,
                            fontfamilly: montBold,
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                                context, '/ForgotPasswordScreen');

                            //  Navigator.pushNamed(context, '/PassWordSentScreen');
                          },
                        ),
                        SizedBox(
                          height: screenHeight * 0.100,
                        ),
                        // Horizontal line using Divider
                        const Divider(
                          color: hintColor,
                          thickness: 1,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const CustomText(
                          text: notMmberyet,
                          color: hintColor,
                          fontfamilly: montBold,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          child: const CustomText(
                            text: createyouraccount,
                            color: btnbgColor,
                            sizeOfFont: 18,
                            fontfamilly: montBold,
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/SignupScreen', (Route route) => false);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}