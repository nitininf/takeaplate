import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/fontfaimlly_string.dart';

import '../../UTILS/app_images.dart';

class NotificationCenterScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return SafeArea(child: Scaffold(
     body: Padding(
       padding: const EdgeInsets.only(top: 20.0,bottom: 20,left: 29,right: 20),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           CustomAppBar(),
           SizedBox(height: 24,),
           Padding(
             padding: const EdgeInsets.only(left: 8.0,right: 8),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
               GestureDetector(child: CustomText(text: "NOTIFICATION CENTRE",fontfamilly:montHeavy,color: editbgColor,sizeOfFont: 20,),
                 onTap: (){
                   Navigator.pushNamed(context, '/YourNotificationScreen');
                 },),
               SizedBox(height: 10,),
               getView("New Deal From Favourite Restaurant"),
               getView("New Restaurant added nearby",isRadio: true),
               getView("New meal purchase confirmation"),
               getView("Broadcast notifications"),
               getView("New Restaurant added nearby",isRadio: true),

             ],),
           )
         ],
       ),
     ),
   ));
  }

  Widget getView(String title,{bool? isRadio=false}){
    return Column(
      children: [
        SizedBox(height: 8,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: CustomText(text: title,fontfamilly:montRegular,color: editbgColor,sizeOfFont: 17,)),
            getSelectedRadio(isRadio!)
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(height: 0,color: grayColor,thickness: 0,),
        ),
      ],
    );
  }
  Widget getSelectedRadio(bool isRadio){
    return isRadio ?   Image.asset(radionicon,height: 35,width: 35,) :  Image.asset(radiofficon,height: 35,width: 35,);
  }
}