import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeaplate/MULTI-PROVIDER/OrderAndPayProvider.dart';
import 'package:takeaplate/MULTI-PROVIDER/OrderAndPayProvider.dart';
import 'package:takeaplate/MULTI-PROVIDER/common_counter.dart';

import '../../CUSTOM_WIDGETS/common_button.dart';
import '../../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../../CUSTOM_WIDGETS/custom_search_field.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../UTILS/app_color.dart';
import '../../UTILS/app_images.dart';
import '../../UTILS/app_strings.dart';
import '../../UTILS/fontfaimlly_string.dart';


class OrderAndPayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var commonProvider = Provider.of<CommonCounter>(context, listen: false);
    var orderAndPayProvider = Provider.of<OrderAndPayProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 22.0, right: 22, bottom: 22, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomAppBar(),
              const SizedBox(height: 23),
              CustomSearchField(hintText: "Search"),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      const SizedBox(height: 30,),
                      buildSection(lastminute, "",orderAndPayProvider,commonProvider),
                      getCards(context,orderAndPayProvider,commonProvider),
                      const SizedBox(height: 10,),
                      Padding(
                        padding: EdgeInsets.only(left: 30, right: 30),
                        child: CommonButton(
                          btnBgColor: btnbgColor,
                          btnText: orderandpay,
                          onClick: () {
                            Navigator.pushNamed(context, '/PaymentDetailsScreen');
                          },
                        ),
                      )
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

  Widget buildSection(String title, String viewAllText, OrderAndPayProvider orderAndPayProvider, CommonCounter commonProvider) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: title, color: btnbgColor, fontfamilly: montHeavy, sizeOfFont: 20),
          CustomText(text: viewAllText, color: Colors.black, fontfamilly: montHeavy, weight: FontWeight.w900),
        ],
      ),
    );
  }

  Widget getCards(BuildContext context, OrderAndPayProvider orderAndPayProvider, CommonCounter commonProvider) {
    return Consumer<OrderAndPayProvider>(builder: ((context, orderAndPayProvider, child) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 0, color: viewallColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: 280,
                width: 280,
                child: Image.asset(
                  food_image,
                  height: 275,
                  width: 275,
                  fit: BoxFit.fill,
                )),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: orderAndPayProvider.foodData[0]["name"], sizeOfFont: 20, color: viewallColor, fontfamilly: montBold),
                Row(
                  children: [
                    !commonProvider.isViewMore ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: editbgColor,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0), bottomLeft: Radius.circular(30.0)),
                          border: Border.all(width: 1, color: Colors.white),
                        ),
                        child: CustomText(text: "Report", color: hintColor, fontfamilly: montLight, sizeOfFont: 11,)
                    ) : Text(""),
                    Padding(
                      padding: EdgeInsets.only(left: 2.0, top: 18),
                      child: Image.asset(three_dot, width: 14, height: 4,),
                    ),
                  ],
                )
              ],
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: orderAndPayProvider.foodData[0]["category"], color: viewallColor, sizeOfFont: 16, fontfamilly: montLight),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: CustomText(text: orderAndPayProvider.foodData[0]["pickUpTime"], sizeOfFont: 11, color: viewallColor, fontfamilly: montLight),
                ),
              ],
            ),

            SizedBox(height: 3,),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    RatingBar.readOnly(
                      filledIcon: Icons.star,
                      emptyIcon: Icons.star_border,
                      filledColor: btnbgColor,
                      initialRating: orderAndPayProvider.foodData[0]["rating"],
                      size: 20,
                      maxRating: 5,
                    ),
                  ],
                ),
                CustomText(text: orderAndPayProvider.foodData[0]["distance"], color: editbgColor, fontfamilly: montLight, sizeOfFont: 17,),
              ],
            ),
            SizedBox(height: 10,),
            const CustomText(text: "23 Dreamland Av.., Australia", color: viewallColor, fontfamilly: montLight, sizeOfFont: 12,),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: "Description...", color: viewallColor, fontfamilly: montLight, sizeOfFont: 12,),
                CustomText(text: orderAndPayProvider.foodData[0]["price"], color: offerColor, sizeOfFont: 27, fontfamilly: montHeavy),
              ],
            ),
            SizedBox(height: 10,),
            viewMore(commonProvider,orderAndPayProvider)

          ],
        ),
      );
    }));
  }

  Widget viewMore(CommonCounter commonCounter, OrderAndPayProvider orderAndPayProvider) {
    return Consumer<CommonCounter>(builder: (context, commonCounter, child) {
      return commonCounter.isViewMore ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(text: orderAndPayProvider.foodData[0]["description"], fontfamilly: montRegular, sizeOfFont: 12,
            color: cardTextColor.withOpacity(0.47),),
          SizedBox(height: 10,),
          Row(
            children: [
              for (var feature in orderAndPayProvider.foodData[0]["features"])
                featureImage(feature),
            ],
          ),
          SizedBox(height: 20,),
          GestureDetector(
            onTap: () {
              commonCounter.viewMoreLess("VIEW MORE");
            },
            child: CustomText(text: commonCounter.textName, color: btnbgColor, fontfamilly: montLight, sizeOfFont: 14,),
          ),
        ],
      ) : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              commonCounter.viewMoreLess("VIEW LESS");
            },
            child: CustomText(text: commonCounter.textName, color: btnbgColor, fontfamilly: montLight, sizeOfFont: 14,),
          )
        ],
      );
    });
  }

  Widget featureImage(String feature) {
    String imagePath = "";

    switch (feature) {
      case "Gluten-Free":
        imagePath = gluten_free;
        break;
      case "Soy-Free":
        imagePath = soy_free;
        break;
      case "Location-Free":
        imagePath = location_freee;
        break;
    // Add more cases for other features if needed

    }

    return Image.asset(imagePath, height: 30, width: 30);
  }

}
