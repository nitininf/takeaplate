import 'package:flutter/material.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_button.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/app_images.dart';
import 'package:takeaplate/UTILS/app_strings.dart';
import 'package:takeaplate/UTILS/fontfaimlly_string.dart';
import 'package:takeaplate/main.dart';
import '../../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../../CUSTOM_WIDGETS/custom_search_field.dart';
class HomeScreen extends StatelessWidget {
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
                      buildHorizontalList(items),
                      buildSection(closet, viewall),
                      buildHorizontalCards(),
                        const Padding(
                         padding: EdgeInsets.only(top: 10.0,left: 15,right: 15,bottom: 15),
                         child: Divider(
                          color: Colors.grey,
                          thickness: 0,
                                               ),
                       ),
                      buildSection(lastminute, viewall),
                      buildHorizontalFavCards(),
                      buildHorizontalFavCards(),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0,left: 15,right: 15,bottom: 15),
                        child: Divider(
                          color: Colors.grey,
                          thickness: 0,
                        ),
                      ),
                      buildSection(myfav, viewall),
                      buildHorizontalFavCards(),
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

  Widget buildHorizontalList(List<String> items) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          items.length,
              (index) => GestureDetector(
                onTap: (){
                  Navigator.pushNamed(navigatorKey.currentContext!, '/OrderAndPayScreen');
                },
                child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
                            decoration: BoxDecoration(
                color: editbgColor,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(width: 1, color: Colors.white),
                            ),
                            child: CustomText(text: items[index], color: hintColor, fontfamilly: montBook,weight: FontWeight.w400,),
                          ),
              ),
        ),
      ),
    );
  }

  Widget buildSection(String title, String viewAllText) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8.0,top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: title, color: btnbgColor, fontfamilly: montBold, weight: FontWeight.w900, sizeOfFont: 16),
          CustomText(text: viewAllText, color: Colors.black, fontfamilly: montLight, weight: FontWeight.w300),
        ],
      ),
    );
  }

  Widget buildHorizontalCards() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(items.length, (index) => getCards()),
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
           const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: "Salad & Co.", color: btntxtColor, fontfamilly: montitalic,sizeOfFont: 18,),

              CustomText(text: "Health Foods", color: btntxtColor, fontfamilly: montBold,weight: FontWeight.w400,sizeOfFont: 13,),

              CustomText(text: "3 offers available", color: onboardingbgColor,sizeOfFont: 10, fontfamilly: montBold,weight: FontWeight.w300,),
  SizedBox(height: 5,),
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
          const SizedBox(width: 18,),
          Stack(
            alignment: Alignment.topRight,
            children: [
              Image.asset(food_image, height: 80, width: 80, fit: BoxFit.cover),
              Positioned(
                right: -15,
                child: Image.asset(
                  save_icon,
                  height: 25,
                  width: 25,
                  color: btnbgColor,

                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildHorizontalFavCards() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(items.length, (index) => getFavCards()),
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
              CustomText(text: "\$"+"9.99", color: Colors.blue,sizeOfFont: 24, fontfamilly: montBold,weight: FontWeight.w900,),

            ],
          ),
          const SizedBox(width: 18,),
          Stack(
            alignment: Alignment.topRight,
            children: [
              Image.asset(food_image, height: 130, width: 130, fit: BoxFit.cover),
              Positioned(
                right: -15,
                child: Image.asset(
                  save_icon,
                  height: 25,
                  width: 25,
                  color: btnbgColor,

                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
