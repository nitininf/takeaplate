import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_button.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_edit_text.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_email_field.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:takeaplate/main.dart';

import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../UTILS/app_color.dart';
import '../../UTILS/app_strings.dart';
import '../../UTILS/fontfaimlly_string.dart';
import '../../UTILS/validation.dart';

class ContactUs extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return SafeArea(child:
   Scaffold(
     body: Padding(
       padding: const EdgeInsets.all(20.0),
       child:  Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           const CustomAppBar(),
           getView()

        ]
          ),
     ),

   )
   );



  }

  Widget getView()
  {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            const CustomText(text: "CONTACT US",sizeOfFont: 20,weight: FontWeight.w800,),
            const SizedBox(height: 20,),
            CommonEditText(hintText: name,isbgColor: true,),
            const SizedBox(height: 20,),
            CommonEmailField(hintText: email,isbgColor: true,),
            const SizedBox(height:  20,),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: grayColor,
                    width: 1.0, // Adjust the width as needed
                  ),
                ),
                child: TextFormField(
                    validator: FormValidator.validateEmail,
                    keyboardType: TextInputType.text,
                    maxLines: 15,
                    //   controller: controller,
                    style:  const TextStyle(fontWeight: FontWeight.w500, fontSize: 14,fontFamily: montBook,color:btntxtColor
                    ),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontWeight: FontWeight.w300, fontSize: 16,fontFamily: montitalic,color: btntxtColor),
                        hintText: "Comments")
                )
            ),
      
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(top: 8.0,left: 30,right: 30),
              child: CommonButton(btnBgColor: btnbgColor, btnText: submit, onClick: (){
                Navigator.pushNamed(navigatorKey.currentContext!, '/YourOrderScreen');
              }),
            )
          ],
        ),
      ),
    );
  }

}