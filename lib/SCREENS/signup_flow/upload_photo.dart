import 'package:flutter/material.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_button.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_edit_text.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/app_images.dart';
import 'package:takeaplate/UTILS/app_strings.dart';
import 'package:takeaplate/UTILS/fontfaimlly_string.dart';

class UploadPhoto extends StatelessWidget {
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
                      SizedBox(height: screenHeight*0.03,),
                      const Padding(
                        padding: EdgeInsets.only(left: 18,top: 25),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: CustomText(text: profilePicture,color: Colors.white,fontfamilly: montHeavy,sizeOfFont: 20,)),
                      ),
                      SizedBox(height: screenHeight*0.04,),

                      Container(
                        height: screenHeight*0.350,
                        width: screenWidth*0.760,
                        margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                             color: editbgColor,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(width: 0, color: editbgColor,


                            )

                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(appLogo,
                            height: 50,
                            width: 50,),
                            SizedBox(height: 16,),
                            const CustomText(text: uploadphoto,
                            color: Colors.white,
                            fontfamilly: montBook,
                            sizeOfFont: 20,)
                          ],
                        ),
                      )
                    ],
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(58.0),
                  child: CommonButton(btnBgColor: btnbgColor, btnText: next, onClick: (){
                    Navigator.pushNamed(context, '/SetYourPasswordScreen');
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
