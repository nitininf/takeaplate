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
  static Future<void> showLogout(BuildContext context) async {
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

              Image.asset(
                passwordsent_bg,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: screenHeight * 0.16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0,right: 0.0,top: 30.0,bottom: 10),
                    child:
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                          color: onboardingbgColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(width: 1, color: hintColor)),
                      child: Column(children: [
                        SizedBox(
                          height: screenHeight * 0.03,
                        ),
                        Image.asset(appLogo,
                          height: 100,
                          width: 100,),
                        const SizedBox(height: 20,),
                        const Align(
                          alignment: Alignment.center,
                          child: CustomText(text:sentPss ,
                            sizeOfFont: 17,
                            color: hintColor,
                            fontfamilly: montBook,
                            isAlign: true,),
                        ),
                        const SizedBox(height: 20,),

                        const CustomText(text: checkInbox,
                          sizeOfFont: 17,
                          color: btnbgColor,
                          fontfamilly: montBook,
                          isAlign: true,),
                        SizedBox(
                          height: screenHeight * 0.05,
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 15.0,right: 15,top: 6,bottom: 20),
                          child: CommonButton(btnBgColor:hintColor, btnText: done, onClick: (){
                            Navigator.pop(context);
                          }),
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

  static Future<void> commonDialoge(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child:
          Column(
            children: <Widget>[
              SizedBox(
                height: screenHeight * 0.16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0,right: 30.0,top: 30.0,bottom: 10),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                      color: onboardingbgColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(width: 1, color: hintColor)),
                  child: Column(children: [
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    Image.asset(appLogo,
                      height: 100,
                      width: 100,),
                    const SizedBox(height: 20,),
                    const Align(
                      alignment: Alignment.center,
                      child: CustomText(text:sentPss ,
                        sizeOfFont: 17,
                        color: hintColor,
                        fontfamilly: montBook,
                        isAlign: true,),
                    ),
                    const SizedBox(height: 20,),

                    const CustomText(text: checkInbox,
                      sizeOfFont: 17,
                      color: btnbgColor,
                      fontfamilly: montBook,
                      isAlign: true,),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 15.0,right: 15,top: 6,bottom: 20),
                      child: CommonButton(btnBgColor:hintColor, btnText: done, onClick: (){
                        Navigator.pushNamed(context, '/SignupScreen');
                      }),
                    ),
                    SizedBox(height: 10,)
                  ]),
                ),
              ),
              const CustomText(text: forgotpss,color: hintColor,fontfamilly: montBook,),
              SizedBox(height: screenHeight*0.07,),
              // Horizontal line using Divider
              const Padding(
                padding:  EdgeInsets.only(left: 50.0,right: 50),
                child:  Divider(
                  color: Colors.white,
                  thickness: 0,
                ),
              ),
              const SizedBox(height: 20,),
              const CustomText(text: notMmberyet,color: hintColor,fontfamilly: montBook,),
              const SizedBox(height: 10,),
              const CustomText(text: createyouraccount,color: btnbgColor,sizeOfFont: 20,fontfamilly: montBold,),

            ],
          ),
        );
      },
    );
  }

  static Future<void> addCardDialoge(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: paymentDetails()
        );
      },
    );
  }

  static Widget paymentDetails() {
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
              CustomText(text: paymentdetails,color: btntxtColor,weight: FontWeight.w900,fontfamilly: montBold,sizeOfFont: 20,),
              SizedBox(height: 25,),
              CommonEditText(hintText: cardName,isbgColor: true,),
              const SizedBox(height: 20,),
              CommonEditText(hintText: cardNum,isbgColor: true,),
              const SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(child: CommonEditText(hintText: expiry,isbgColor: true,)),
                  SizedBox(width: 10,),
                  Expanded(child: CommonEditText(hintText: cvv,isbgColor: true,)),
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
                    child: CustomText(text: "SAVE", color: btntxtColor, fontfamilly: montBook,weight: FontWeight.w900,)),
              ),
            ],
          )
      ),
    );
  }

}
