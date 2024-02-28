import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:take_a_plate/CUSTOM_WIDGETS/common_button.dart';
import 'package:take_a_plate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:take_a_plate/UTILS/app_color.dart';
import 'package:take_a_plate/UTILS/app_images.dart';
import 'package:take_a_plate/UTILS/dialog_helper.dart';
import 'package:take_a_plate/UTILS/fontfamily_string.dart';
import 'package:take_a_plate/main.dart';
import '../../../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../../MULTI-PROVIDER/RestaurantsListProvider.dart';
import '../../MULTI-PROVIDER/common_counter.dart';
import '../../Response_Model/CurrentOrderResponse.dart';
import '../../Response_Model/ProfilePageResponse.dart';
import '../../Response_Model/RateDealResponse.dart';
import '../../UTILS/app_strings.dart';
import '../../UTILS/request_string.dart';
class YourOrderScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final CurrentDeal data = ModalRoute.of(context)!.settings.arguments as CurrentDeal;
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
                      getCards(data,commonProvider,context),
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

  Widget getCards(CurrentDeal data, CommonCounter commonProvider, BuildContext context) {
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
              CustomText(text: data.category ?? "", color: viewallColor, sizeOfFont:14,fontfamilly: montLight),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: CustomText(text:  'Pickup time: \n${data.store?.pickupTime?.startTime ?? ""}', sizeOfFont: 11,color: viewallColor, fontfamilly: montLight),
              ),


            ],
          ),

          const SizedBox(height: 3,),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [

                  RatingBar.readOnly(
                    filledIcon: Icons.star,
                    emptyIcon: Icons.star_border,
                    filledColor: btnbgColor,
                    initialRating: double.parse(data.averageRating ?? '0'),
                    size: 20,
                    maxRating: 5,

                  ),
                ],
              ),
              CustomText(text: '${data.store?.distanceKm} Km' ?? "NA", color: viewallColor, fontfamilly: montLight),
            ],
          ),
          SizedBox(height: 10,),

         /* CommonButton(btnBgColor: onboardingBtn,sizeOfFont: 17, btnTextColor:pickuptColor.withOpacity(0.54),btnText: "PICK UP AT 11 AM", onClick: (){
          }),*/
          CommonButton(btnBgColor: onboardingBtn,sizeOfFont: 17, btnTextColor:pickuptColor,btnText:data.status == 0 ? "PENDING" : "READY FOR PICKUP", onClick: (){
            data.status == 0 ?"": showCommonPopup(context,data.id??0,title: "RATE YOUR EXPERIENCE");
          }),
          SizedBox(height: 10,),
          CustomText(text: 'Order No.: ${data.paymentId} ', color: viewallColor, sizeOfFont:14,fontfamilly: montLight),
          SizedBox(height: 10,),

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
      CurrentDeal data) {
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

              getAllergenes(data)

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
      case "Shelfish Free":
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

  static Future<void> showCommonPopup(BuildContext context , int id, {required String title}) async {

     double screenHeight =
        MediaQuery.of(navigatorKey.currentContext!).size.height;
     double screenWidth =
        MediaQuery.of(navigatorKey.currentContext!).size.width;



     showDialog(
       context: context,
       useSafeArea: false,
       useRootNavigator: false,
       barrierDismissible: false,
       builder: (BuildContext context) {
         double _rating = 4; // Variable to store the rating value
         return Dialog.fullscreen(
           backgroundColor: Colors.transparent,
           child: Stack(
             children: [
               Container(
                 color: dailogColor.withOpacity(0.75),
                 height: double.infinity,
                 width: double.infinity,
               ),
               Column(
                 children: <Widget>[
                   SizedBox(
                     height: screenHeight * 0.16,
                   ),
                   Padding(
                     padding: const EdgeInsets.only(
                         left: 0.0, right: 0.0, top: 30.0, bottom: 10),
                     child: Container(
                       margin: const EdgeInsets.symmetric(
                           horizontal: 40, vertical: 40),
                       padding: const EdgeInsets.symmetric(
                           horizontal: 16, vertical: 12),
                       decoration: BoxDecoration(
                           color: onboardingbgColor,
                           borderRadius: BorderRadius.circular(16),
                           border: Border.all(width: 1, color: hintColor)),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           SizedBox(
                             height: screenHeight * 0.03,
                           ),
                           Image.asset(
                             appLogo,
                             height: 100,
                             width: 100,
                           ),
                           const SizedBox(
                             height: 20,
                           ),
                           Align(
                             alignment: Alignment.center,
                             child: CustomText(
                               text: title ?? "",
                               sizeOfFont: 21,
                               color: hintColor,
                               fontfamilly: montHeavy,
                               isAlign: true,
                             ),
                           ),
                           const SizedBox(
                             height: 20,
                           ),
                           // Rating bar
                           RatingBar(
                             filledIcon: Icons.star,
                             emptyIcon: Icons.star_border,
                             onRatingChanged: (value) => _rating = value,
                             initialRating: _rating,
                             halfFilledIcon: Icons.star_half,
                             isHalfAllowed: true,
                             halfFilledColor: btnbgColor,
                             alignment: Alignment.center,
                             emptyColor: btnbgColor,
                             filledColor: btnbgColor,
                             maxRating: 5,
                           ),
                           SizedBox(
                             height: screenHeight * 0.05,
                           ),
                           Padding(
                             padding: const EdgeInsets.only(
                                 left: 15.0,
                                 right: 15,
                                 top: 6,
                                 bottom: 20),
                             child: CommonButton(
                                 btnBgColor: onboardingBtn,
                                 btnText: "RATE",
                                 onClick: () async {
                                   // Use the rating value here
                                   print('Rating: $_rating');

                                   try {

                                     var formData = {
                                       RequestString.DEAL_ID: id,
                                       RequestString.RATING: _rating,

                                     };


                                     RateDealResponse data = await Provider.of<RestaurantsListProvider>(
                                         context,
                                         listen: false)
                                         .rateDeal(formData);

                                     if (data.status == true) {

                                       Navigator.pop(context);

                                       final snackBar = SnackBar(
                                         content: Text(
                                             data.message ?? ""),
                                       );

// Show the SnackBar
                                       ScaffoldMessenger.of(context)
                                           .showSnackBar(snackBar);

// Automatically hide the SnackBar after 1 second
                                       Future.delayed(Duration(milliseconds: 500), () {
                                         ScaffoldMessenger.of(context)
                                             .hideCurrentSnackBar();
                                       });

                                       // Navigate to the next screen or perform other actions after login
                                     } else {
                                       // Login failed

                                       Navigator.pop(context);
                                       print("Something went wrong: ${data.message}");
                                     }
                                   } catch (e) {
                                     // Display error message
                                     print("Error: $e");
                                   }



                                 }),
                           ),
                           SizedBox(
                             height: 10,
                           )
                         ],
                       ),
                     ),
                   ),
                 ],
               ),
             ],
           ),
         );
       },
     );

  }

  Widget getAllergenes(CurrentDeal data) {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 10,
      children: [
        for (var allergen in data.allergens ?? [])
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              featureImage(allergen.title ?? ""), // Assuming featureImage expects a String
              const SizedBox(
                height: 5,
              ),
              CustomText(
                text: allergen.title ?? "", // Assuming CustomText expects a String
                fontfamilly: montRegular,
                sizeOfFont: 10,
                color: cardTextColor,
              ),
            ],
          ),
      ],
    );
  }


}
