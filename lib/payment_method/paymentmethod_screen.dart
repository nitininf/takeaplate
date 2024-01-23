import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_button.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:takeaplate/MULTI-PROVIDER/common_counter.dart';
import 'package:takeaplate/UTILS/dialog_helper.dart';
import 'package:takeaplate/UTILS/fontfaimlly_string.dart';
import 'package:takeaplate/main.dart';

import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../UTILS/app_color.dart';
import '../UTILS/app_images.dart';

class PaymentMethodScreen extends StatelessWidget {

  //var counterProvider=Provider.of<CommonCounter>(navigatorKey.currentContext!, listen: false);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0,right: 25,top: 0,bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             getView(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CommonButton(btnText: "ADD NEW",btnBgColor: btnbgColor,btnTextColor: btntxtColor,onClick: (){
                 // Navigator.pushNamed(context, '/RestrorentProfileScreen');
                  DialogHelper.addCardDialog(context);
                },),
              ),
            
            ],
          ),
        ),
      ),
    
    
    );
  }

  Widget getView(){
    return   Consumer<CommonCounter>(builder: (context,commonProvider,child)
    {
      return
        Column(children: [
        const SizedBox(height: 10,),
        const CustomAppBar(),
        const SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomText(text: "PAYMENT METHOD",color: editbgColor,sizeOfFont: 20,fontfamilly: montHeavy,),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: editprofilbgColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1, color: Colors.white),
              ),
              child: GestureDetector(
                  onTap: (){
                    if(commonProvider.isSaved){
                      commonProvider.updateView("SAVE");
                    }else{
                      commonProvider.updateView("EDIT");
                    }
                  },
                  child:  CustomText(text: commonProvider.btnName,sizeOfFont: 10,fontfamilly:montBold,color: editprofileColor,)),
            )
          ],
        ),
        const  SizedBox(height: 17,),
        Container(
            decoration: BoxDecoration(
              color: hintColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 0, color: grayColor),


            ),
            child: Column(
              children: List.generate(5, (index) => index==0 ? getMasterCard(colorbg:offerColor.withOpacity(0.50), commonCounter:commonProvider) : getMasterCard(colorbg:hintColor, commonCounter:commonProvider)  )

            )
        ),

      ],);
    }
    );

  }
  Widget getMasterCard({Color? colorbg,CommonCounter? commonCounter}){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: colorbg,
        borderRadius: BorderRadius.circular(20),
        border: null,
      ),
      child:  Row(
        children: [
          Image.asset(master_card,fit: BoxFit.contain,height: 30,width: 60,),
          const SizedBox(width: 10,),
          const Expanded(child: CustomText(text: "MasterCard",color: viewallColor,sizeOfFont: 15,fontfamilly: montBold,)),
          const CustomText(text: "-2211",color: viewallColor,sizeOfFont: 15,fontfamilly: montRegular,),
          getUpdatedView(commonCounter!)
        ],
      ),
    );
  }
  Widget getUpdatedView(CommonCounter commonCounter){
    return !commonCounter.isSaved ? GestureDetector(
      onTap: (){
        DialogHelper.showCommonPopup(navigatorKey.currentContext!,title: "ARE YOU SURE YOU WANT TO DELETE THIS CARD?",isDelete: true);
      },
      child:  Padding(
        padding: EdgeInsets.all(7.0),
        child: Image.asset(cross,width: 8,height: 8,),
      ),
    ) : const Text("");
  }
}