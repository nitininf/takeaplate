import 'package:flutter/material.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_button.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/app_images.dart';
import 'package:takeaplate/UTILS/app_strings.dart';
import 'package:takeaplate/UTILS/dialog_helper.dart';
import 'package:takeaplate/UTILS/fontfaimlly_string.dart';
import 'package:takeaplate/main.dart';
import '../../../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../../../CUSTOM_WIDGETS/custom_search_field.dart';
class YourOrderScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
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
                      buildSection("YOUR ORDER", ""),
                      getCards(),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: title, color: btnbgColor, fontfamilly: montHeavy,sizeOfFont: 20),
          CustomText(text: viewAllText, color: Colors.black, fontfamilly: montLight, weight: FontWeight.w900),
        ],
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
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 280,
              width: 280,
              child: Image.asset(food_image, height: 275,width: 275, fit: BoxFit.fill)),
          const SizedBox(height: 20,),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(text: "Surprise Pack", sizeOfFont: 18, color: btntxtColor, fontfamilly: montBold,weight: FontWeight.w900,),
              CustomText(text: "...",sizeOfFont: 18, color: btnbgColor, fontfamilly: montBold),
            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              CustomText(text: "Health Foods", color: viewallColor, sizeOfFont:17,fontfamilly: montLight),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: CustomText(text: "Pick up Time:11:00 am", sizeOfFont: 11,color: viewallColor, fontfamilly: montLight),
              ),
            ],
          ),

          const SizedBox(height: 3,),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.star,size: 20,color: btnbgColor,),
                  Icon(Icons.star,size: 20,color: btnbgColor,),
                  Icon(Icons.star,size: 20,color: btnbgColor,),
                  Icon(Icons.star,size: 20,color: btnbgColor,),
                  Icon(Icons.star,size: 20,color: btnbgColor,),
                ],
              ),
              CustomText(text: "84 Km", color: viewallColor, fontfamilly: montLight),
            ],
          ),
          SizedBox(height: 10,),

          CommonButton(btnBgColor: onboardingBtn, btnTextColor:pickuptColor,btnText: "PICK UP AT 11 AM", onClick: (){
          //  DialogHelper.showCommonPopup(navigatorKey.currentContext!,title: "RATE YOUR EXPERIENCE");
           // Navigator.pushNamed(navigatorKey.currentContext!, '/ClosestScreen');
          }),

          SizedBox(height: 10,),
          CustomText(text: "Order N. #2134445`", color: viewallColor, sizeOfFont:16,fontfamilly: montLight),
          const CustomText(text: "23 Dreamland Av.., Australia", sizeOfFont: 14, color: viewallColor, fontfamilly: montBold),
          SizedBox(height: 10,),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(text: "Description...", sizeOfFont: 12, color: graysColor, fontfamilly: montLight),
              CustomText(text: "\$ 9.99", color: offerColor, sizeOfFont:24,fontfamilly: montHeavy),
            ],
          ),
          SizedBox(height: 10,),

        ],
      ),
    );
  }

}
