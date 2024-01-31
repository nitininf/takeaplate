import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeaplate/MULTI-PROVIDER/CartOperationProvider.dart';
import 'package:takeaplate/MULTI-PROVIDER/OrderAndPayProvider.dart';
import 'package:takeaplate/MULTI-PROVIDER/common_counter.dart';
import 'package:takeaplate/Response_Model/RestaurantDealResponse.dart';
import '../../CUSTOM_WIDGETS/common_button.dart';
import '../../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../../CUSTOM_WIDGETS/custom_search_field.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../Response_Model/AddToCartResponse.dart';
import '../../UTILS/app_color.dart';
import '../../UTILS/app_images.dart';
import '../../UTILS/app_strings.dart';
import '../../UTILS/fontfamily_string.dart';
import '../../UTILS/request_string.dart';

class OrderAndPayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var commonProvider = Provider.of<CommonCounter>(context, listen: false);
    var orderAndPayProvider = Provider.of<OrderAndPayProvider>(context, listen: false);

    final DealData data = ModalRoute.of(context)!.settings.arguments as DealData;

    var dealId = data.id;
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 22.0, right: 22, bottom: 22, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const CustomAppBar(),
              const SizedBox(height: 23),
              const CustomSearchField(hintText: "Search"),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      buildSection(
                          lastMinute, "", orderAndPayProvider, commonProvider),
                      getCards(
                          context, orderAndPayProvider, commonProvider, data),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: CommonButton(
                          btnBgColor: btnbgColor,
                          btnText: orderAndPay,
                          onClick: () {
                            Navigator.pushNamed(
                                arguments: data,
                                context, '/PaymentDetailsScreen');
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 30, right: 30, bottom: 20),
                        child: CommonButton(
                            btnBgColor: onboardingBtn.withOpacity(1),
                            sizeOfFont: 18,
                            btnTextColor: offerColor.withOpacity(0.5),
                            btnText: "ADD TO CART",
                            onClick: () async {



                              if (dealId !=0 || dealId != null) {


                                try {
                                  var formData = {
                                    RequestString.DEAL_ID: dealId,
                                    RequestString.QUANTITY: 1,
                                  };

                                  AddToCartResponse data =
                                      await Provider.of<CartOperationProvider>(
                                              context,
                                              listen: false)
                                          .addToCartItem(formData);
                                  if (data.status == true &&
                                      data.message ==
                                          "Item added to the cart successfully.") {

                                    final snackBar = SnackBar(
                                      content: Text('${data.message}'),
                                    );

                                    // Show the SnackBar
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);

                                    // Automatically hide the SnackBar after 1 second
                                    Future.delayed(const Duration(milliseconds: 1000),
                                        () {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                    });

                                    // Navigate to the next screen or perform other actions after login
                                  } else {
                                    // Login failed

                                    final snackBar = SnackBar(
                                      content: Text('${data.message}'),
                                    );

                                    // Show the SnackBar
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);

                                    // Automatically hide the SnackBar after 1 second
                                    Future.delayed(const Duration(milliseconds: 1000),
                                        () {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                    });
                                  }
                                } catch (e) {
                                  // Display error message
                                }
                              } else {
                                // Show an error message or handle empty fields
                                final snackBar = SnackBar(
                                  content: const Text('Retry after some time'),
                                  action: SnackBarAction(
                                    label: 'Ok',
                                    onPressed: () {
                                      // Some code to undo the change.
                                    },
                                  ),
                                );

                                // Find the ScaffoldMessenger in the widget tree
                                // and use it to show a SnackBar.
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            }),
                      ),
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

  Widget buildSection(String title, String viewAllText,
      OrderAndPayProvider orderAndPayProvider, CommonCounter commonProvider) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
              text: title,
              color: btnbgColor,
              fontfamilly: montHeavy,
              sizeOfFont: 20),
          CustomText(
              text: viewAllText,
              color: Colors.black,
              fontfamilly: montHeavy,
              weight: FontWeight.w900),
        ],
      ),
    );
  }

  Widget getCards(BuildContext context, OrderAndPayProvider orderAndPayProvider, CommonCounter commonProvider, DealData data) {
    return Consumer<OrderAndPayProvider>(
        builder: ((context, orderAndPayProvider, child) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 0, color: viewallColor),
        ),
        child: Column(
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
                  : Image.asset(restrorent_food),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                    text: data.name ?? "",
                    sizeOfFont: 20,
                    color: viewallColor,
                    fontfamilly: montBold),
                Row(
                  children: [
                    !commonProvider.isViewMore
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: editbgColor,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0),
                                  bottomLeft: Radius.circular(30.0)),
                              border: Border.all(width: 1, color: Colors.white),
                            ),
                            child: const CustomText(
                              text: "Report",
                              color: hintColor,
                              fontfamilly: montLight,
                              sizeOfFont: 11,
                            ))
                        : const Text(" "),
                    const SizedBox(width: 5,),
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0, top: 20),
                      child: Image.asset(
                        three_dot,
                        width: 14,
                        height: 4,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                    text: data.category ?? "",
                    color: viewallColor,
                    sizeOfFont: 16,
                    fontfamilly: montLight),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: CustomText(
                      text:
                          'Pickup time - ${data.store?.pickupTime?.startTime ?? ""}',
                      sizeOfFont: 11,
                      color: viewallColor,
                      fontfamilly: montLight),
                ),
              ],
            ),
            const SizedBox(
              height: 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    RatingBar.readOnly(
                      filledIcon: Icons.star,
                      emptyIcon: Icons.star_border,
                      filledColor: btnbgColor,
                      halfFilledIcon: Icons.star_half,
                      isHalfAllowed: true,
                      halfFilledColor: btnbgColor,
                      initialRating: double.parse(data.averageRating ?? '2'),
                      size: 20,
                      maxRating: 5,
                    ),
                  ],
                ),
                CustomText(
                  text: orderAndPayProvider.foodData[0]["distance"],
                  color: editbgColor,
                  fontfamilly: montMedium,
                  sizeOfFont: 17,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            CustomText(
              text: data.store?.address ?? "",
              color: viewallColor,
              fontfamilly: montLight,
              sizeOfFont: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  text: "Description...",
                  color: viewallColor,
                  fontfamilly: montLight,
                  sizeOfFont: 12,
                ),
                CustomText(
                    text: '\$ ${data.price ?? ""}',
                    color: offerColor,
                    sizeOfFont: 27,
                    fontfamilly: montHeavy),
              ],
            ),

            viewMore(commonProvider, orderAndPayProvider, data),
            // SizedBox(
            //   height: 10,
            // ),
          ],
        ),
      );
    }));
  }

  Widget viewMore(CommonCounter commonCounter,
      OrderAndPayProvider orderAndPayProvider, DealData data) {
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
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [

                    featureImage(data.allergens ?? ""),
                    const SizedBox(
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
                const SizedBox(
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
