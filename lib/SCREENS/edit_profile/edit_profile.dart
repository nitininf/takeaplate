import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/UTILS/app_images.dart';

import '../../CUSTOM_WIDGETS/common_button.dart';
import '../../CUSTOM_WIDGETS/common_edit_text.dart';
import '../../CUSTOM_WIDGETS/common_email_field.dart';
import '../../UTILS/app_color.dart';
import '../../UTILS/app_strings.dart';
import '../../UTILS/fontfaimlly_string.dart';

class EditProfileScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return SafeArea(child: Scaffold(
      body: Column(
        children: [
          CustomAppBar(),
          SizedBox(height: 10,),
          CustomText(text: "Edit Profile"),
          Image.asset(appLogo),
          CommonEditText(hintText: fullName,),
          const SizedBox(height: 20,),
          CommonEmailField(hintText: email,),
          const SizedBox(height: 20,),
          CommonEditText(hintText: phoneNumber,fontfamilly: montitalic,),
          const SizedBox(height: 30,),
          Row(
            children: [
              Expanded(child: CommonEditText(hintText: dob,)),
              SizedBox(width: 10,),
              Expanded(child: CommonEditText(hintText: gender,isPassword: true,)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: CommonButton(btnBgColor: btnbgColor, btnText: next, onClick: (){
              Navigator.pushNamed(context, '/UploadPhoto');
            }),
          )

        ],
      ),
    ));
  }

}