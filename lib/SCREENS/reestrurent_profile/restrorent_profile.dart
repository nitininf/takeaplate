import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:takeaplate/main.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../UTILS/app_color.dart';
import '../../UTILS/app_images.dart';
import '../../UTILS/fontfaimlly_string.dart';

class RestrorentProfileScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return SafeArea(child: Scaffold(
     body: Padding(
       padding: const EdgeInsets.all(20.0),
       child: Column(
         children: [
           CustomAppBar(),
           getView()
         ],
       ),
     ),
   ));
  }
  Widget getView(){
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            getCards(),
            buildSection("TODAY'S DEAL", ""),
            buildVeerticalCards()
          ],
        ),
      ),
    );
  }
  Widget buildSection(String title, String viewAllText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: title, color: btnbgColor, fontfamilly: montBold, weight: FontWeight.w900, sizeOfFont: 18),
          CustomText(text: viewAllText, color: Colors.black, fontfamilly: montLight, weight: FontWeight.w900),
        ],
      ),
    );
  }
  Widget getCards() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: null,
      ),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Stack(
             fit: StackFit.passthrough,
             clipBehavior: Clip.none,
             children: [
               Container(
                   height: 150,
                   width: double.infinity,
                   child: Image.asset(restrorent_food, fit: BoxFit.fill)),
               Positioned(
                  bottom: -90,
                  right: 10,
                  child: Container(
                   width: 120,
                   height: 120,
                   decoration: BoxDecoration(
                     color: imgbgColor,
                     borderRadius: BorderRadius.circular(20),
                     border: Border.all(width: 0, color: Colors.grey),

                   ),
                   child:  Center(
                     child: Image.asset(restrorent_img, fit: BoxFit.fill)
                   ),
                 ),
               ),

             ],
           ),
          const SizedBox(height: 20,),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: "Salad & Co.", sizeOfFont: 18, color: btntxtColor, fontfamilly: montBold,weight: FontWeight.w900,),
              CustomText(text: "Health Foods", color: btntxtColor, sizeOfFont:16,weight : FontWeight.w300,fontfamilly: montBold),
              CustomText(text: "23 Dreamland Av.., Australia", weight : FontWeight.w300, sizeOfFont :10,color: btntxtColor, fontfamilly: montBold),

            ],
          ),
          const SizedBox(height: 10,),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
          SizedBox(height: 10,),
          const CustomText(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", weight : FontWeight.w300, sizeOfFont :10,color: btntxtColor, fontfamilly: montBold),
          SizedBox(height: 10,),

       Row(
         children: [
           Container(
             margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
             decoration: BoxDecoration(
               color: btnbgColor.withOpacity(0.3),
               borderRadius: BorderRadius.circular(20),
               border: Border.all(width: 1, color: Colors.white),
             ),
             child: const CustomText(text: "Deals",sizeOfFont: 10,weight: FontWeight.w700,color: hintColor,),
           ),
           SizedBox(width: 8,),
           Container(
             margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
             decoration: BoxDecoration(
               color: btnbgColor,
               borderRadius: BorderRadius.circular(20),
               border: Border.all(width: 1, color: Colors.white),
             ),
             child: const CustomText(text: "Deals you loved",sizeOfFont: 10,weight: FontWeight.w700,color: hintColor,),
           )
         ],
       )
        ],
      ),
    );
  }

  Widget buildVeerticalCards() {
    return  Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(8, (index) => getFavCards()),
    );
  }
  Widget getFavCards() {
    return GestureDetector(
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
              clipBehavior: Clip.none,
              alignment: Alignment.topRight,
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
      ),
    );
  }
}