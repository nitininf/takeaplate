import 'package:flutter/material.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_button.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/app_images.dart';
import 'package:takeaplate/UTILS/app_strings.dart';
import 'package:takeaplate/UTILS/fontfaimlly_string.dart';

class NotificationTurnOnScreen extends StatelessWidget {
  const NotificationTurnOnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(notification_center), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0,right: 35,left: 35,bottom: 15),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const  Padding(
                  padding:  EdgeInsets.all(3.0),
                  child:   Align(
                    alignment: Alignment.topRight,
                    child:  CustomText(
                      text: skip,
                      color: hintColor,
                      fontfamilly: montBold,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     // SizedBox(height: screenHeight * 0.25,),
                      getWidget(title: favRes),
                      getWidget(title: nearby, subtitle: miss),
                      getWidget(title: confirm),
                    ],
                  ),
                ),
                Column(
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: CustomText(
                        text: dealAgain,
                        fontfamilly: montBold,
                        color: hintColor,
                        sizeOfFont: 18,
                        isAlign: false,
                      ),
                    ),
                    const  Align(
                      alignment: Alignment.center,
                      child:  CustomText(
                        text: choose,
                        fontfamilly: montRegular,
                        color: btnbgColor,
                        sizeOfFont: 16,
                        isAlign: false,
                      ),
                    ),
                    SizedBox(height: 20,),
                    CommonButton(
                      btnBgColor: btnbgColor,
                      btnText: turnonnotification,
                      sizeOfFont: 17,
                      onClick: () {
                        Navigator.pushNamed(context, '/BaseHome');
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),



        /* Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               *//* SizedBox(
                  height: 470,
                  width: 235,
                  child: Center(
                    child: Image.asset(
                      mobile_bg,
                      fit: BoxFit.fill,
                    ),

                  ),
                ),*//*
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.06,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: screenHeight * 0.08,
                    ),
                   *//* Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        appLogo,
                        height: 80,
                        width: 80,
                      ),
                    ),*//*
                    SizedBox(height: screenWidth * 0.05,),
                    const CustomText(
                      text: skip,
                      color: hintColor,
                      fontfamilly: montBold,
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0,right: 35,left: 35,bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: [
                      SizedBox(height: screenHeight * 0.25,),
                      getWidget(title: favRes),
                      getWidget(title: nearby, subtitle: miss),
                      getWidget(title: confirm),
                    ],
                  ),
                  Column(
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: CustomText(
                          text: dealAgain,
                          fontfamilly: montBold,
                          color: hintColor,
                          sizeOfFont: 18,
                          isAlign: false,
                        ),
                      ),
                      const  Align(
                        alignment: Alignment.center,
                        child:  CustomText(
                          text: choose,
                          fontfamilly: montBook,
                          color: btnbgColor,
                          sizeOfFont: 16,
                          isAlign: false,
                        ),
                      ),
                      SizedBox(height: 20,),
                      CommonButton(
                        btnBgColor: btnbgColor,
                        btnText: turnonnotification,
                        onClick: () {
                          Navigator.pushNamed(context, '/BaseHome');
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        )*/

        )



      );

  }


/*  */
  Widget getWidget({String? title, String? subtitle=""}){
    return  Container(
      margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 8),
      decoration: BoxDecoration(
            color: editbgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(width: 1, color: editbgColor)),
      child: Row(
        children: [
          Expanded(child: Image.asset(appLogo,height: 33,width: 33,)),
           Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10,),
                  Align(
                    child: CustomText(text:title! ,fontfamilly: montBold,color: hintColor,sizeOfFont: 12,
                      isAlign: false,
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  //SizedBox(height: 5,),
                  Align(
                    alignment: Alignment.topLeft,
                    child: CustomText(text:subtitle! ,fontfamilly: montLight,color: hintColor,sizeOfFont: 12,
                      isAlign: false,
                    ),
                  ),
                ],
              )),
          Expanded(child: Image.asset(radioon,
            height: 17,
            width: 17,)),
        ],
      ),
    );
  }

}

