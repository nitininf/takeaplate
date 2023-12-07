import 'package:flutter/material.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_button.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/app_images.dart';
import 'package:takeaplate/UTILS/app_strings.dart';
import 'package:takeaplate/UTILS/fontfaimlly_string.dart';
import '../../CUSTOM_WIDGETS/common_edit_text.dart';
import '../../CUSTOM_WIDGETS/common_email_field.dart';
import '../../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../../CUSTOM_WIDGETS/custom_search_field.dart';
class PaymentDetailsScreen extends StatelessWidget {


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
                      SizedBox(height: 20,),
                      getFavCards(),
                      buildSection(total, "\$9.90"),
                      const SizedBox(height: 20,),
                      paymentDetails(),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0,right: 30,bottom: 20),
                        child: CommonButton(btnBgColor: btnbgColor, btnText: orderandpay, onClick: (){
                          //Navigator.pushNamed(context, '/RestrurentScreen');
                        }),
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


  Widget buildSection(String title, String viewAllText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 0, color: Colors.grey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(text: title, color: btntxtColor, fontfamilly: montBold, weight: FontWeight.w900, sizeOfFont: 18),
            CustomText(text: viewAllText, color: dolorColor,sizeOfFont: 18, fontfamilly: montLight, weight: FontWeight.w900),
          ],
        ),
      ),
    );
  }


  Widget paymentDetails() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 0, color: Colors.grey),
        ),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          CustomText(text: paymentdetails,color: btntxtColor,weight: FontWeight.w900,fontfamilly: montBold,sizeOfFont: 20,),
            SizedBox(height: 25,),
            CommonEditText(hintText: cardName,isbgColor: true,),
            const SizedBox(height: 20,),
            CommonEditText(hintText: cardNum,isbgColor: true,),
            const SizedBox(height: 20,),
            Row(
              children: [
                Expanded(child: CommonEditText(hintText: expiry,isbgColor: true,)),
                SizedBox(width: 10,),
                Expanded(child: CommonEditText(hintText: cvv,isbgColor: true,)),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                decoration: BoxDecoration(
                  color: onboardingBtn,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(width: 1, color: Colors.white),
                ),
                child: CustomText(text: "SAVE", color: btntxtColor, fontfamilly: montBook,weight: FontWeight.w900,)),
            ),
          ],
        )
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
              CustomText(text: "\$"+"9.99", color: dolorColor,sizeOfFont: 24, fontfamilly: montBold,weight: FontWeight.w900,),

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
