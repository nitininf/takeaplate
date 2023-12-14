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
import '../../UTILS/validation.dart';
class PaymentDetailsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding:  EdgeInsets.only(left: 4.0,right: 8),
                child: CustomAppBar(),
              ),
              const SizedBox(height: 23),
              const CustomSearchField(hintText: "Search"),
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
            CustomText(text: title, color: viewallColor, fontfamilly: montBold,  sizeOfFont: 21),
            CustomText(text: viewAllText, color: dolorColor,sizeOfFont: 26, fontfamilly: montHeavy, ),
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
          CustomText(text: paymentdetails,color: viewallColor,fontfamilly: montBold,sizeOfFont: 19,),
            SizedBox(height: 25,),
           // CommonEditText(hintText: cardName,isbgColor: true,),
            Container(
                height: 49,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: grayColor,
                    width: 1.0, // Adjust the width as needed
                  ),
                ),
                child: TextFormField(
                    validator: FormValidator.validateEmail,
                    keyboardType: TextInputType.text,
                    //   controller: controller,
                    style:  const TextStyle( fontSize: 16,fontFamily: montBook,color:cardTextColor
                    ),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 16,fontFamily: montBook,color: cardTextColor),
                        hintText: cardName)
                )
            ),
            const SizedBox(height: 10,),
           // CommonEditText(hintText: cardNum,isbgColor: true,),
            Container(
                height: 49,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: grayColor,
                    width: 1.0, // Adjust the width as needed
                  ),
                ),
                child: TextFormField(
                    validator: FormValidator.validateEmail,
                    keyboardType: TextInputType.text,
                    //   controller: controller,
                    style:  const TextStyle( fontSize: 16,fontFamily: montBook,color:cardTextColor
                    ),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 16,fontFamily: montBook,color: cardTextColor),
                        hintText: cardNum)
                )
            ),
            const SizedBox(height: 20,),
            Row(
              children: [
                Expanded(child: Container(
                    height: 49,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: grayColor,
                        width: 1.0, // Adjust the width as needed
                      ),
                    ),
                    child: TextFormField(
                        validator: FormValidator.validateEmail,
                        keyboardType: TextInputType.text,
                        //   controller: controller,
                        style:  const TextStyle( fontSize: 16,fontFamily: montBook,color:cardTextColor
                        ),
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 16,fontFamily: montBook,color: cardTextColor),
                            hintText: expiry)
                    )
                ),),// CommonEditText(hintText: expiry,isbgColor: true,)),
                SizedBox(width: 10,),
                Expanded(child:Container(
                    height: 49,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: grayColor,
                        width: 1.0, // Adjust the width as needed
                      ),
                    ),
                    child: TextFormField(
                        validator: FormValidator.validateEmail,
                        keyboardType: TextInputType.text,
                        //   controller: controller,
                        style:  const TextStyle( fontSize: 16,fontFamily: montBook,color:cardTextColor
                        ),
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(fontSize: 16,fontFamily: montBook,color: cardTextColor),
                            hintText: cvv)
                    )
                ),),// CommonEditText(hintText: cvv,isbgColor: true,)),
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
                child: CustomText(text: "SAVE", color: btntxtColor, fontfamilly: montHeavy,sizeOfFont: 18,)),
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
          const Expanded(
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: "Surprise Pack", color: btntxtColor,maxLin: 1,  fontfamilly: montBold,sizeOfFont: 21,),

                CustomText(text: "Salad & Co", color: btntxtColor,maxLin: 1,  fontfamilly: montRegular,sizeOfFont: 16,),

                CustomText(text: "Tomorrow-7:35-8:40",maxLin: 1,  color: graysColor,sizeOfFont: 11, fontfamilly: montRegular),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Icon(Icons.star,size: 20,color: btnbgColor,),
                    Icon(Icons.star,size: 20,color: btnbgColor,),
                    Icon(Icons.star,size: 20,color: btnbgColor,),
                    Icon(Icons.star,size: 20,color: btnbgColor,),
                    Icon(Icons.star,size: 20,color: btnbgColor,),
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
                Image.asset(food_image, height: 138, width: 125, fit: BoxFit.contain),
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
