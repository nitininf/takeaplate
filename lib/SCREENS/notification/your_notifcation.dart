import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';

class YourNotificationScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return SafeArea(child: Scaffold(

     body: Column(
       children: [
         CustomAppBar(),
         SizedBox(height: 10,),
         CustomText(text: "YOUR NOTIFICATIONS"),
         SizedBox(height: 10,),
         getView(),
         SizedBox(height: 10,),
         getView(),
         SizedBox(height: 10,),
         getView(),
         SizedBox(height: 10,),
         getView()
       ],
     ),
   ));
  }

  Widget getView(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 0, color: Colors.grey),

      ),
      child: Row(
        children: [
          CustomText(text: "sdzdfdzgfdfgdg"),
          CustomText(text: "sdzdfdzgfdfgdg"),
        ],
      ),
    );
  }
}