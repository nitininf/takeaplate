import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_button.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/main.dart';

import '../../../UTILS/app_images.dart';
import '../../../UTILS/fontfaimlly_string.dart';
import '../../UTILS/dialog_helper.dart';

class OrderSummeryScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return  Scaffold(
      backgroundColor: bgColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(right: 25.0,left: 25,bottom: 0,top: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppBar(),
                SizedBox(height: 10,),
                getView(screenHeight)
              ],
            ),
          ),
        )
    
    );
  }


  Widget getView(double screenHeight){
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15,),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: "ORDER SUMMARY",color: editbgColor,sizeOfFont: 20,fontfamilly: montHeavy,),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: editprofilbgColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1, color: Colors.white),
                  ),
                  child: const CustomText(text: "ADD MORE",sizeOfFont: 10,weight: FontWeight.w800,color: editprofileColor,),
                )
              ],
            ),
            const SizedBox(height: 15,),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(width: 1, color: grayColor)),
              child:Column(
                children: [
                  const SizedBox(height: 10,),
                  for(int i=0;i<4;i++)
                    getCardViews(),
                  SizedBox(height: screenHeight*0.040),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                    decoration: BoxDecoration(
                        color: onboardingBtn.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(width: 0, color: grayColor)

                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 8.0,right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(text: "Total",color: viewallColor,sizeOfFont: 21,fontfamilly: montBold,),
                          CustomText(text: "\$39.99",color: offerColor,sizeOfFont: 21,fontfamilly: montBold,),


                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ) ,

            const SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: "PAYMENT METHOD",color: editbgColor,sizeOfFont: 21,fontfamilly: montBold,),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: editprofilbgColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1, color: Colors.white),
                  ),
                  child: GestureDetector(child: const CustomText(text: "ADD NEW",sizeOfFont: 10,weight: FontWeight.w800,color: editprofileColor,),
                  onTap: (){
                    DialogHelper.addCardDialoge(navigatorKey.currentContext!);
                  },),
                )
              ],
            ),
            SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                  color: hintColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 0, color: grayColor),


              ),
              child: Column(
                children: [
                  getMasterCard(mastercardColor,"-2211"),
                  getMasterCard(hintColor,"-4251"),
                ],
              )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0,right: 33,left: 33,bottom: 20),
              child: CommonButton(btnBgColor: btnbgColor, btnText: "ORDER & PAY", onClick: (){
                DialogHelper.showCommonPopup(navigatorKey.currentContext!,title: "YOUR PAYMENT WAS SUCCESSFULL",subtitle: "YOU WILL GET A NOTIFICATION WHEN THE ORDER IS CONFIRMED");
              }),
            ),

          ],),
      ),
    );
  }

  Widget getMasterCard(Color colorbg,String payment){
    return Container(
       margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 0),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: colorbg,
        borderRadius: BorderRadius.circular(20),
        border: null,
      ),
      child:  Row(
        children: [
          Image.asset(master_card,fit: BoxFit.contain,height: 40,width: 70,),
          SizedBox(width: 10,),
          Expanded(child: CustomText(text: "MasterCard",color: viewallColor,sizeOfFont: 14,fontfamilly: montBold,)),
          CustomText(text: payment,color: viewallColor,sizeOfFont: 14,fontfamilly: montRegular,),
        ],
      ),
    );
  }

  Widget getCardViews() {
    return  Padding(
      padding: const EdgeInsets.only(right: 10.0,left: 10,top: 10),
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
                    CustomText(text: "Surprise Pack", maxLin:1,color: btntxtColor, fontfamilly: montBold,sizeOfFont: 15,),

                    CustomText(text: "Salad & Co", maxLin:1,color: btntxtColor, fontfamilly: montRegular,sizeOfFont: 11,),

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
                      border: Border.all(width: 1, color: Colors.white)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(delete_icon,height: 9,width: 9,),
                      SizedBox(width: 8,),
                      CustomText(text: "1",sizeOfFont: 12,color: hintColor,),
                      SizedBox(width: 8,),
                      Icon(Icons.add,color: hintColor,size: 12,),
                    ],
                  ) ,
                ),
              ),

              CustomText(text: "\$9.99",sizeOfFont: 15,color: offerColor,fontfamilly: montHeavy,)
            ],
          ),
          SizedBox(height: 5,),
          Divider(color: grayColor,thickness: 0,)
        ],
      ),
    );
  }
}