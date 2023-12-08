import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:takeaplate/UTILS/app_strings.dart';
import 'package:takeaplate/main.dart';

import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../UTILS/app_color.dart';
import '../../UTILS/app_images.dart';
import '../../UTILS/fontfaimlly_string.dart';

class MyOrdersSccreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
        child: Scaffold(
          body:
          Padding(
            padding: const EdgeInsets.all(20.0),
            child:  ListView(
              children: [
                const CustomAppBar(),
                GestureDetector(child: buildSection("CURRENT ORDERS", viewall),
                  onTap: (){

                 // Navigator.pushNamed(context, '/PrivacyPolicyScreen');
                  },

                ),
                getFavCards(),
                getFavCards(),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Divider(height: 0, color: grayColor),
                ),
                buildSection("PREVIOUS ORDERS", viewall),
                buildVerticalCards(),
                buildVerticalCards(),

              ],
            )
          ),
    )
      );




  }
  Widget buildSection(String title, String viewAllText) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: title, color: btnbgColor, fontfamilly: montBold, weight: FontWeight.w900, sizeOfFont: 16),
          CustomText(text: viewAllText, color: Colors.black, fontfamilly: montLight, weight: FontWeight.w300),
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
  Widget getFavCards() {
    return
      GestureDetector(
         onTap: (){
           Navigator.pushNamed(navigatorKey.currentContext!, '/OrderAndPayScreen');
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: "Surprise Pack", color: btntxtColor, fontfamilly: montitalic,sizeOfFont: 18,),

                CustomText(text: "Salad & Co.", color: btntxtColor, fontfamilly: montBold,weight: FontWeight.w400,sizeOfFont: 13,),

                CustomText(text: "Tomorrow-7:45-8.40 AM", color: onboardingbgColor,sizeOfFont: 10, fontfamilly: montBold,weight: FontWeight.w200,),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Icon(Icons.star_border_outlined,size: 20,color: grayColor,),
                    Icon(Icons.star_border_outlined,size: 20,color: grayColor,),
                    Icon(Icons.star_border_outlined,size: 20,color: grayColor,),
                    Icon(Icons.star_border_outlined,size: 20,color: grayColor,),
                    Icon(Icons.star_border_outlined,size: 20,color: grayColor,),
                    SizedBox(width: 10,),
                    CustomText(text: "84 Km", color: editbgColor,sizeOfFont: 10, fontfamilly: montBold,weight: FontWeight.w400,),
                  ],

                ),
                CustomText(text: "\$ 9.99", color: editbgColor,sizeOfFont: 18, fontfamilly: montBold,weight: FontWeight.w900,),


              ],
            ),
            const SizedBox(width: 8,),
            Stack(
              alignment: Alignment.topRight,
              clipBehavior: Clip.none,
              children: [
                Image.asset(food_image, height: 120, width: 120, fit: BoxFit.cover),
                Positioned(
                  right: -10,
                  child: Image.asset(
                    save_icon,
                    height: 25,
                    width: 25,


                  ),
                ),
              ],
            ),
          ],
        ),
            ),
      );
  }
}