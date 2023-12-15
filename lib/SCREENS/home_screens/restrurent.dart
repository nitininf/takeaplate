import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../../CUSTOM_WIDGETS/custom_search_field.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../UTILS/app_color.dart';
import '../../UTILS/app_images.dart';
import '../../UTILS/fontfaimlly_string.dart';
import '../../main.dart';

class RestrurentScreen extends StatelessWidget{
  final List<String> items = ['Healthy', 'Sushi', 'Desserts', 'Sugar', 'Sweets'];

  @override
  Widget build(BuildContext context) {
   return  SafeArea(
       child: Scaffold(
       body: Padding(
           padding: const EdgeInsets.only(top: 5.0,right:20,left: 20 ,bottom: 10),
       child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           const SizedBox(height: 20),
           const CustomSearchField(hintText:"Search"),
           const Padding(
             padding: EdgeInsets.only(left: 13.0,top: 30),
             child: CustomText(text: "RESTAURANTS", color: btnbgColor, fontfamilly: montHeavy, sizeOfFont: 20),
           ),
           buildHorizontalList(items),
           buildVeerticalCards()
         ],
       ),
       ),
   )

   );
  }
  Widget buildHorizontalList(List<String> items) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          items.length,
              (index) => GestureDetector(
            onTap: (){
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              decoration: BoxDecoration(
                color: editbgColor,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(width: 1, color: Colors.white),
              ),
              child: CustomText(text: items[index], color: hintColor, fontfamilly: montBook,sizeOfFont: 19,),
            ),
          ),
        ),
      ),
    );
  }
  Widget buildVeerticalCards() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(items.length, (index) => GestureDetector(onTap:(){
            Navigator.pushNamed(navigatorKey.currentContext!, '/RestrorentProfileScreen');
          },
              child: getFavCards())),
        ),
      ),
    );
  }
  Widget getFavCards() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 0, color: Colors.grey),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const  Expanded(
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: "Salad & Co", color: btntxtColor, fontfamilly: montBold,sizeOfFont: 27,maxLin: 1,),
            
                CustomText(text: "Health Foods", color: graysColor, fontfamilly: montRegular,sizeOfFont: 16,maxLin: 1,),
            
                CustomText(text: "23 Dreamland Av.., Australia", color: graysColor,sizeOfFont: 12, fontfamilly: montLight,maxLin: 1,),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Icon(Icons.star,size: 20,color: btnbgColor,),
                    Icon(Icons.star,size: 20,color: btnbgColor,),
                    Icon(Icons.star,size: 20,color: btnbgColor,),
                    Icon(Icons.star,size: 20,color: btnbgColor,),
                    Icon(Icons.star,size: 20,color: btnbgColor,),
                    SizedBox(width: 10,),
                    Expanded(child: CustomText(text: "3 offers available", color: offerColor,sizeOfFont: 10, fontfamilly: montRegular,maxLin: 1,)),
                  ],
            
                ),
            
              ],
            ),
          ),
          const SizedBox(width: 8,),
          Expanded(
            flex: 0,
            child: Stack(
              alignment: Alignment.topRight,
              clipBehavior: Clip.none,
              children: [
                Image.asset(food_image, height: 90, width: 85, fit: BoxFit.contain),
                Positioned(
                  right: -4,
                  child: Image.asset(
                    save_icon,
                    height: 15,
                    width: 18,
            
            
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}