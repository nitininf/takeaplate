import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_button.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:takeaplate/UTILS/app_strings.dart';

import '../../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../../UTILS/app_color.dart';
import '../../../UTILS/app_images.dart';
import '../../../UTILS/fontfaimlly_string.dart';
import '../../../main.dart';

class ProfileScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return  SafeArea(child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 5.0,right:20,left: 20 ,bottom: 10),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            getView()

          ],
        ),
      ),
    ));
  }

  Widget buildSection(String title, String viewAllText) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: title, color: btnbgColor, fontfamilly: montBold, weight: FontWeight.w900, sizeOfFont: 16),
          GestureDetector(child: CustomText(text: viewAllText, color: Colors.black, fontfamilly: montLight, weight: FontWeight.w300),
          onTap: (){
            if(title=="CURRENT ORDERS") {
              Navigator.pushNamed(
                  navigatorKey.currentContext!, '/MyOrdersSccreen');
            }
            else if(title=="MY FAVOURITES"){
              Navigator.pushNamed(
                  navigatorKey.currentContext!, '/FavouriteScreen');
            }
            else{
              Navigator.pushNamed(
                  navigatorKey.currentContext!, '/PaymentMethodScreen');
            }
          },
          ),
        ],
      ),
    );
  }

  Widget getCards() {
    return
      GestureDetector(
        onTap: (){
          Navigator.pushNamed(navigatorKey.currentContext!, '/YourOrderScreen');
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
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(text: "Surprise Pack", color: btntxtColor, fontfamilly: montitalic,sizeOfFont: 18,),

                  const CustomText(text: "Salad & Co", color: btntxtColor, fontfamilly: montBold,weight: FontWeight.w400,sizeOfFont: 13,),

                  const CustomText(text: "Tomorrow-7:35-8:40 Am", color: onboardingbgColor,sizeOfFont: 10, fontfamilly: montBold,weight: FontWeight.w200,),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: readybgColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 1, color: Colors.white),
                        ),
                        child: const CustomText(text: "READY FOR PCKUP",sizeOfFont: 10,weight: FontWeight.w700,color: readyColor,),
                      ),
                      SizedBox(width: 10,),
                      CustomText(text: "84 Km", color: btntxtColor,sizeOfFont: 10, fontfamilly: montBold,weight: FontWeight.w400,),
                    ],

                  ),
                  SizedBox(height: 0,),
                  CustomText(text: "\$"+"9.99", color: dolorColor,sizeOfFont: 24, fontfamilly: montBold,weight: FontWeight.w900,),

                ],
              ),
              const SizedBox(width: 18,),
              Expanded(
                child: Stack(
                  alignment: Alignment.topRight,
                  clipBehavior: Clip.none,
                  children: [
                    Image.asset(food_image, height: 130, width: 130, fit: BoxFit.cover),
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
              ),
            ],
          ),
        ),
      );
  }
  Widget getView(){
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(profile,height: 100,width: 100,),
                SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(text: "Jack Brown",color: editbgColor,sizeOfFont: 18,weight: FontWeight.w800,),
                    const CustomText(text: "Gold Coast, Australia",sizeOfFont: 12,weight: FontWeight.w600,color: btntxtColor,),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: editprofilbgColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 1, color: Colors.white),
                      ),
                      child: GestureDetector(onTap:(){
                        Navigator.pushNamed(
                            navigatorKey.currentContext!, '/EditProfileScreen');
                      },child: const CustomText(text: "EDIT PROFILE",sizeOfFont: 10,weight: FontWeight.w700,color: editprofileColor,)),
                    )
                  ],
                ),
               // profileSection()
              ],
            ),
            const SizedBox(height: 20,),
            buildSection("CURRENT ORDERS", viewall),
            const SizedBox(height: 5,),
            getCards(),
            getCards(),
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: Divider(height: 0,color: grayColor,thickness: 0,),
            ),
            buildSection("MY FAVOURITES", viewall),
            const SizedBox(height: 5,),
            buildHorizontalFavCards(),
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: Divider(height: 0,color: grayColor,thickness: 0,),
            ),
            buildSection("PAYMENT METHOD", viewall),
            const SizedBox(height: 5,),
             getMasterCard()
          ],
        ),
      ),
    );
  }
  Widget buildHorizontalFavCards() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(8, (index) => getFavCards()),
      ),
    );
  }

  Widget getMasterCard(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: mastercardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 0, color: Colors.grey),
      ),
      child:  Row(
        children: [
          Image.asset(master_card,fit: BoxFit.contain,height: 40,width: 70,),
          const SizedBox(width: 10,),
          const Expanded(child: CustomText(text: "MasterCard",color: btntxtColor,sizeOfFont: 14,weight: FontWeight.w700,)),
          const CustomText(text: "-2211",color: btntxtColor,sizeOfFont: 14,weight: FontWeight.w600,),
        ],
      ),
    );
  }
  Widget getFavCards() {
    return
      Container(
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
              CustomText(text: "Surprise Pack", color: btntxtColor, fontfamilly: montitalic,sizeOfFont: 18,),

              CustomText(text: "Salad & Co", color: btntxtColor, fontfamilly: montBold,weight: FontWeight.w400,sizeOfFont: 13,),

              CustomText(text: "Tomorrow-7:35-8:40 Am", color: onboardingbgColor,sizeOfFont: 10, fontfamilly: montBold,weight: FontWeight.w200,),
              SizedBox(height: 5,),
              Row(
                children: [
                  Icon(Icons.star_border,size: 20,color: Colors.grey,),
                  Icon(Icons.star_border,size: 20,color: Colors.grey,),
                  Icon(Icons.star_border,size: 20,color: Colors.grey,),
                  Icon(Icons.star_border,size: 20,color: Colors.grey,),
                  Icon(Icons.star_border,size: 20,color: Colors.grey,),
                  SizedBox(width: 10,),
                  CustomText(text: "84 Km", color: btntxtColor,sizeOfFont: 10, fontfamilly: montBold,weight: FontWeight.w400,),
                ],

              ),
              SizedBox(height: 5,),
              CustomText(text: "\$"+"9.99", color: dolorColor,sizeOfFont: 24, fontfamilly: montBold,weight: FontWeight.w900,),

            ],
          ),
          const SizedBox(width: 18,),
          Stack(
            alignment: Alignment.topRight,
            clipBehavior: Clip.none,
            children: [
              Image.asset(food_image, height: 130, width: 130, fit: BoxFit.cover),
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
    );
  }

}