import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:takeaplate/UTILS/app_strings.dart';
import 'package:takeaplate/main.dart';

import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../UTILS/app_color.dart';
import '../../UTILS/app_images.dart';
import '../../UTILS/fontfaimlly_string.dart';

class MyOrdersScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: bgColor,
        body:
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0,right: 20,left: 20,top: 10),
            child:  ListView(
              children: [
                const CustomAppBar(),
                SizedBox(height: 10,),
                GestureDetector(child: buildSection("CURRENT ORDERS", viewall),
                  onTap: (){
                
                 // Navigator.pushNamed(context, '/PrivacyPolicyScreen');
                  },
                
                ),
                SizedBox(height: 5,),
                getCards(),
                getCards(),
                const Padding(
                  padding: EdgeInsets.only(left: 25.0,right: 25,top:25),
                  child: Divider(height: 0, color: grayColor),
                ),
                buildSection("PREVIOUS ORDERS", viewall),
                buildVerticalCards(),
                buildVerticalCards(),
                
              ],
            )
          ),
        ),
          );




  }
  Widget buildSection(String title, String viewAllText) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: title, color: btnbgColor, fontfamilly: montHeavy,  sizeOfFont: 20),
          CustomText(text: viewAllText, color: viewallColor, fontfamilly: montRegular,sizeOfFont: 12,),
        ],
      ),
    );
  }
  Widget buildVerticalCards() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(8, (index) => getFavCards()),
        ),
      ),
    );
  }
  Widget getCards() {
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
          const Expanded(
            flex: 2,
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: "Surprise Pack",maxLin: 1, color: btntxtColor, fontfamilly: montBold,sizeOfFont: 21,),

                CustomText(text: "Salad & Co",maxLin: 1, color: btntxtColor, fontfamilly: montRegular,sizeOfFont: 16,),

                CustomText(text: "Tomorrow-7:35-8:40 Am",maxLin: 1, color: graysColor,sizeOfFont: 11, fontfamilly: montRegular),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Icon(Icons.star_border,size: 20,color:graysColor,),
                    Icon(Icons.star_border,size: 20,color: graysColor),
                    Icon(Icons.star_border,size: 20,color: graysColor,),
                    Icon(Icons.star_border,size: 20,color: graysColor,),
                    Icon(Icons.star_border,size: 20,color: graysColor,),
                    SizedBox(width: 10,),
                    Expanded(child: CustomText(text: "84 Km",maxLin: 1, color: graysColor,sizeOfFont: 15, fontfamilly: montSemiBold)),
                  ],

                ),
                SizedBox(height: 5,),
                CustomText(text: "\$"+"9.99",maxLin: 1, color: dolorColor,sizeOfFont: 27, fontfamilly: montHeavy,),

              ],
            ),
          ),
          const SizedBox(width: 18,),
          Expanded(
            flex: 0,
            child: Stack(
              alignment: Alignment.topRight,
              clipBehavior: Clip.none,
              children: [
                Image.asset(food_image, height: 130, width: 130, fit: BoxFit.cover),
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
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: "Surprise Pack", color: btntxtColor, fontfamilly: montBold,sizeOfFont: 21,),

              CustomText(text: "Salad & Co", color: btntxtColor, fontfamilly: montRegular,sizeOfFont: 16,),

              CustomText(text: "Tomorrow-7:35-8:40 Am", color: graysColor,sizeOfFont: 11, fontfamilly: montRegular),
              SizedBox(height: 5,),
              Row(
                children: [
                  Icon(Icons.star_border,size: 20,color:graysColor,),
                  Icon(Icons.star_border,size: 20,color: graysColor),
                  Icon(Icons.star_border,size: 20,color: graysColor,),
                  Icon(Icons.star_border,size: 20,color: graysColor,),
                  Icon(Icons.star_border,size: 20,color: graysColor,),
                  SizedBox(width: 10,),
                  CustomText(text: "84 Km", color: graysColor,sizeOfFont: 15, fontfamilly: montSemiBold),
                ],

              ),
              SizedBox(height: 5,),
              CustomText(text: "\$"+"9.99", color: dolorColor,sizeOfFont: 27, fontfamilly: montHeavy,),

            ],
          ),
          const SizedBox(width: 18,),
          Stack(
            alignment: Alignment.topRight,
            clipBehavior: Clip.none,
            children: [
              Image.asset(food_image, height: 130, width: 130, fit: BoxFit.cover),
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
        ],
      ),
    );
  }

}