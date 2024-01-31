import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_button.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/app_images.dart';
import 'package:takeaplate/UTILS/dialog_helper.dart';
import 'package:takeaplate/UTILS/fontfamily_string.dart';
import 'package:takeaplate/main.dart';
import '../../../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../../MULTI-PROVIDER/common_counter.dart';
import '../../Response_Model/CurrentOrderResponse.dart';
class YourOrderScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final CurrentOrderData data = ModalRoute.of(context)!.settings.arguments as CurrentOrderData;
    var commonProvider = Provider.of<CommonCounter>(context, listen: false);

    
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0,bottom: 20,left: 25,right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomAppBar(),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      buildSection("YOUR ORDER", "",commonProvider),
                      getCards(data,commonProvider),
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


  Widget buildSection(String title, String viewAllText, CommonCounter commonProvider) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: title, color: btnbgColor, fontfamilly: montHeavy,sizeOfFont: 20),
          CustomText(text: viewAllText, color: Colors.black, fontfamilly: montLight, weight: FontWeight.w900),
        ],
      ),
    );
  }

  Widget getCards(CurrentOrderData data, CommonCounter commonProvider) {
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
            child: data.profileImage != null && !(data.profileImage)!.contains("SocketException")
                ? ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                data.profileImage!,
                fit: BoxFit.contain,
              ),
            )
                : Image.asset(food_image),
          ),
          const SizedBox(height: 20,),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(text: data.name ?? "", sizeOfFont: 18, color: btntxtColor, fontfamilly: montBold,weight: FontWeight.w900,),
              //CustomText(text: "...",sizeOfFont: 18, color: btnbgColor, fontfamilly: montBold),
              Image.asset(three_dot,width: 14,height: 4,)
            ],
          ),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              CustomText(text: data.category ?? "", color: viewallColor, sizeOfFont:17,fontfamilly: montLight),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: CustomText(text:  'Pickup time - ${data.store?.pickupTime?.startTime ?? ""}', sizeOfFont: 11,color: viewallColor, fontfamilly: montLight),
              ),


            ],
          ),

          const SizedBox(height: 3,),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [

                  RatingBar.readOnly(
                    filledIcon: Icons.star,
                    emptyIcon: Icons.star_border,
                    filledColor: btnbgColor,
                    initialRating: 4,
                    size: 20,
                    maxRating: 5,

                  ),
                ],
              ),
              CustomText(text: "84 Km", color: viewallColor, fontfamilly: montLight),
            ],
          ),
          SizedBox(height: 10,),

         /* CommonButton(btnBgColor: onboardingBtn,sizeOfFont: 17, btnTextColor:pickuptColor.withOpacity(0.54),btnText: "PICK UP AT 11 AM", onClick: (){
          }),*/
          CommonButton(btnBgColor: onboardingBtn,sizeOfFont: 17, btnTextColor:pickuptColor,btnText:data.status == 0 ? "PENDING" : "READY FOR PICKUP", onClick: (){
            data.status == 0 ?

            ""



                : DialogHelper.showCommonPopup(navigatorKey.currentContext!,title: "RATE YOUR EXPERIENCE",subtitle: null,isDelete: false);
          }),
          SizedBox(height: 10,),
          CustomText(text: "Order N. #2134445`", color: viewallColor, sizeOfFont:16,fontfamilly: montLight),
           CustomText(text: data.store?.address ?? '', sizeOfFont: 14, color: offerColor, fontfamilly: montBold),
          SizedBox(height: 10,),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(text: "Description...", sizeOfFont: 12, color: graysColor, fontfamilly: montLight),
              CustomText(text: '\$ ${data.price ?? ""}', color: offerColor, sizeOfFont:24,fontfamilly: montHeavy),
            ],
          ),
          viewMore(commonProvider, data),


        ],
      ),
    );
  }

  Widget viewMore(CommonCounter commonCounter,
      CurrentOrderData data) {
    return Consumer<CommonCounter>(builder: (context, commonCounter, child) {
      return commonCounter.isViewMore
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: data.description ?? "",
            fontfamilly: montRegular,
            sizeOfFont: 12,
            color: cardTextColor.withOpacity(0.47),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [

              featureImage(data.allergens ?? ""),
              SizedBox(
                height: 5,
              ),
              CustomText(
                text: data.allergens ?? "",
                fontfamilly: montRegular,
                sizeOfFont: 10,
                color: cardTextColor,
              ),
              // for (var feature in orderAndPayProvider.foodData[0]["features"])
              //   featureImage(feature),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              commonCounter.viewMoreLess("VIEW MORE");
            },
            child: CustomText(
              text: commonCounter.textName,
              color: btnbgColor,
              fontfamilly: montMedium,
              sizeOfFont: 14,
            ),
          ),
        ],
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              commonCounter.viewMoreLess("VIEW LESS");
            },
            child: CustomText(
              text: commonCounter.textName,
              color: btnbgColor,
              fontfamilly: montMedium,
              sizeOfFont: 14,
            ),
          )
        ],
      );
    });
  }

  Widget featureImage(String feature) {
    print('feature = $feature');
    String imagePath = "";

    switch (feature) {
      case "Gluten Free":
        imagePath = gluten_free;
        break;
      case "Soy Free":
        imagePath = soy_free;
        break;
      case "Lactose Free":
        imagePath = lactose_freee;
        break;
      case "Eggs Free":
        imagePath = egg_free;
        break;
      case "Sugar Free":
        imagePath = sugar_freee;
        break;
      case "GMO Free":
        imagePath = gmo_freee;
        break;
      case "Shellfish Free":
        imagePath = shellfish_freee;
        break;
      case "Tree Nuts Free":
        imagePath = treenuts_freee;
        break;
      case "Fish Free":
        imagePath = fish_free;
        break;
      case "Peanuts Free":
        imagePath = peanuts_freee;
        break;
    // Add more cases for other features if needed
    }

    return Image.asset(imagePath, height: 30, width: 30);
  }

}
