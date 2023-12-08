import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_button.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_edit_text.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/main.dart';

import '../../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../../CUSTOM_WIDGETS/custom_text_field.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';

class SettingScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return SafeArea(child: Scaffold(
     body: Padding(
       padding: const EdgeInsets.all(20.0),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           CustomAppBar(),
           Expanded(child: getView()),
           Padding(
             padding: const EdgeInsets.only(left: 40.0,right: 40.0),
             child: Column(
               children: [
                 CommonButton(btnBgColor: btnbgColor, btnText:"LOG OUT", onClick: (){
                   Navigator.pushNamed(context, '/ContactUs');
                 }),
                 SizedBox(height: 10,),
                 CustomText(text: "DELETE ACCOUNT",sizeOfFont: 15,weight: FontWeight.w400,color: grayColor,),
               ],
             ),
           ),
         ],
       ),
     ),
   ));
  }

  Widget getView(){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20,),
          const CustomText(text: "SETTINGS",sizeOfFont: 20,weight: FontWeight.w900,color: editbgColor,),
          const SizedBox(height: 20,),
           CommonTextField(hintText: "Notification Center",onTap: (){
             Navigator.pushNamed(navigatorKey.currentContext!, '/NotificationCenterScreen');
           },),
          const SizedBox(height: 15,),
           CommonTextField(hintText: "Edit Profile",onTap: (){
             Navigator.pushNamed(navigatorKey.currentContext!, '/EditProfileScreen');
           },) ,
          const  SizedBox(height: 15,),
         CommonTextField(hintText: "Frequently asked Questions",onTap: (){
           Navigator.pushNamed(navigatorKey.currentContext!, '/FaqScreenScreen');
         },),

          const  SizedBox(height: 15,),
           CommonTextField(hintText: "Privacy Policy",onTap: (){
             Navigator.pushNamed(navigatorKey.currentContext!, '/PrivacyPolicyScreen');
           },),

          const SizedBox(height: 15,),
          CommonTextField(hintText: "Terms & Conditions",onTap: (){
            Navigator.pushNamed(navigatorKey.currentContext!, '/TermsAndConditionScreen');

          },) ,
          const SizedBox(height: 15,),
           CommonTextField(hintText: "Help",onTap: (){
             Navigator.pushNamed(navigatorKey.currentContext!, '/ContactUs');
           },),

      ],),
    );
  }
}