import 'package:flutter/material.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_button.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
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
                appBackground,
                fit: BoxFit.cover,
              ),

              Column(
                children: <Widget>[
                  SizedBox(
                    height: screenHeight * 0.13,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      appLogo,
                      height: 120,
                      width: 120,
                    ),
                  ),
                //  SizedBox(height: screenHeight*0.05,),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      //color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(width: 1, color: Colors.white)),
                    child: Column(children: [
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                  Image.asset(appLogo,
                  height: 100,
                  width: 100,),
             const SizedBox(height: 20,),
                      const CustomText(text: "YOUR PASSWORD HAS BEEN SENT TO YOUR EMAIL",
                        sizeOfFont: 20,
                        color: Colors.white,
                      isAlign: true,),
                      SizedBox(height: 20,),

                      const CustomText(text: "PLEASE CHECK YOUR INBOX",
                        sizeOfFont: 20,
                        color: Colors.white,
                        isAlign: true,),
                      SizedBox(
                        height: screenHeight * 0.05,
                      ),

                        CommonButton(btnBgColor: Colors.white, btnText: done, onClick: (){
                          Navigator.pushNamed(context, '/SignupScreen');
                        }),
                      SizedBox(height: 10,)
                    ]),
                  ),
                  const SizedBox(height: 10,),
                  const CustomText(text: forgotpss,color: Colors.white,),
                  SizedBox(height: screenHeight*0.075,),
                  // Horizontal line using Divider
                  const Divider(
                    color: Colors.white,
                    thickness: 1,
                  ),
                  const SizedBox(height: 20,),
                  const CustomText(text: notMmberyet,color: Colors.white,),
                  const SizedBox(height: 20,),
                  const CustomText(text: createaccount,color: Colors.white,sizeOfFont: 20,fontfamilly: montBold,),

                ],
              ),
            ],

          ),


        );


  }


}

