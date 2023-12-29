import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:takeaplate/UTILS/utils.dart';
import '../CUSTOM_WIDGETS/common_button.dart';
import '../CUSTOM_WIDGETS/common_edit_text.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../MULTI-PROVIDER/common_counter.dart';
import '../main.dart';
import 'app_color.dart';
import 'app_images.dart';
import 'app_strings.dart';
import 'fontfaimlly_string.dart';

class DialogHelper {

  static double  screenHeight = MediaQuery.of(navigatorKey.currentContext!).size.height;
  static double screenWidth = MediaQuery.of(navigatorKey.currentContext!).size.width;


  static Future<void> selectDate(BuildContext context, CommonCounter commonCounter, {TextEditingController? controller}) async {
    DateTime currentDate = commonCounter.dateTtime;

    // Show date picker
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      // Update the controller or perform any other actions with the selected date and time
        if (controller != null) {
          controller.text = DateFormat("yyyy-MM-dd").format(selectedDate);
          print('Selected date and time: $selectedDate');
        }
    }
  }
//show forget pass
  static Future<void> showCommonPopup(BuildContext context,{String? title,String? subtitle,bool? isDelete}) async {
    showDialog(
      context: context,
       useSafeArea: false,
      useRootNavigator: false,
        barrierDismissible:false,
      builder: (BuildContext context) {
        return Dialog.fullscreen(
        /*  shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),*/
          backgroundColor: Colors.transparent,
          child:
          Stack(
            children: [
              Container(
               color: title==sentPss ? Colors.black.withOpacity(0.1) :dailogColor.withOpacity(0.75),
                height: double.infinity,
                width: double.infinity,
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: title==sentPss ?screenHeight * 0.08: screenHeight * 0.16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0,right: 0.0,top: 30.0,bottom: 10),
                    child:
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                          color: onboardingbgColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(width: 1, color: hintColor)),
                      child: subtitle != null ? 
                      Column(children: [
                        SizedBox(
                          height: screenHeight * 0.03,
                        ),
                        Image.asset(appLogo,
                          height: 100,
                          width: 100,),
                        const SizedBox(height: 20,),
                         Align(
                          alignment: Alignment.center,
                          child: CustomText(text:title ?? "" ,
                            sizeOfFont: 19,
                            color: hintColor,
                            fontfamilly: montHeavy,
                            isAlign: true,),
                        ),
                        const SizedBox(height: 20,),
                        Align(
                           alignment: Alignment.center,
                           child: CustomText(text: subtitle ?? "",
                            sizeOfFont: 19,
                            color: btnbgColor,
                            fontfamilly: montRegular,
                            isAlign: true,),
                         ),
                        SizedBox(
                          height: screenHeight * 0.05,
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 15.0,right: 15,top: 6,bottom: 20),
                          child: CommonButton(btnBgColor:onboardingBtn, btnText: done, onClick: (){
                            if (title == sentPss) {
                              // Navigate to login screen
                              Navigator.pushNamed(context, '/Create_Login');
                            } else {
                              // Perform the default behavior
                              Navigator.pop(context);
                            }
                          }),
                        ),
                        SizedBox(height: 10,)
                      ])
                      :  !isDelete! ?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        SizedBox(
                          height: screenHeight * 0.03,
                        ),
                        Image.asset(appLogo,
                          height: 100,
                          width: 100,),
                        const SizedBox(height: 20,),
                        Align(
                          alignment: Alignment.center,
                          child: CustomText(text:title ?? "" ,
                            sizeOfFont: 21,
                            color: hintColor,
                            fontfamilly: montHeavy,
                            isAlign: true,),
                        ),
                        const SizedBox(height: 20,),

                       // Image.asset(star_box,height: 42,fit: BoxFit.contain,),

                        RatingBar(
                            filledIcon: Icons.star,
                            emptyIcon: Icons.star_border,
                            onRatingChanged: (value) => print('$value'),
                            initialRating: 0,
                            alignment: Alignment.center,
                            emptyColor: btnbgColor,
                            filledColor: btnbgColor,

                            maxRating: 5,
                          ),


                       /* const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.star_border,size: 35,color: btnbgColor,),
                            Icon(Icons.star_border,size: 35,color: btnbgColor,),
                            Icon(Icons.star_border,size: 35,color: btnbgColor,),
                            Icon(Icons.star_border,size: 35,color: btnbgColor,),
                            Icon(Icons.star_border,size: 35,color: btnbgColor,),
                          ],
                        ),*/
                        SizedBox(
                          height: screenHeight * 0.05,
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 15.0,right: 15,top: 6,bottom: 20),
                          child: CommonButton(btnBgColor:onboardingBtn, btnText: "RATE", onClick: (){
                            Navigator.pop(context);
                            showCommonPopup(context,title: "YOUR RATING HAS BEEN SUBMITTED",subtitle: "THANK YOU FOR GIVING US YOUR FEEDBACK");
                          }),
                        ),
                        SizedBox(height: 10,)
                      ]):
                      Column(children: [
                        SizedBox(
                          height: screenHeight * 0.03,
                        ),
                        Image.asset(appLogo,
                          height: 100,
                          width: 100,),
                        const SizedBox(height: 20,),
                        Align(
                          alignment: Alignment.center,
                          child: CustomText(text:title ?? "" ,
                            sizeOfFont: 17,
                            color: hintColor,
                            fontfamilly: montBold,
                            isAlign: true,),
                        ),
                        SizedBox(
                          height: screenHeight * 0.05,
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 15.0,right: 15,top: 6,bottom: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: CommonButton(btnBgColor:onboardingBtn, btnText: "YES", onClick: (){
                                  Navigator.pop(context);
                                }),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                child: CommonButton(btnBgColor:onboardingBtn, btnText: "NO", onClick: (){
                                  Navigator.pop(context);
                                }),
                              ),  
                            ],
                          ),
                        ),
                        SizedBox(height: 10,)
                      ]),
                    ),
                  ),
                ],
              ),
            
            ],

          ),
        );
      },
    );
  }


  //show error dialog
  static Future<void> showErrorDialog(BuildContext context,
      {String title = 'Error',
      String? description = 'Something went wrong'}) async {
    showDialog(
      context: context, // Replace 'context' with your current BuildContext
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description ?? 'Something went wrong',
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    //Navigator.of(context).pop();
                    DialogHelper.hideLoading(navigatorKey.currentContext!);
                  },
                  child: const Text(
                    'OKAY',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showLoading(BuildContext context, {String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircularProgressIndicator(),
                  if (message != null) SizedBox(height: 16),
                  if (message != null) Text(message),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<void> showPermissionDialog(
    BuildContext context, {
    String title = 'Permission',
    String? description =
        'You have permanently denied all permissions. Please give permission in app settings.',
  })
  async {
    return
      showDialog<void>(
      context: context!,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return
          Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  description ?? '',
                  style: TextStyle(fontSize: 16),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    // Add your code to open app settings here
                    //AppSettings.openAppSettings();
                  },
                  child: const Text('Open Settings'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void hideLoading(BuildContext context) {
    Navigator.of(context).pop();
  }

  static Future<void> addCardDialoge(BuildContext context) async {
    showDialog(
      context: context,
      useSafeArea: false,
      useRootNavigator: false,
      barrierDismissible:false,
      builder: (BuildContext context) {
        return Dialog.fullscreen(
            backgroundColor: Colors.transparent,
          child: Stack(
              children: [
                Container(
                 color: dailogColor.withOpacity(0.75),
                  height: double.infinity,
                  width: double.infinity,
                ),
                 paymentDetails()
              ],
             )
        );
      },
    );
  }

  static Widget paymentDetails() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: screenHeight * 0.16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0.0,right: 0.0,top: 30.0,bottom: 10),
            child:
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                  color: onboardingbgColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(width: 1, color: hintColor)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                SizedBox(
                  height: screenHeight * 0.03,
                ),
      
                const CustomText(text: "ADD NEW CARD",color: btnbgColor,fontfamilly: montBold,sizeOfFont: 20,),
                const SizedBox(height: 25,),
                CommonEditText(hintText: cardName,isnewCard: true,),
                const SizedBox(height: 20,),
                CommonEditText(hintText: cardNum,isnewCard: true,),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(child: CommonEditText(hintText: expiry,isnewCard: true,)),
                    const SizedBox(width: 10,),
                    Expanded(child: CommonEditText(hintText: cvv,isnewCard: true,)),
                  ],
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      decoration: BoxDecoration(
                        color: btnbgColor,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(width: 1, color: btnbgColor),
                      ),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pop(navigatorKey.currentContext!);
                        },
                          child: const CustomText(text: "SAVE", color: btntxtColor, fontfamilly: montHeavy,sizeOfFont: 20,))),
                ),
      
              ]),
            ),
          ),
        ],
      ),
    );

  }

}
