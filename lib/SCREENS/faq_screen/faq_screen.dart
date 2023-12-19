import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/fontfaimlly_string.dart';

class FaqScreenScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0,right: 20,left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(),
              SizedBox(height: 10,),
              GestureDetector(child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: CustomText(text: "FAQ'S",color: editbgColor,sizeOfFont: 20,fontfamilly: montHeavy,),
              ),
              onTap: (){
              //  Navigator.pushNamed(context, '/SettingScreen');
              },),
              SizedBox(height: 10,),
              buildVeerticalCards()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildVeerticalCards() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(4, (index) =>index ==0 ? getView(colorbg: btnbgColor) : getView()  ),
        ),
      ),
    );
  }
  Widget getView({Color? colorbg,}){
    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        decoration: BoxDecoration(
          color: colorbg !=null ? faqSelectedColor : hintColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 0, color: editbgColor.withOpacity(0.24)),

        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0,),
              child: CustomText(text: "How do I know when the best deals are available? ",color: colorbg==null ? editbgColor :colorbg,sizeOfFont: 17,fontfamilly: colorbg==null ? montRegular : montBold,),
            ),
            getSubTitle(colorbg: colorbg)

          ],
        ),
      ),
    );
  }

  Widget getSubTitle({Color? colorbg,}){
    return colorbg != null ?  Padding(
      padding: const EdgeInsets.only(bottom: 15.0,top: 10),
      child: CustomText(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation, Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation Lorem ipsum dolor sit amet, consectetur",color: btntxtColor,sizeOfFont: 14,fontfamilly: montRegular,weight: FontWeight.w400,),
    ) : Text("");
  }
}