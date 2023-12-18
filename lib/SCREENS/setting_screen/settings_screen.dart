import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_button.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_edit_text.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/fontfaimlly_string.dart';
import 'package:takeaplate/main.dart';

import '../../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../../CUSTOM_WIDGETS/custom_text_field.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../MULTI-PROVIDER/common_counter.dart';

class SettingScreen extends StatelessWidget{
  //var counterProvider=Provider.of<CommonCounter>(navigatorKey.currentContext!, listen: false);
  static int count=0;
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: bgColor,
     body: Padding(
       padding: const EdgeInsets.only(top: 0.0,bottom: 20,left: 29,right: 29),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           //CustomAppBar(),
           Expanded(child: getView()),
           Padding(
             padding: const EdgeInsets.only(left: 30.0,right: 30.0),
             child: Column(
               children: [
                 CommonButton(btnBgColor: btnbgColor, btnText:"LOG OUT", onClick: (){
                   //Navigator.pushNamed(context, '/ContactUs');
                 }),
                 SizedBox(height: 10,),
                 CustomText(text: "DELETE ACCOUNT",sizeOfFont: 15,weight: FontWeight.w400,color: grayColor,),
               ],
             ),
           ),
         ],
       ),
     ),
   );
  }

  Widget getView(){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child:  Consumer<CommonCounter>(builder: (context,commonProvider,child){
       return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20,),
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: CustomText(text: "SETTINGS",sizeOfFont: 20,fontfamilly: montHeavy,color: editbgColor,),
          ),
          const SizedBox(height: 12,),
          CommonTextField(hintText: "Notification Center",onTap: (){
            //count=4;
            //commonProvider.getCount(4);
            Navigator.pushNamed(navigatorKey.currentContext!, '/NotificationCenterScreen');
          },),
          const SizedBox(height: 15,),
          CommonTextField(hintText: "Edit Profile",onTap: (){
            Navigator.pushNamed(navigatorKey.currentContext!, '/EditProfileScreen');
          },) ,
          const  SizedBox(height: 15,),
          CommonTextField(hintText: "Frequently Asked Questions",onTap: (){
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
            Navigator.pushNamed(navigatorKey.currentContext!, '/ContactUsSetting');
          },),

        ],);

  }
      )
    );

  }
}