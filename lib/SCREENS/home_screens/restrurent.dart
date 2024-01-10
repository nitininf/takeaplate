import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../../CUSTOM_WIDGETS/custom_search_field.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../MULTI-PROVIDER/RestaurantsListProvider.dart';
import '../../Response_Model/RestaurantsListResponse.dart';
import '../../UTILS/app_color.dart';
import '../../UTILS/app_images.dart';
import '../../UTILS/fontfaimlly_string.dart';
import '../../main.dart';

class RestaurantsScreen extends StatelessWidget {
  final List<String> items = ['Healthy', 'Sushi', 'Desserts', 'Sugar', 'Sweets'];
  final RestaurantsListProvider restaurantsProvider = RestaurantsListProvider();
  static const String placeholderImage = 'assets/placeholder_image.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 5.0, right: 20, left: 20, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const CustomSearchField(hintText: "Search"),
            const Padding(
              padding: EdgeInsets.only(left: 13.0, top: 30),
              child: CustomText(text: "RESTAURANTS", color: btnbgColor, fontfamilly: montHeavy, sizeOfFont: 20),
            ),
            buildHorizontalList(items),
            buildVeerticalCards(),
          ],
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
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              decoration: BoxDecoration(
                color: editbgColor,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(width: 1, color: Colors.white),
              ),
              child: CustomText(text: items[index], color: hintColor, fontfamilly: montBook, sizeOfFont: 19,),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildVeerticalCards() {
    return Expanded(
      child: FutureBuilder<RestaurantsListResponse>(
        future: restaurantsProvider.getRestaurantsList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Center the loading indicator
          } else if (snapshot.hasError) {
            return Text('Failed to fetch restaurants. Please try again.');
          } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.data == null) {
            return Text('No restaurants available');
          } else {
            List<Data>? items = snapshot.data!.data;

            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  items!.length,
                      (index) => GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        navigatorKey.currentContext!,
                        '/RestaurantsProfileScreen',
                        arguments: items[index], // Pass the data as arguments
                      );
                    },
                    child: getFavCards(index, items[index]),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget getFavCards(int index, Data data) {
    // Use the 'data' parameter to access properties from the 'Data' class
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 0, color: editbgColor.withOpacity(0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: data.name ?? "", color: btntxtColor, fontfamilly: montBold, sizeOfFont: 27, maxLin: 1,),
                CustomText(text: data.category ?? "", color: graysColor, fontfamilly: montRegular, sizeOfFont: 16, maxLin: 1,),
                CustomText(text: data.address ?? "", color: graysColor, sizeOfFont: 12, fontfamilly: montLight, maxLin: 1,),
                SizedBox(height: 5,),
                Row(
                  children: [
                    RatingBar.readOnly(
                      filledIcon: Icons.star,
                      emptyIcon: Icons.star_border,
                      filledColor: btnbgColor,
                      halfFilledIcon: Icons.star_half,
                      isHalfAllowed: true,
                      halfFilledColor: btnbgColor,
                      initialRating: 4,
                      size: 20,
                      maxRating: 5,
                    ),
                    SizedBox(width: 10,),
                    Expanded(child: CustomText(text: "3 offers available", color: offerColor, sizeOfFont: 10, fontfamilly: montRegular, maxLin: 1,)),
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
                Image.network(
                  data.profileImage ?? food_image,
                  fit: BoxFit.contain,

                ),

                Positioned(
                  right: -4,
                  child: Image.asset(save_icon, height: 15, width: 18,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
