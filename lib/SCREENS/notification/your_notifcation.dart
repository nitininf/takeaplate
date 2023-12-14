import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/fontfaimlly_string.dart';

class YourNotificationScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return SafeArea(child: Scaffold(

     body: Padding(
       padding: const EdgeInsets.only(top: 20.0,bottom: 20,right: 29,left: 29),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           CustomAppBar(),
           Padding(
             padding: const EdgeInsets.only(left: 8.0,right: 8),
             child: Column(crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               SizedBox(height: 30,),
               GestureDetector(child: CustomText(text: "YOUR NOTIFICATIONS",fontfamilly: montHeavy,sizeOfFont: 20,color: editbgColor,),
                 onTap: (){
                   //  Navigator.pushNamed(context, '/FaqScreenScreen');
                 },),
               SizedBox(height: 10,),
               getView(color: faqSelectedColor),
              // SizedBox(height: 10,),
               getView(),
              // SizedBox(height: 10,),
               getView(),
               //SizedBox(height: 10,),
               getView()
             ],),
           )
         ],
       ),
     ),
   ));
  }

  Widget getView({Color? color}){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 0, color: Colors.grey),

      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
              child: CustomText(text: "New meal purchase has been confirmation",color: editbgColor,sizeOfFont: 14,fontfamilly: montSemiBold,)
          ),
          Expanded(
            flex: 0,
              child: CustomText(text: "11:00 AM \n 23/09/23023",color: btnbgColor,sizeOfFont: 11,fontfamilly:montSemiBold,isAlign: true,)),
        ],
      ),
    );
  }
}