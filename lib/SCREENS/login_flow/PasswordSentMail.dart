import 'package:flutter/material.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_button.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/app_images.dart';
import 'package:takeaplate/UTILS/app_strings.dart';
import 'package:takeaplate/UTILS/fontfaimlly_string.dart';

class PassWordSentScreen extends StatelessWidget {
  const PassWordSentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body:Stack(
            children: [
              Image.asset(
                passwordsent_bg,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),

              Column(
                children: <Widget>[
                  SizedBox(
                    height: screenHeight * 0.16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0,right: 30.0,top: 30.0,bottom: 10),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: onboardingbgColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(width: 1, color: hintColor)),
                      child: Column(children: [
                        SizedBox(
                          height: screenHeight * 0.03,
                        ),
                    Image.asset(appLogo,
                    height: 100,
                    width: 100,),
                                 const SizedBox(height: 20,),
                        const Align(
                          alignment: Alignment.center,
                          child: CustomText(text:sentPss ,
                            sizeOfFont: 20,
                            color: hintColor,
                          fontfamilly: montHeavy,
                          isAlign: true,),
                        ),
                        const SizedBox(height: 20,),

                        const CustomText(text: checkInbox,
                          sizeOfFont: 20,
                          color: btnbgColor,
                          fontfamilly: montRegular,
                          isAlign: true,),
                        SizedBox(
                          height: screenHeight * 0.05,
                        ),

                          Padding(
                            padding: const EdgeInsets.only(left: 15.0,right: 15,top: 6,bottom: 20),
                            child: CommonButton(btnBgColor:hintColor, btnText: done, onClick: (){
                              Navigator.pop(context);
                            }),
                          ),
                        SizedBox(height: 10,)
                      ]),
                    ),
                  ),
                  const CustomText(text: forgotpss,color: hintColor,fontfamilly: montBook,),
                  SizedBox(height: screenHeight*0.07,),
                  // Horizontal line using Divider
                  const Padding(
                    padding:  EdgeInsets.only(left: 50.0,right: 50),
                    child:  Divider(
                      color: Colors.white,
                      thickness: 0,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const CustomText(text: notMmberyet,color: hintColor,fontfamilly: montBook,),
                  const SizedBox(height: 10,),
                  const CustomText(text: createyouraccount,color: btnbgColor,sizeOfFont: 20,fontfamilly: montBold,),

                ],
              ),
            ],

          ),


        );


  }


}

