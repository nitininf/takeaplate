import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/fontfamily_string.dart';

import '../../MULTI-PROVIDER/common_counter.dart';
import '../../UTILS/app_images.dart';

class NotificationCenterScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: bgColor,
     body: SafeArea(
       child: Padding(
         padding: const EdgeInsets.only(top: 0.0,bottom: 20,left: 29,right: 20),
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
                 getView("New Deal From Favourite Restaurant",pos: 0),
                 getView("New Restaurant added nearby",pos: 1),
                 getView("New meal purchase confirmation",pos: 2),
                 getView("Broadcast notifications",pos: 3),
                 getView("New Restaurant added nearby",pos: 4),
          
               ],),
             )
           ],
         ),
       ),
     ),
   );
  }

  Widget getView(String title,{int? pos}){
    return Column(
      children: [
        SizedBox(height: 8,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: CustomText(text: title,fontfamilly:montRegular,color: editbgColor,sizeOfFont: 17,)),
            getSelectedRadio(pos!)
          ],
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Divider(height: 0,color: grayColor,thickness: 0,),
        ),
      ],
    );
  }
  Widget getSelectedRadio(int pos){
   return Consumer<CommonCounter>(builder: (context,commonProvider,child)
   {
     return
       GestureDetector(
         onTap: () {

           if(pos==0) {
             commonProvider.isNoti[0] ? commonProvider.notificationCenter(
               false,pos: 0) : commonProvider.notificationCenter(true,pos: 0);
             print("my pos ${pos}");
           }
          else if(pos==1) {
             commonProvider.isNoti[pos] ? commonProvider.notificationCenter(
               false,pos: 1) : commonProvider.notificationCenter(true,pos: 1);
             print("my pos ${pos}+${commonProvider.isNoti[pos]}");
           }
          else if(pos==2) {
             commonProvider.isNoti[pos] ? commonProvider.notificationCenter(
               false,pos: 2) : commonProvider.notificationCenter(true,pos: 2);
           }
           else if(pos==3) {
             commonProvider.isNoti[pos] ? commonProvider.notificationCenter(
               false,pos: 3) : commonProvider.notificationCenter(true,pos: 3);
           }
           else if(pos==4) {
             commonProvider.isNoti[pos] ? commonProvider.notificationCenter(
               false,pos: 4) : commonProvider.notificationCenter(true,pos: 4);
           }


         },
         child:   commonProvider.isNoti[pos] ? Image.asset(radioon,
           height: 35,
           width: 35,) : Image.asset(radiofficon,
           height: 35,
           width: 35,
         ),
       );
   }
   );

   // return isRadio ?   Image.asset(radionicon,height: 35,width: 35,) :  Image.asset(radiofficon,height: 35,width: 35,);
  }
}