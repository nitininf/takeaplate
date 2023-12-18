import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_button.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/main.dart';

import '../../../UTILS/app_images.dart';
import '../../../UTILS/fontfaimlly_string.dart';

class YourCardScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
   return  SafeArea(child: Scaffold(
   backgroundColor: bgColor,
     body: Padding(
       padding: const EdgeInsets.only(right: 35.0,left: 35,bottom: 0),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
            getView(screenHeight)
         ],
       ),
     )

   ),
   );
  }


  Widget getView(double screenHeight){
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          SizedBox(height: 18,),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: const CustomText(text: "YOUR CART",color: editbgColor,sizeOfFont: 20,fontfamilly: montHeavy,),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(width: 1, color: grayColor)),
            child:Column(
              children: [
                SizedBox(height: 10,),
                for(int i=0;i<4;i++)
                  getCardViews(),
                SizedBox(height: screenHeight*0.120),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                  decoration: BoxDecoration(
                      color: onboardingBtn.withOpacity(0.20),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(width: 0, color: grayColor)
      
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 8.0,right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(text: "Total",color: btntxtColor,sizeOfFont: 21,fontfamilly: montBold,),
                        CustomText(text: "\$39.99",color: dolorColor,sizeOfFont: 28,fontfamilly: montHeavy,),


                      ],
                    ),
                  ),
                ),
      
              ],
            ),
          ) ,
          Padding(
            padding: const EdgeInsets.only(top: 30.0,right: 30,left: 30),
            child: CommonButton(btnBgColor: btnbgColor, sizeOfFont:18,btnText: "GO TO CHECKOUT", onClick: (){
              Navigator.pushNamed(navigatorKey.currentContext!, '/OrderSummeryScreen');
            }),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0,left: 30,right: 30,bottom: 20),
            child: CommonButton(btnBgColor: onboardingBtn.withOpacity(1), sizeOfFont:18,btnTextColor: offerColor.withOpacity(0.5),btnText: "ADD MORE ITEMS", onClick: (){}),
          ),
        ],),
      ),
    );
  }



  Widget getCardViews() {
    return  Padding(
      padding: const EdgeInsets.only(right: 10.0,left: 10,top: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
               Image.asset(food_image, height: 40, width: 40, fit: BoxFit.cover),
              SizedBox(width: 8,),
              const Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(text: "Surprise Pack", maxLin:1,color: btntxtColor, fontfamilly: montBold,sizeOfFont: 15,),

                    CustomText(text: "Salad & Co", maxLin:1,color: btntxtColor, fontfamilly: montRegular,sizeOfFont: 11,),

                  ],
                ),
              ),
              const SizedBox(width: 8,),
              Expanded(
                flex: 0,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  decoration: BoxDecoration(
                      color: btnbgColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(width: 1, color: Colors.white)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                     Image.asset(delete_icon,height: 9,width: 9,),
                      SizedBox(width: 8,),
                      CustomText(text: "1",sizeOfFont: 12,color: hintColor,),
                      SizedBox(width: 8,),
                      Icon(Icons.add,color: hintColor,size: 12,),
                    ],
                  ) ,
                ),
              ),

              CustomText(text: "\$9.99",sizeOfFont: 15,color: dolorColor,fontfamilly: montHeavy,)
            ],
          ),
          SizedBox(height: 5,),
          Divider(color: grayColor,thickness: 0,)
        ],
      ),
    );
  }
}