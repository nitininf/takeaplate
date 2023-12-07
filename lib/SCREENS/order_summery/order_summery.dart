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
    return  SafeArea(child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(right: 20.0,left: 20,bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(),
              getView(screenHeight)
            ],
          ),
        )

    ),
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
                CustomText(text: "ORDER SUMMARY",color: editbgColor,sizeOfFont: 18,weight: FontWeight.w800,),
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
                        color: editprofilbgColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(width: 0, color: grayColor)

                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 8.0,right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(text: "Total",color: btntxtColor,sizeOfFont: 14,weight: FontWeight.w800,),
                          CustomText(text: "\$39.99",color: dolorColor,sizeOfFont: 18,weight: FontWeight.w800,),


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
                CustomText(text: "PAYMENT METHOD",color: editbgColor,sizeOfFont: 18,weight: FontWeight.w800,),
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
                  getMasterCard(mastercardColor),
                  getMasterCard(hintColor),
                ],
              )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0,right: 33,left: 33,bottom: 20),
              child: CommonButton(btnBgColor: btnbgColor, btnText: "ORDER & PAY", onClick: (){
                DialogHelper.showCommonPopup(navigatorKey.currentContext!,title: "YOUR PAYMENT WAS SUCCESSULL",subtitle: "YOU WILL GET A NOTIFICATION WHEN THE ORDER IS CONFIIRMED");
              }),
            ),

          ],),
      ),
    );
  }

  Widget getMasterCard(Color colorbg){
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
          Expanded(child: CustomText(text: "MasterCard",color: btntxtColor,sizeOfFont: 14,weight: FontWeight.w700,)),
          CustomText(text: "-2211",color: btntxtColor,sizeOfFont: 14,weight: FontWeight.w600,),
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
                    CustomText(text: "Surprise Pack", color: btntxtColor, fontfamilly: montitalic,sizeOfFont: 12,),

                    CustomText(text: "Salad & Co", color: btntxtColor, fontfamilly: montBold,weight: FontWeight.w400,sizeOfFont: 10,),

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
                  child:const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.delete,color: hintColor,size: 12,),
                      SizedBox(width: 8,),
                      CustomText(text: "1",sizeOfFont: 12,color: hintColor,),
                      SizedBox(width: 8,),
                      Icon(Icons.add,color: hintColor,size: 12,),
                    ],
                  ) ,
                ),
              ),
              CustomText(text: "\$9.99",sizeOfFont: 12,color: dolorColor,weight: FontWeight.w800,)
            ],
          ),
          Divider(color: grayColor,thickness: 0,)
        ],
      ),
    );
  }
}