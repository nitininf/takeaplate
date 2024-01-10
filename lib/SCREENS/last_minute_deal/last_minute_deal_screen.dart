import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:takeaplate/UTILS/app_strings.dart';
import '../../CUSTOM_WIDGETS/custom_search_field.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../MULTI-PROVIDER/RestaurantsListProvider.dart';
import '../../Response_Model/RestaurantDealResponse.dart';
import '../../UTILS/app_color.dart';
import '../../UTILS/app_images.dart';
import '../../UTILS/fontfaimlly_string.dart';
import '../../main.dart';

class LastMinuteDealScreen extends StatelessWidget{
  final List<String> items = ['Healthy', 'Sushi', 'Desserts', 'Sugar', 'Sweets'];
  final RestaurantsListProvider restaurantsProvider = RestaurantsListProvider();


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(padding: const EdgeInsets.only(top: 0.0,bottom: 20,left: 25,right: 25),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(),
              const SizedBox(height: 20),
              const CustomSearchField(hintText:"Search"),
              const Padding(
                padding: EdgeInsets.only(left: 13.0,top: 20),
                child: CustomText(text: closet, color: btnbgColor, fontfamilly: montHeavy, sizeOfFont: 20),
              ),
              buildHorizontalList(items),
              buildVerticalCards()
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


  Widget buildVerticalCards() {
    return Expanded(
      child: FutureBuilder<RestaurentDealResponse>(
        future: restaurantsProvider.getLastMinuteDealsList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Center the loading indicator
          } else if (snapshot.hasError) {
            return Text('Failed to fetch restaurants. Please try again.');
          } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.data == null) {
            return Text('No restaurants available');
          } else {
            List<dealData>? items = snapshot.data?.data;

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



  Widget getFavCards(int index, dealData data) {

    var startTiming = data.customTime?.startTime;
    var endTiming = data.customTime?.endTime;


    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(navigatorKey.currentContext!, '/OrderAndPayScreen', arguments: data,);
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: data.name ?? "",
                    maxLin: 1,
                    color: btntxtColor,
                    fontfamilly: montBold,
                    sizeOfFont: 21,
                  ),
                  CustomText(
                    text: data.store?.name ?? "",
                    maxLin: 1,
                    color: btntxtColor,
                    fontfamilly: montRegular,
                    sizeOfFont: 16,
                  ),
                  CustomText(
                      text: '${startTiming ?? ""} - ${endTiming ?? ""}',
                      maxLin: 1,
                      color: graysColor,
                      sizeOfFont: 11,
                      fontfamilly: montRegular),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      RatingBar.readOnly(
                        filledIcon: Icons.star,
                        emptyIcon: Icons.star_border,
                        halfFilledIcon: Icons.star_half,
                        isHalfAllowed: true,
                        halfFilledColor: btnbgColor,
                        filledColor: btnbgColor,
                        initialRating: double.parse(data.averageRating ?? '0'),
                        size: 20,
                        maxRating: 5,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: CustomText(
                              text: "84 Km",
                              maxLin: 1,
                              color: graysColor,
                              sizeOfFont: 15,
                              fontfamilly: montSemiBold)),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomText(
                    text: '\$ ${data.price ?? ""}',
                    color: dolorColor,
                    sizeOfFont: 27,
                    fontfamilly: montHeavy,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 18,
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.topRight,
                clipBehavior: Clip.none,
                children: [
                  Image.asset(food_image,
                      height: 130, width: 130, fit: BoxFit.cover),
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
      ),
    );
  }




}