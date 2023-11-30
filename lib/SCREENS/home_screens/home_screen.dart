import 'package:flutter/material.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_button.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/app_images.dart';
import 'package:takeaplate/UTILS/app_strings.dart';
import 'package:takeaplate/UTILS/fontfaimlly_string.dart';
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
                      buildSection('Closet', 'View All'),
                      buildHorizontalCards(),
                      const Divider(
                        color: Colors.grey,
                        thickness: 0,
                      ),
                      buildSection('Last Minute', 'View All'),
                      buildHorizontalCards(),
                      const Divider(
                        color: Colors.grey,
                        thickness: 0,
                      ),
                      buildSection('Another Section', 'View All'),
                      buildHorizontalCards(),
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
              (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: editbgColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 1, color: Colors.white),
            ),
            child: CustomText(text: items[index], color: hintColor, fontfamilly: montBook),
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
          CustomText(text: title, color: btnbgColor, fontfamilly: montBold, weight: FontWeight.bold, sizeOfFont: 18),
          CustomText(text: viewAllText, color: Colors.black, fontfamilly: montLight, weight: FontWeight.w400),
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
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 0, color: Colors.grey),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              const CustomText(text: "sddsdfdffd", color: btntxtColor, fontfamilly: montBold),
              const CustomText(text: "sddsdfdffd", color: btntxtColor, fontfamilly: montBold),
              const CustomText(text: "sddsdfdffd", color: btntxtColor, fontfamilly: montBold),
              Row(
                children: [
                  const CustomText(text: "sddsdfdffd", color: btntxtColor, fontfamilly: montBold),
                  const CustomText(text: "sddsdfdffd", color: btntxtColor, fontfamilly: montBold),
                ],
              ),
            ],
          ),
          Stack(
            alignment: Alignment.topRight,
            children: [
              Image.asset(food_image, height: 80, width: 80, fit: BoxFit.cover),
              Positioned(
                right: -5,
                child: Image.asset(
                  save_icon,
                  height: 30,
                  width: 30,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
