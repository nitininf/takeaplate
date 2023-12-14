import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/fontfaimlly_string.dart';

import '../../CUSTOM_WIDGETS/custom_text_style.dart';

class PrivacyPolicyScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return SafeArea(child: Scaffold(

     body: Padding(
       padding: const EdgeInsets.only(top: 20.0,bottom: 20,left: 29,right: 29),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           CustomAppBar(),
           SizedBox(height: 20,),
          getView()
         ],
       ),
     ),
   ));
  }
  Widget getView(){
    return  Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(child: CustomText(text: "PRIVACY POLICY",sizeOfFont: 20,fontfamilly: montHeavy,color: editbgColor,),
                onTap: (){
                 // Navigator.pushNamed(context, '/TermsAndConditionScreen');
                },),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                    color: faqSelectedColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(width: 1, color: Colors.white)),
                child:CustomText(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor Incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation, Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor Incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor Incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do elusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation Lorem ipsum dolor sit amet, consectetur",color:editbgColor,sizeOfFont: 15,fontfamilly: montRegular,),
              ),
            ],),
        ),
      ),
    );
  }
}