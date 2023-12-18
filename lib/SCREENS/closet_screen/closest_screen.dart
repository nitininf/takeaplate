import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:takeaplate/UTILS/app_strings.dart';

import '../../CUSTOM_WIDGETS/custom_search_field.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../UTILS/app_color.dart';
import '../../UTILS/app_images.dart';
import '../../UTILS/fontfaimlly_string.dart';
import '../../main.dart';

class ClosestScreen extends StatelessWidget{
  final List<String> items = ['Healthy', 'Sushi', 'Desserts', 'Sugar', 'Sweets'];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(padding: const EdgeInsets.only(top: 0.0,bottom: 20,left: 25,right: 25),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(),
              const SizedBox(height: 20),
              const CustomSearchField(hintText:"Search"),
              const Padding(
                padding: EdgeInsets.only(left: 13.0,top: 20),
                child: CustomText(text: closet, color: btnbgColor, fontfamilly: montHeavy, sizeOfFont: 20),
              ),
              buildHorizontalList(items),
              buildVeerticalCards()
            ],
          ),
        ),
      ),
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
          children: List.generate(items.length, (index) => getFavCards()),
        ),
      ),
    );
  }
  Widget getFavCards() {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(navigatorKey.currentContext!, '/RestrorentProfileScreen');
      },
      child: Container(
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
              flex: 2,
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(text: "Salad & Co.",maxLin: 1, color: btntxtColor, fontfamilly: montBold,sizeOfFont: 24,),

                  CustomText(text: "Health Foods", maxLin: 1,color: btntxtColor, fontfamilly: montRegular,sizeOfFont: 14,),

                  CustomText(text: "3 offers available", maxLin: 1,color: offerColor,sizeOfFont: 9, fontfamilly: montBook,),
                  SizedBox(height: 1,),
                  Row(
                    children: [
                      Icon(Icons.star,size: 20,color: btnbgColor,),
                      Icon(Icons.star,size: 20,color: btnbgColor,),
                      Icon(Icons.star,size: 20,color: btnbgColor,),
                      Icon(Icons.star,size: 20,color: btnbgColor,),
                      Icon(Icons.star,size: 20,color: btnbgColor,),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 18,),
            Expanded(
              child: Stack(
                alignment: Alignment.topRight,
                clipBehavior: Clip.none,
                children: [
                  Image.asset(food_image, height: 80, width: 80, fit: BoxFit.cover),
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
      ),
    );
  }


}