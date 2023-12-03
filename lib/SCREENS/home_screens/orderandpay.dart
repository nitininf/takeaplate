import 'package:flutter/material.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_button.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/app_images.dart';
import 'package:takeaplate/UTILS/app_strings.dart';
import 'package:takeaplate/UTILS/fontfaimlly_string.dart';
import '../../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../../CUSTOM_WIDGETS/custom_search_field.dart';
class OrderAndPayScreen extends StatelessWidget {
  final List<String> items = ['Healthy', 'Sushi', 'Desserts', 'Sugar', 'Sweets'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomAppBar(),
              const SizedBox(height: 10),
              CustomSearchField(hintText: "Search....."),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      const SizedBox(height: 30,),
                      buildSection(lastminute, ""),
                     getCards(),
                     const SizedBox(height: 10,),
                      CommonButton(btnBgColor: btnbgColor, btnText: orderandpay, onClick: (){

                        Navigator.pushNamed(context, '/PaymentDetailsScreen');
                      })
                    ],
                  ),
                ),
              ),
            ],
          ),
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
        border: Border.all(width: 0, color: Colors.grey),
      ),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 280,
              width: 280,
              child: Image.asset(food_image, height: 275,width: 275, fit: BoxFit.fill)),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(text: "Surprise Pack", sizeOfFont: 18, color: btntxtColor, fontfamilly: montBold,weight: FontWeight.w900,),
               Row(
                 children: [
                   Container(
                     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                     decoration: BoxDecoration(
                       color: editbgColor,
                       borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0),bottomLeft: Radius.circular(30.0)),
                       border: Border.all(width: 1, color: Colors.white),
                     ),
                     child: CustomText(text: "Report", color: hintColor, fontfamilly: montBook,weight: FontWeight.w200,),
                   ),
                   CustomText(text: "...",sizeOfFont: 18, color: btnbgColor, fontfamilly: montBold),
                 ],
               )

            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              CustomText(text: "Health Foods", color: btntxtColor, sizeOfFont:16,weight : FontWeight.w300,fontfamilly: montBold),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: CustomText(text: "Pick up Time:11:00 am", sizeOfFont: 10,color: btntxtColor, weight : FontWeight.w300, fontfamilly: montBold),
              ),
            ],
          ),

          SizedBox(height: 10,),
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
              CustomText(text: "84 Km", color: btntxtColor, weight : FontWeight.w300, fontfamilly: montBold),
            ],
          ),
          SizedBox(height: 10,),
          const CustomText(text: "23 Dreamland Av.., Australia", weight : FontWeight.w300, color: btntxtColor, fontfamilly: montBold),
          SizedBox(height: 10,),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(text: "Description...", weight : FontWeight.w300, color: Colors.grey, fontfamilly: montBold),
              CustomText(text: "\$ 9.99", color: editbgColor, sizeOfFont:20,fontfamilly: montBold),
            ],
          ),
          SizedBox(height: 10,),

          GestureDetector(
              onTap: (){
                viewMore();
              },
              child: viewLess(),
          )
        ],
      ),
    );
  }
  Widget viewLess(){
    return CustomText(text: "VIEW MORE", weight : FontWeight.w300, color: btnbgColor, fontfamilly: montitalic);
  }
  Widget viewMore(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
     CustomText(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation \n\n-Lorem ipsum dolor \n -sit amet, consectetur \n -adipiscing elit, sed do \n -eusmod tempor \n -incididunt ut",fontfamilly: montBook,sizeOfFont: 12,weight: FontWeight.w200,),
        SizedBox(height: 10,),
        Row(
          children: [
            Image.asset(gluten_free,height: 30,width: 30,),
            Image.asset(soy_free,height: 30,width: 30,),
            Image.asset(location_freee,height: 30,width: 30,),
          ],
        ),
        SizedBox(height: 20,),
        GestureDetector(
          onTap: (){

          },
            child: CustomText(text: "VIEW LESS", weight : FontWeight.w300, color: btnbgColor, fontfamilly: montitalic)),
      ],
    );
  }
}
