import 'package:custom_rating_bar/custom_rating_bar.dart';
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

class FavouriteScreen extends StatelessWidget{
  final List<String> items = ['Healthy', 'Sushi', 'Desserts', 'Sugar', 'Sweets'];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(padding:  EdgeInsets.only(bottom:20,right: 20,left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(),
              const Padding(
                padding: EdgeInsets.only(left: 8.0,top: 26),
                child: CustomText(text: "YOUR FAVOURITES", color: btnbgColor, fontfamilly: montHeavy, sizeOfFont: 20),
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
          children: List.generate(items.length, (index) => GestureDetector(
              onTap: (){
                Navigator.pushNamed(navigatorKey.currentContext!, '/OrderAndPayScreen');
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
            flex: 2,
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: "Salad & Co", maxLin:1,color: viewallColor, fontfamilly: montBold,sizeOfFont: 25,),
            
                CustomText(text: "Health Foods", maxLin:1,color: viewallColor, fontfamilly: montRegular,sizeOfFont: 16,),
            
                CustomText(text: "23 Dreamland Av.., Australia",maxLin: 1, color: viewallColor,sizeOfFont: 12, fontfamilly: montLight,),
                SizedBox(height: 5,),
                Row(
                  children: [
                    // Icon(Icons.star,size: 20,color: btnbgColor,),
                    // Icon(Icons.star,size: 20,color: btnbgColor,),
                    // Icon(Icons.star,size: 20,color: btnbgColor,),
                    // Icon(Icons.star,size: 20,color: btnbgColor,),
                    // Icon(Icons.star,size: 20,color: btnbgColor,),

                    RatingBar.readOnly(
                      filledIcon: Icons.star,
                      emptyIcon: Icons.star_border,
                      filledColor: btnbgColor,
                      initialRating: 4,
                      size: 20,
                      maxRating: 5,

                    ),

                    SizedBox(width: 10,),
                    Expanded(child: CustomText(text: "3 offers available", maxLin:1,color: offerColor,sizeOfFont: 11, fontfamilly: montBook,)),
                  ],
            
                ),
            
              ],
            ),
          ),
          const SizedBox(width: 8,),
          Expanded(
            child: Stack(
              alignment: Alignment.topRight,
              clipBehavior: Clip.none,
              children: [
                Image.asset(food_image, height: 85, width: 85, fit: BoxFit.cover),
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