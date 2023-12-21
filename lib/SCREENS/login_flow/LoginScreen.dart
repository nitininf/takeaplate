import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_button.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_pass_felds.dart';
import 'package:takeaplate/MULTI-PROVIDER/LoginProvider.dart';
import 'package:takeaplate/Response_Model/LogInResponse.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/app_images.dart';
import 'package:takeaplate/UTILS/app_strings.dart';
import 'package:takeaplate/UTILS/dialog_helper.dart';
import 'package:takeaplate/UTILS/fontfaimlly_string.dart';

import '../../CUSTOM_WIDGETS/common_email_field.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../UTILS/request_string.dart';
import '../../UTILS/utils.dart';
import '../../UTILS/validation.dart';

class LogInScreen extends StatelessWidget {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

   LogInScreen({super.key});

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
                      const SizedBox(height: 20,),
                      CommonPasswordField(isPassword: true,controller: passwordController,),
                      const SizedBox(height: 30,),
                      CommonButton(btnBgColor: btnbgColor, btnText: login, onClick: () async {




                        if (email.isNotEmpty && password.isNotEmpty) {


                            try
                            {

                              var  formData = {
                                RequestString.EMAIL: emailController.text,
                                RequestString.PASSWORD: passwordController.text,
                              };
                              LoginResponse data= await Provider.of<LoginProvider>(context, listen: false)
                                  .loginUser(formData);

                              String? userToken = data.token;
                              String? userName = data.data?.name;
                              String? email = data.data?.email;
                              String? phoneNo = data.data?.phoneNo as String;
                              String? dataOfBirth = data.data?.dOB;
                              String? userImage = data.data?.userImage;
                              String? gender = data.data?.gender;


                              // Save the username to SharedPreferences
                              await Utility.setStringValue(RequestString.TOKEN, userToken!);
                              await Utility.setStringValue(RequestString.NAME, userName!);
                              await Utility.setStringValue(RequestString.EMAIL, email!);
                              await Utility.setStringValue(RequestString.PHONE_NO, phoneNo);
                              await Utility.setStringValue(RequestString.DOB, dataOfBirth!);
                              await Utility.setStringValue(RequestString.USER_IMAGE, userImage!);
                              await Utility.setStringValue(RequestString.GENDER, gender!);


                              print(data);

                              // Navigator.pushNamed(currentContext, '/BaseHome');

                              // Navigate to the next screen or perform other actions after login
                            } catch (e) {
                              // Display error message
                              // ScaffoldMessenger.of(currentContext).showSnackBar(
                              //   SnackBar(
                              //     content: Text('$e'),
                              //     backgroundColor: Colors.red,
                              //   ),
                              // );
                            }

                        } else {
                          // Show an error message or handle empty fields
                          // ScaffoldMessenger.of(currentContext).showSnackBar(
                          //   SnackBar(
                          //     content: Text('Please enter both email and password.'),
                          //     backgroundColor: Colors.red,
                          //   ),
                          // );

                          print("Please enter both email and password.");
                        }



                      }),
                      const SizedBox(height: 20,),
                      GestureDetector(child: const CustomText(text: forgotpss,color: hintColor,fontfamilly: montBold,),

                      onTap: (){




                      //  Navigator.pushNamed(context, '/PassWordSentScreen');
                        DialogHelper.showCommonPopup(context,title: sentPss,subtitle: checkInbox);
                      },),
                       SizedBox(height: screenHeight*0.100,),
                      // Horizontal line using Divider
                      const Divider(
                        color: hintColor,
                        thickness: 1,
                      ),
                      const SizedBox(height: 20,),
                      const CustomText(text: notMmberyet,color: hintColor,fontfamilly: montBold,),
                      const SizedBox(height: 10,),
                      GestureDetector(child: const CustomText(text: createyouraccount,color: btnbgColor,sizeOfFont: 18,fontfamilly: montBold,)
                      ,
                        onTap: (){
                        Navigator.pushNamed(context, '/SignupScreen');
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
    );
  }
}
