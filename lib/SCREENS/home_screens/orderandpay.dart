import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_button.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/MULTI-PROVIDER/common_counter.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/app_images.dart';
import 'package:takeaplate/UTILS/app_strings.dart';
import 'package:takeaplate/UTILS/fontfaimlly_string.dart';
import 'package:takeaplate/main.dart';
import '../../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../../CUSTOM_WIDGETS/custom_search_field.dart';
class OrderAndPayScreen extends StatelessWidget {
  var counterProvider=Provider.of<CommonCounter>(navigatorKey.currentContext!, listen: false);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(25.0),
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
                      buildSection(lastminute, ""),
                     getCards(context),
                     const SizedBox(height: 10,),
                      Padding(
                        padding: EdgeInsets.only(left: 30,right: 30),
                        child: CommonButton(btnBgColor: btnbgColor, btnText: orderandpay, onClick: (){
                          Navigator.pushNamed(context, '/PaymentDetailsScreen');
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
      padding: const EdgeInsets.only(bottom: 8.0,left: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: title, color: btnbgColor, fontfamilly: montHeavy, sizeOfFont: 20),
          CustomText(text: viewAllText, color: Colors.black, fontfamilly: montHeavy, weight: FontWeight.w900),
        ],
      ),
    );
  }

  Widget getCards(BuildContext context) {
    return
      Consumer<CommonCounter>(builder: ((context,commonProvider,child){
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
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(text: "Surprise Pack", sizeOfFont: 20, color: viewallColor, fontfamilly: montBold),
              Row(
                children: [
                  !commonProvider.isViewMore ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: editbgColor,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0),bottomLeft: Radius.circular(30.0)),
                        border: Border.all(width: 1, color: Colors.white),
                      ),
                      child: CustomText(text: "Report", color: hintColor, fontfamilly: montLight,sizeOfFont: 11,)
                  ) :Text(""),
                  CustomText(text: "...",sizeOfFont: 18, color: btnbgColor, fontfamilly: montBold),
                ],
              )

            ],
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              CustomText(text: "Health Foods", color: viewallColor, sizeOfFont:16,fontfamilly: montLight),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: CustomText(text: "Pick up Time:11:00 am", sizeOfFont: 11,color: viewallColor,  fontfamilly: montLight),
              ),
            ],
          ),

          SizedBox(height: 10,),
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
              CustomText(text: "84 Km", color: viewallColor,  fontfamilly: montLight,sizeOfFont: 11,),
            ],
          ),
          SizedBox(height: 10,),
          const CustomText(text: "23 Dreamland Av.., Australia",  color: viewallColor, fontfamilly: montLight,sizeOfFont: 12,),
          SizedBox(height: 10,),

          SizedBox(height: 10,),
          viewMore(commonProvider)

          ],
        ),);
      }
      )

      );

  }


  Widget viewMore(CommonCounter commonCounter){
    return
      commonCounter.isViewMore ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
     CustomText(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation \n\n-Lorem ipsum dolor \n -sit amet, consectetur \n -adipiscing elit, sed do \n -eusmod tempor \n -incididunt ut",fontfamilly: montRegular,sizeOfFont: 12,color: viewallColor,),
        SizedBox(height: 10,),
        Row(
          children: [
            Image.asset(gluten_free,height: 30,width: 30,),
            Image.asset(soy_free,height: 30,width: 30,),
            Image.asset(location_freee,height: 30,width: 30,),
          ],
        ),
        SizedBox(height: 20,),
        GestureDetector(
          onTap: (){
          commonCounter.viewMoreLess("VIEW MORE");
          },
            child: CustomText(text: commonCounter.textName, color: btnbgColor, fontfamilly: montLight,sizeOfFont: 14,)),
      ],
    ) :   Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(text: "Description...",  color: viewallColor, fontfamilly: montLight,sizeOfFont: 12,),
              CustomText(text: "\$ 9.99", color: editbgColor, sizeOfFont:27,fontfamilly: montHeavy),
            ],
          ),
        GestureDetector(
          onTap: (){
            commonCounter.viewMoreLess("VIEW LESS");
          },
            child: CustomText(text: commonCounter.textName,  color: btnbgColor, fontfamilly: montLight,sizeOfFont: 14,))
      ],
    );
  }
}
