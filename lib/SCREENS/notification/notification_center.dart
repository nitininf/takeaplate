import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/UTILS/app_color.dart';

import '../../UTILS/app_images.dart';

class NotificationCenterScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return SafeArea(child: Scaffold(
     body: Column(
       children: [
         CustomAppBar(),
         CustomText(text: "Notification Center"),
         getView("title"),
         Divider(height: 0,color: grayColor,),
         getView("title"),
         Divider(height: 0,color: grayColor,), getView("title"),
         Divider(height: 0,color: grayColor,), getView("title"),
         Divider(height: 0,color: grayColor,), getView("title"),
         Divider(height: 0,color: grayColor,),

       ],
     ),
   ));
  }

  Widget getView(String title){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(text: title),
        Image.asset(radionicon)
      ],
    );
  }
}