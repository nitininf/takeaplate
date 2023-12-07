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
     body: Padding(
       padding: const EdgeInsets.only(right: 20.0,left: 20,bottom: 0),
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
          SizedBox(height: 15,),
          const CustomText(text: "YOUR CART",color: editbgColor,sizeOfFont: 18,weight: FontWeight.w800,),
          SizedBox(height: 15,),
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
                      color: editprofilbgColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(width: 0, color: grayColor)
      
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 8.0,right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(text: "Total",color: btntxtColor,sizeOfFont: 14,weight: FontWeight.w800,),
                        CustomText(text: "\$39.99",color: dolorColor,sizeOfFont: 18,weight: FontWeight.w800,),


                      ],
                    ),
                  ),
                ),
      
              ],
            ),
          ) ,
          Padding(
            padding: const EdgeInsets.only(top: 30.0,right: 40,left: 40),
            child: CommonButton(btnBgColor: btnbgColor, btnText: "GO TO CHECKOUT", onClick: (){
              Navigator.pushNamed(navigatorKey.currentContext!, '/OrderSummeryScreen');
            }),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0,left: 40,right: 40,bottom: 20),
            child: CommonButton(btnBgColor: editprofilbgColor, btnTextColor: editprofileColor,btnText: "ADD MORE ITEMS", onClick: (){}),
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
                    CustomText(text: "Surprise Pack", color: btntxtColor, fontfamilly: montitalic,sizeOfFont: 12,),

                    CustomText(text: "Salad & Co", color: btntxtColor, fontfamilly: montBold,weight: FontWeight.w400,sizeOfFont: 10,),

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
                  child:const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.delete,color: hintColor,size: 12,),
                      SizedBox(width: 8,),
                      CustomText(text: "1",sizeOfFont: 12,color: hintColor,),
                      SizedBox(width: 8,),
                      Icon(Icons.add,color: hintColor,size: 12,),
                    ],
                  ) ,
                ),
              ),
              CustomText(text: "\$9.99",sizeOfFont: 12,color: dolorColor,weight: FontWeight.w800,)
            ],
          ),
          Divider(color: grayColor,thickness: 0,)
        ],
      ),
    );
  }
}