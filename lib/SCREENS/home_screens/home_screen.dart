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
        backgroundColor: bgColor,
        body: Padding(
          padding: const EdgeInsets.only(top: 9.0,right:20,left: 20 ,bottom: 10),
          child: Column(
           // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              CustomSearchField(hintText: "Search"),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [

                      buildHorizontalList(items),
                      buildSection(closet, viewall),
                      buildHorizontalCards(),
                        const Padding(
                         padding: EdgeInsets.only(top: 10.0,left: 20,right: 20,bottom: 15),
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
                },
                child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 36),
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

  Widget buildSection(String title, String viewAllText) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0,right: 13.0,top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: title, color: btnbgColor, fontfamilly: montHeavy,  sizeOfFont: 20),
          GestureDetector(
            onTap: (){
              if(title==closet) {
                Navigator.pushNamed(
                    navigatorKey.currentContext!, '/ClosestScreen');
              }
              else if(title==myfav){
                Navigator.pushNamed(navigatorKey.currentContext!, '/FavouriteScreen');
              }
            },

              child: CustomText(text: viewAllText, color: viewallColor, fontfamilly: montRegular,sizeOfFont: 12,)),
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
              CustomText(text: "Salad & Co.", color: btntxtColor, fontfamilly: montBold,sizeOfFont: 24,),

              CustomText(text: "Health Foods", color: btntxtColor, fontfamilly: montRegular,sizeOfFont: 14,),

              CustomText(text: "3 offers available", color: offerColor,sizeOfFont: 9, fontfamilly: montBook,),
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
          const SizedBox(width: 18,),
          Stack(
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
