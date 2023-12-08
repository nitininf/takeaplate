import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/fontfaimlly_string.dart';

class FaqScreenScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(),
            SizedBox(height: 10,),
            GestureDetector(child: CustomText(text: "FAQ'S",color: editbgColor,sizeOfFont: 20,weight: FontWeight.w900,),
            onTap: (){
            //  Navigator.pushNamed(context, '/SettingScreen');
            },),
            SizedBox(height: 10,),
            buildVeerticalCards()
          ],
        ),
      ),
    ));
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      decoration: BoxDecoration(
        color: colorbg !=null ? faqSelectedColor : hintColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 0, color: Colors.grey),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0,),
            child: CustomText(text: "How do  I know when the best deals are available? ",color: colorbg,sizeOfFont: 18,fontfamilly: montBold,weight: FontWeight.w600,),
          ),
          getSubTitle(colorbg: colorbg)

        ],
      ),
    );
  }

  Widget getSubTitle({Color? colorbg,}){
    return colorbg != null ?  Padding(
      padding: const EdgeInsets.only(bottom: 15.0,top: 10),
      child: CustomText(text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation, Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation Lorem ipsum dolor sit amet, consectetur",color: btntxtColor,sizeOfFont: 13,fontfamilly: montBold,weight: FontWeight.w400,),
    ) : Text("");
  }
}