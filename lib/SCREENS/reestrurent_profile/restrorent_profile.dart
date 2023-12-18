import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:takeaplate/main.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../MULTI-PROVIDER/common_counter.dart';
import '../../UTILS/app_color.dart';
import '../../UTILS/app_images.dart';
import '../../UTILS/fontfaimlly_string.dart';

class RestrorentProfileScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: bgColor,
     body: SafeArea(
       child: Padding(
         padding: const EdgeInsets.only(top: 0.0,bottom: 20,left:25,right: 25),
         child: Column(
           children: [
             CustomAppBar(),
             getView()
           ],
         ),
       ),
     ),
   );
  }
  Widget getView(){
    return Expanded(
      child: SingleChildScrollView(
        child:  Consumer<CommonCounter>(builder: (context,commonProvider,child){
     return Column(
        children: [
          SizedBox(height: 10,),
          getCards(commonProvider),
          !commonProvider.isDeal ? buildSection("TODAY'S DEALS", ""):buildSection("YOUR FAVOURITES", "") ,
          buildVeerticalCards()
        ],
      );

        }
        ),
    )
    );
  }
  Widget buildSection(String title, String viewAllText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: title, color: editbgColor, fontfamilly: montHeavy,sizeOfFont: 20),
          CustomText(text: viewAllText, color: Colors.black, fontfamilly: montLight, weight: FontWeight.w900),
        ],
      ),
    );
  }
  Widget getCards(CommonCounter commonCounter) {
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset(restrorent_food, fit: BoxFit.contain,
                height: 200,),
              Positioned(
                bottom: -60,
                right: 10,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: imgbgColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 0, color: Colors.grey),

                  ),
                  child:  Center(
                      child: Image.asset(restrorent_img, fit: BoxFit.fill)
                  ),
                ),
              ),

            ],
          ),
          const SizedBox(height: 5,),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: "Salad & Co.", sizeOfFont: 20, color: viewallColor, fontfamilly: montBold,),
              CustomText(text: "Health Foods", color: viewallColor, sizeOfFont:16,fontfamilly: montRegular),
              CustomText(text: "23 Dreamland Av.., Australia", weight : FontWeight.w300, sizeOfFont :11,color: viewallColor, fontfamilly: montLight),

            ],
          ),
          const SizedBox(height: 5,),
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
            ],
          ),
          SizedBox(height: 10,),
          const CustomText(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",  sizeOfFont :10,color: onboardingbgColor, fontfamilly: montBook),
          SizedBox(height: 10,),
          Row(
            children: [
              commonCounter.isDeal ?  Container(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: btnbgColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1, color: Colors.white),
                ),
                child: GestureDetector(
                    onTap: (){
                      commonCounter.gettodayDeal(false);
                    },
                    child: CustomText(text: "Deals",sizeOfFont: 10,fontfamilly:montBook,color: hintColor,)),
              ) :  Container(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: btnbgColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1, color: Colors.white),
                ),
                child: GestureDetector(
                    onTap: (){
                      commonCounter.gettodayDeal(true);
                    },
                    child: CustomText(text: "Deals",sizeOfFont: 10,fontfamilly:montBook,color: hintColor,)),
              ) ,
              SizedBox(width: 8,),
              !commonCounter.isDeal ?  Container(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: btnbgColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1, color: Colors.white),
                ),
                child: GestureDetector(
                    onTap: (){
                      commonCounter.gettodayDeal(true);
                    },
                    child: const CustomText(text: "Deals you loved",sizeOfFont: 10,fontfamilly: montBook,color: hintColor,)),
              ) :  Container(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: btnbgColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1, color: Colors.white),
                ),
                child: GestureDetector(
                    onTap: (){
                      commonCounter.gettodayDeal(false);
                    },
                    child: const CustomText(text: "Deals you loved",sizeOfFont: 10,fontfamilly: montBook,color: hintColor,)),
              )
            ],
          )
        ],
      );
  }

  Widget buildVeerticalCards() {
    return  Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(8, (index) => getFavCards()),
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
          const   Expanded(

            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: "Surprise Pack", maxLin: 1,color: btntxtColor, fontfamilly: montBold,sizeOfFont: 21,),

                CustomText(text: "Salad & Co", maxLin: 1,color: btntxtColor, fontfamilly: montRegular,sizeOfFont: 16,),

                CustomText(text: "Tomorrow-7:35-8:40 Am", maxLin: 1,color: graysColor,sizeOfFont: 11, fontfamilly: montRegular),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Icon(Icons.star_border,size: 20,color:graysColor,),
                    Icon(Icons.star_border,size: 20,color: graysColor),
                    Icon(Icons.star_border,size: 20,color: graysColor,),
                    Icon(Icons.star_border,size: 20,color: graysColor,),
                    Icon(Icons.star_border,size: 20,color: graysColor,),
                    SizedBox(width: 10,),
                    Expanded(child: CustomText(text: "84 Km",maxLin: 1, color: graysColor,sizeOfFont: 15, fontfamilly: montSemiBold)),
                  ],

                ),
                SizedBox(height: 5,),
                CustomText(text: "\$"+"9.99", color: dolorColor,sizeOfFont: 27, fontfamilly: montHeavy,),

              ],
            ),
          ),
          const SizedBox(width: 18,),
          Expanded(
            child: Stack(
              alignment: Alignment.topRight,
              clipBehavior: Clip.none,
              children: [
                Image.asset(food_image, height: 130, width: 130, fit: BoxFit.cover),
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
    );
  }
}