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
      body:Stack(
        children: [
          Image.asset(
            appBackground,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: screenHeight * 0.06,
              ),
              const Padding(
                padding: EdgeInsets.only(right: 50.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child:CustomText(text: skip,color: Colors.white,)
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  appLogo,
                  height: 80,
                  width: 80,
                ),
              ),
              //  SizedBox(height: screenHeight*0.05,),
              Column(
                children: [
                 getWidget(title: "NEW DEAL FRM YOUR FAVOURITE RESTAURENT!"),
                  getWidget(title: "NEW STORE ADDED NEARBY",subtitle: "DON'T MISS OUT"),
                  getWidget(title: "NEW MEAL PURCHASE CONFIIRMATION"),
                ],
              ),
               Column(
                children: [
                 const CustomText(text:"NEVER MISS A DEAL AGAIN" ,fontfamilly: montBold,color: Colors.white,sizeOfFont: 21,
                isAlign: false,
              ),
                  const CustomText(text:"PERSONALISE AND CHOOSE \n WHAT YOU WANT TO KNOW" ,fontfamilly: montBold,color: Colors.white,sizeOfFont: 16,
                    isAlign: false,
                  ),
                  CommonButton(btnBgColor: Colors.white, btnText: turnonnotification, onClick: (){
                 //   Navigator.pushNamed(context, '/SignupScreen');
                  }),
                ],
              )


            ],
          ),

        ],

      ),


    );


  }
  Widget getWidget({String? title, String? subtitle=""}){
    return  Container(
      margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
      decoration: BoxDecoration(
        //color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(width: 1, color: Colors.white)),
      child: Row(
        children: [
          Expanded(child: Image.asset(appLogo,height: 30,width: 30,)),
           Expanded(
              flex: 3,
              child: Column(
                children: [
                  Align(
                    child: CustomText(text:title! ,fontfamilly: montBold,color: Colors.white,sizeOfFont: 12,
                      isAlign: false,
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: CustomText(text:subtitle! ,fontfamilly: montBold,color: Colors.white,sizeOfFont: 12,
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

