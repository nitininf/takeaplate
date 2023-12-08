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
       padding: const EdgeInsets.all(20.0),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           CustomAppBar(),
           SizedBox(height: 30,),
           GestureDetector(child: CustomText(text: "YOUR NOTIFICATIONS",weight: FontWeight.w900,sizeOfFont: 20,color: editbgColor,),
           onTap: (){
           //  Navigator.pushNamed(context, '/FaqScreenScreen');
           },),
           SizedBox(height: 10,),
           getView(color: faqSelectedColor),
           SizedBox(height: 10,),
           getView(),
           SizedBox(height: 10,),
           getView(),
           SizedBox(height: 10,),
           getView()
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
              child: CustomText(text: "New meal purchase has been confirmation",weight: FontWeight.w500,color: editbgColor,sizeOfFont: 15,fontfamilly: montBook,)
          ),
          Expanded(
            flex: 0,
              child: CustomText(text: "11:00 AM \n 23/09/23023",weight: FontWeight.w600,color: btnbgColor,sizeOfFont: 12,isAlign: true,)),
        ],
      ),
    );
  }
}