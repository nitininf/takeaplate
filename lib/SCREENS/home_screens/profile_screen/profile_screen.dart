import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takeaplate/SCREENS/contact_us/contacctus_settings.dart';
import 'package:takeaplate/UTILS/app_strings.dart';
import '../../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../../MULTI-PROVIDER/SharedPrefsUtils.dart';
import '../../../UTILS/app_color.dart';
import '../../../UTILS/app_images.dart';
import '../../../UTILS/fontfaimlly_string.dart';
import '../../../main.dart';


TextEditingController fullNameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController phoneNumberController = TextEditingController();
TextEditingController dobController = TextEditingController();

TextEditingController selectedImagePathController = TextEditingController();


bool isDateSelected = false; // Add a flag to check if the date is already selected

class ProfileScreen extends StatelessWidget{
  double screenHeight = MediaQuery.of(navigatorKey.currentContext!).size.height;
  double screenWidth = MediaQuery.of(navigatorKey.currentContext!).size.width;
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 5.0, right: 25, left: 25, bottom: 10),
        child: FutureBuilder<Map<String, String>>(
          future: SharedPrefsUtils.getDefaultValuesFromPrefs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                Map<String, String> data = snapshot.data!;
                fullNameController.text = data["fullName"]!;
                emailController.text = data["email"]!;
                phoneNumberController.text = data["phoneNumber"]!;
                dobController.text = data["dob"]!;
                selectedImagePathController.text = data["selectedImagePath"]!;

                return Column(
                  children: [
                    SizedBox(height: 20),
                    getView(),
                  ],
                );
              }
            } else {
              // Show a loading indicator while fetching data
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );

  }

  Widget buildSection(String title, String viewAllText) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 15.0,top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: title, color: btnbgColor, fontfamilly: montHeavy, sizeOfFont: 20),
          GestureDetector(child: CustomText(text: viewAllText, color: viewallColor, fontfamilly: montRegular,sizeOfFont: 12, ),

          onTap: (){
            if(title=="CURRENT ORDERS") {
              Navigator.pushNamed(
                  navigatorKey.currentContext!, '/MyOrdersSccreen');
            }
            else if(title=="MY FAVOURITES"){
              Navigator.pushNamed(
                  navigatorKey.currentContext!, '/FavouriteScreen');
            }
            else{
              Navigator.pushNamed(
                  navigatorKey.currentContext!, '/PaymentMethodScreen');
            }
          },
          ),
        ],
      ),
    );
  }

  Widget getCards({Color? bclor}) {
    return
      GestureDetector(
        onTap: (){
          Navigator.pushNamed(navigatorKey.currentContext!, '/YourOrderScreen');
        },
        child:
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 0,   color: editbgColor.withOpacity(0.25),),
            color: bclor?.withOpacity(0.40)
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Expanded(
                 flex: 2,
                 child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(text: "Surprise Pack",maxLin: 1, color: btntxtColor, fontfamilly: montBold,sizeOfFont: 21,),

                    const CustomText(text: "Salad & Co.", maxLin:1,color: viewallColor, fontfamilly: montRegular,sizeOfFont: 16,),

                    const CustomText(text: "Tomorrow-7:35-8:40 Am",maxLin: 1, color: graysColor,sizeOfFont: 11, fontfamilly: montRegular),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: readybgColor,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(width: 1, color: Colors.white),
                            ),
                            child: const CustomText(text: "READY FOR PICKUP",maxLin:1,sizeOfFont: 10,fontfamilly:montHeavy,color: readyColor,),
                          ),
                        ),
                        SizedBox(width: 10,),
                        CustomText(text: "84 Km", color: graysColor,sizeOfFont: 15, fontfamilly: montSemiBold,),
                      ],

                    ),
                    SizedBox(height: 0,),
                    CustomText(text: "\$"+"9.99", color: dolorColor,sizeOfFont: 26, fontfamilly: montHeavy,),

                  ],
                               ),
               ),
              const SizedBox(width: 18,),
              Expanded(
                flex: 0,
                child: Stack(
                  alignment: Alignment.topRight,
                  clipBehavior: Clip.none,
                  children: [
                    Image.asset(food_image, height: 130, width: 127, fit: BoxFit.cover),
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
        ),
      );
  }
  Widget getView(){
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [


        selectedImagePathController.text !=''
        ? ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
          child: Image.network(
            selectedImagePathController.text,
            fit: BoxFit.cover,
            height: 94,width: 95,
          )
      ): Image.asset(profile,height: 94,width: 95,),

                SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     CustomText(text: fullNameController.text,color: viewallColor,sizeOfFont: 25,fontfamilly: montBold,),
                     CustomText(text: emailController.text,sizeOfFont: 15,fontfamilly:montRegular,color: viewallColor,),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: editprofilbgColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 1, color: Colors.white),
                      ),
                      child: GestureDetector(onTap:(){
                        Navigator.pushNamed(
                            navigatorKey.currentContext!, '/EditProfileScreen');
                      },child: const CustomText(text: "EDIT PROFILE",sizeOfFont: 10,fontfamilly:montBold,color: editprofileColor,)),
                    )
                  ],
                ),
               // profileSection()
              ],
            ),
            const SizedBox(height: 30,),
            buildSection("CURRENT ORDERS", viewall),
            const SizedBox(height: 5,),
            getCards(bclor: onboardingBtn),
            getCards(),
            const Padding(
              padding: EdgeInsets.only(left: 25.0,right: 25,top: 15,bottom: 15),
              child: Divider(height: 0,color: grayColor,thickness: 0,),
            ),
            buildSection("MY FAVOURITES", viewall),
            const SizedBox(height: 5,),
            buildHorizontalFavCards(),
            const Padding(
              padding: EdgeInsets.only(left: 25.0,right: 25,top: 15,bottom: 15),
              child: Divider(height: 0,color: grayColor,thickness: 0,),
            ),
            buildSection("PAYMENT METHOD", viewall),
            const SizedBox(height: 5,),
             getMasterCard()
          ],
        ),
      ),
    );
  }
  Widget buildHorizontalFavCards() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(8, (index) => getFavCards()),
      ),
    );
  }

  Widget getMasterCard(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: mastercardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 0,   color: editbgColor.withOpacity(0.25),),
      ),
      child:  Row(
        children: [
          Image.asset(master_card,fit: BoxFit.contain,height: 40,width: 70,),
          const SizedBox(width: 10,),
          const Expanded(child: CustomText(text: "MasterCard",color: btntxtColor,sizeOfFont: 15,fontfamilly: montBold,)),
          const CustomText(text: "-2211",color: btntxtColor,sizeOfFont: 14,fontfamilly: montRegular,),
        ],
      ),
    );
  }
  Widget getFavCards() {
    return
      Container(
       // width: screenWidth*0.8,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 0,   color: editbgColor.withOpacity(0.25),),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: "Surprise Pack",maxLin: 1, color: btntxtColor, fontfamilly: montBold,sizeOfFont: 21,),

              CustomText(text: "Salad & Co.", maxLin:1,color: viewallColor, fontfamilly: montRegular,sizeOfFont: 16,),

              CustomText(text: "Tomorrow-7:35-8:40 Am", maxLin:1,color: graysColor,sizeOfFont: 11, fontfamilly: montRegular),
              SizedBox(height: 5,),
              Row(
                children: [
                  Icon(Icons.star_border,size: 20,color: Colors.grey,),
                  Icon(Icons.star_border,size: 20,color: Colors.grey,),
                  Icon(Icons.star_border,size: 20,color: Colors.grey,),
                  Icon(Icons.star_border,size: 20,color: Colors.grey,),
                  Icon(Icons.star_border,size: 20,color: Colors.grey,),
                  SizedBox(width: 10,),
                  CustomText(text: "84 Km", color: graysColor,sizeOfFont: 15, fontfamilly: montSemiBold,),
                ],

              ),
              SizedBox(height: 5,),
              CustomText(text: "\$"+"9.99", color: dolorColor,sizeOfFont: 24, fontfamilly: montBold,weight: FontWeight.w900,),

            ],
          ),
          const SizedBox(width: 18,),
          Stack(
            alignment: Alignment.topRight,
            clipBehavior: Clip.none,
            children: [
              Image.asset(food_image, height: 130, width: 120, fit: BoxFit.contain),
              Positioned(
                right: 0,
                top: 3,
                child: Image.asset(
                  save_icon,
                  height: 15,
                  width: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}