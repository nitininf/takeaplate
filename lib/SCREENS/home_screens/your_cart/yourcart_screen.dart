import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_button.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/main.dart';

import '../../../MULTI-PROVIDER/CartOperationProvider.dart';
import '../../../UTILS/app_images.dart';
import '../../../UTILS/fontfaimlly_string.dart';

class YourCardScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
   return  Scaffold(
   backgroundColor: bgColor,
     body: Padding(
       padding: const EdgeInsets.only(right: 35.0,left: 35,bottom: 0,top: 5),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
            getView(screenHeight,context)
         ],
       ),
     )

   );
  }


  Widget getView(double screenHeight, BuildContext context) {
    CartOperationProvider cartProvider = Provider.of<CartOperationProvider>(context);

    // Assuming you have the price for each item, adjust this based on your actual data
    double itemPrice = 9.99;

    // Calculate total price for all items in the cart
    double totalPrice = 0.0;
    for (int i = 0; i < 3; i++) {
      totalPrice += cartProvider.getCount(i) * itemPrice;
    }

    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 18,),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: const CustomText(text: "YOUR CART", color: editbgColor, sizeOfFont: 20, fontfamilly: montHeavy,),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(width: 1, color: grayColor)),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  for (int i = 0; i < 3; i++)
                    getCardViews(context, i),
                  SizedBox(height: screenHeight * 0.120),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                    decoration: BoxDecoration(
                      color: onboardingBtn.withOpacity(0.20),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(width: 0, color: grayColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(text: "Total", color: btntxtColor, sizeOfFont: 21, fontfamilly: montBold,),
                          CustomText(text: "\$${totalPrice.toStringAsFixed(2)}", color: offerColor, sizeOfFont: 28, fontfamilly: montHeavy,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0, right: 30, left: 30),
              child: CommonButton(btnBgColor: btnbgColor, sizeOfFont: 18, btnText: "GO TO CHECKOUT", onClick: () {


                  print("Total Price: \$${totalPrice.toStringAsFixed(2)}");


                Navigator.pushNamed(navigatorKey.currentContext!, '/OrderSummeryScreen');
              }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 30, right: 30, bottom: 20),
              child: CommonButton(btnBgColor: onboardingBtn.withOpacity(1), sizeOfFont: 18, btnTextColor: offerColor.withOpacity(0.5), btnText: "ADD MORE ITEMS", onClick: () {}),
            ),
          ],
        ),
      ),
    );
  }




  Widget getCardViews(BuildContext context, int index) {
    CartOperationProvider cartProvider = Provider.of<CartOperationProvider>(context);

    // Assuming you have the price for each item, adjust this based on your actual data
    double itemPrice = 9.99;

      return Padding(
        padding: const EdgeInsets.only(right: 10.0, left: 10, top: 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(food_image, height: 40, width: 40, fit: BoxFit.cover),
                SizedBox(width: 8,),
                const Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "Surprise Pack",
                        maxLin: 1,
                        color: btntxtColor,
                        fontfamilly: montBold,
                        sizeOfFont: 15,
                      ),
                      CustomText(
                        text: "Salad & Co",
                        maxLin: 1,
                        color: btntxtColor,
                        fontfamilly: montRegular,
                        sizeOfFont: 11,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8,),
                Expanded(
                  flex: 0,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                    decoration: BoxDecoration(
                      color: btnbgColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(width: 1, color: Colors.white),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Check if the count is greater than 0 before decrementing
                            if (cartProvider.getCount(index) > 0) {
                              Provider.of<CartOperationProvider>(context, listen: false)
                                  .decrementCount(index);

                              // If count becomes 0, remove the item from the cart
                              if (cartProvider.getCount(index) == 1) {
                                // Remove the item at the specified index
                                cartProvider.removeFromCart(index);
                              }
                            }
                          },
                          child: Image.asset(delete_icon, height: 9, width: 9,),
                        ),
                        SizedBox(width: 8,),
                        Consumer<CartOperationProvider>(
                          builder: (context, cartProvider, _) {
                            return CustomText(
                              text: cartProvider.getCount(index).toString(),
                              sizeOfFont: 12,
                              color: hintColor,
                            );
                          },
                        ),
                        SizedBox(width: 8,),
                        GestureDetector(
                          onTap: () {
                            Provider.of<CartOperationProvider>(context, listen: false)
                                .incrementCount(index);
                          },
                          child: Icon(Icons.add, color: hintColor, size: 12,),
                        ),
                      ],
                    ),
                  ),
                ),
                CustomText(
                  // Calculate the total price based on the count and item price
                  text: "\$${(cartProvider.getCount(index) * itemPrice).toStringAsFixed(2)}",
                  sizeOfFont: 15,
                  color: offerColor,
                  fontfamilly: montHeavy,
                ),
              ],
            ),
            SizedBox(height: 5,),
            Divider(color: grayColor, thickness: 0,)
          ],
        ),
      );

  }

}