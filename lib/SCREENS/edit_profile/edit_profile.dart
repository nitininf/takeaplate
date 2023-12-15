import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/UTILS/app_images.dart';
import 'package:takeaplate/UTILS/dialog_helper.dart';
import 'package:takeaplate/main.dart';

import '../../CUSTOM_WIDGETS/common_button.dart';
import '../../CUSTOM_WIDGETS/common_edit_text.dart';
import '../../CUSTOM_WIDGETS/common_email_field.dart';
import '../../UTILS/app_color.dart';
import '../../UTILS/app_strings.dart';
import '../../UTILS/fontfaimlly_string.dart';

class EditProfileScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return  SafeArea(child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top:20.0,bottom: 20,left: 25,right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CustomAppBar(),
            getView()

          ],
        ),
      ),
    ));
  }

  Widget getView(){
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0,right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              const CustomText(text: "EDIT PROFILE",sizeOfFont: 20,fontfamilly: montHeavy,color: btnbgColor,),
              const SizedBox(height: 10,),
              Align(
                  alignment: Alignment.center,
                  child: Image.asset(profile_img,height: 300,fit: BoxFit.contain,)),
              const SizedBox(height: 15,),
              CommonEditText(hintText: fullName,isbgColor: true,),
              const SizedBox(height: 15,),
              CommonEmailField(hintText: email,isbgColor: true,),
              const SizedBox(height: 15,),
              CommonEditText(hintText: phoneNumber,fontfamilly: montBook,isbgColor: true,),
              const SizedBox(height: 15,),
              Row(
                children: [
                  Expanded(child: CommonEditText(hintText: dob,isbgColor: true,)),
                  const SizedBox(width: 10,),
                  Expanded(child: CommonEditText(hintText: gender,isPassword: true,isbgColor: true,)),
                ],
              ),
              SizedBox(height: 30,),
              CommonButton(btnBgColor: btnbgColor, btnText: "SAVE", onClick: (){
                Navigator.pop(navigatorKey.currentContext!);
              }),
            ],
          ),
        ),
      ),
    );
  }
}