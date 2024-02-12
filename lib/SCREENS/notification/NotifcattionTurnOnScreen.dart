import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_button.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/MULTI-PROVIDER/NotificationProvider.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/app_images.dart';
import 'package:takeaplate/UTILS/app_strings.dart';
import 'package:takeaplate/UTILS/fontfamily_string.dart';
import '../../MULTI-PROVIDER/common_counter.dart';
import '../../Response_Model/SendNotificationPrefResponse.dart';
import '../../UTILS/request_string.dart';

var deal = 0;
var meal = 0;
var store = 0;

class NotificationTurnOnScreen extends StatelessWidget {
  const NotificationTurnOnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(notification_center),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 0.0, right: 35, left: 35, bottom: 15),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                   Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, '/BaseHome');
                        },
                        child: CustomText(
                          text: skip,
                          color: hintColor,
                          fontfamilly: montBold,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SizedBox(height: screenHeight * 0.25,),
                        // getWidget(title: favRes),
                        //  getWidget(title: nearby, subtitle: miss),
                        // getWidget(title: confirm),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 13, vertical: 13),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 1, vertical: 8),
                          decoration: BoxDecoration(
                              color: editbgColor,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(width: 1, color: editbgColor)),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: Image.asset(
                                appLogo,
                                height: 30,
                                width: 30,
                              )),
                              const Expanded(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: CustomText(
                                          text: favRes,
                                          fontfamilly: montBold,
                                          color: hintColor,
                                          sizeOfFont: 10,
                                          isAlign: false,
                                        ),
                                      ),
                                      //SizedBox(height: 5,),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: CustomText(
                                          text: "",
                                          fontfamilly: montLight,
                                          color: hintColor,
                                          sizeOfFont: 10,
                                          isAlign: false,
                                        ),
                                      ),
                                    ],
                                  )),
                              Consumer<CommonCounter>(
                                  builder: (context, commonProvider, child) {
                                return Expanded(
                                    flex: 2,
                                    child: GestureDetector(
                                      onTap: () {
                                        commonProvider.isNotification
                                            ? commonProvider
                                                .notificationShowOn(false)
                                            : commonProvider
                                                .notificationShowOn(true);
                                      },
                                      child: commonProvider.isNotification
                                          ? Image.asset(
                                              radioon,
                                              height: 17,
                                              width: 17,
                                            )
                                          : Image.asset(
                                              notification_off,
                                              height: 17,
                                              width: 17,
                                            ),
                                    ));
                              })
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 13, vertical: 13),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 1, vertical: 8),
                          decoration: BoxDecoration(
                              color: editbgColor,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(width: 1, color: editbgColor)),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: Image.asset(
                                appLogo,
                                height: 30,
                                width: 30,
                              )),
                              const Expanded(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: CustomText(
                                          text: nearby,
                                          fontfamilly: montBold,
                                          color: hintColor,
                                          sizeOfFont: 10,
                                          isAlign: false,
                                        ),
                                      ),
                                      //SizedBox(height: 5,),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: CustomText(
                                          text: miss,
                                          fontfamilly: montLight,
                                          color: hintColor,
                                          sizeOfFont: 10,
                                          isAlign: false,
                                        ),
                                      ),
                                    ],
                                  )),
                              Consumer<CommonCounter>(
                                  builder: (context, commonProvider, child) {
                                return Expanded(
                                    flex: 2,
                                    child: GestureDetector(
                                      onTap: () {
                                        commonProvider.isNotification_one
                                            ? commonProvider
                                                .notificationShowOn_one(false)
                                            : commonProvider
                                                .notificationShowOn_one(true);
                                      },
                                      child: commonProvider.isNotification_one
                                          ? Image.asset(
                                              radioon,
                                              height: 17,
                                              width: 17,
                                            )
                                          : Image.asset(
                                              notification_off,
                                              height: 17,
                                              width: 17,
                                            ),
                                    ));
                              })
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 13, vertical: 13),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 1, vertical: 8),
                          decoration: BoxDecoration(
                              color: editbgColor,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(width: 1, color: editbgColor)),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: Image.asset(
                                appLogo,
                                height: 30,
                                width: 30,
                              )),
                              const Expanded(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: CustomText(
                                          text: confirm,
                                          fontfamilly: montBold,
                                          color: hintColor,
                                          sizeOfFont: 10,
                                          isAlign: false,
                                        ),
                                      ),
                                      //SizedBox(height: 5,),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: CustomText(
                                          text: "",
                                          fontfamilly: montLight,
                                          color: hintColor,
                                          sizeOfFont: 10,
                                          isAlign: false,
                                        ),
                                      ),
                                    ],
                                  )),
                              Consumer<CommonCounter>(
                                  builder: (context, commonProvider, child) {
                                return Expanded(
                                    flex: 2,
                                    child: GestureDetector(
                                      onTap: () {
                                        commonProvider.isNotification_two
                                            ? commonProvider
                                                .notificationShowOn_two(false)
                                            : commonProvider
                                                .notificationShowOn_two(true);
                                      },
                                      child: commonProvider.isNotification_two
                                          ? Image.asset(
                                              radioon,
                                              height: 17,
                                              width: 17,
                                            )
                                          : Image.asset(
                                              notification_off,
                                              height: 17,
                                              width: 17,
                                            ),
                                    ));
                              })
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: CustomText(
                          text: dealAgain,
                          fontfamilly: montBold,
                          color: hintColor,
                          sizeOfFont: 18,
                          isAlign: false,
                        ),
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: CustomText(
                          text: choose,
                          fontfamilly: montRegular,
                          color: btnbgColor,
                          sizeOfFont: 16,
                          isAlign: false,
                        ),
                      ),
                      const SizedBox(height: 20),
                      CommonButton(
                        btnBgColor: btnbgColor,
                        btnText: turnonnotification,
                        sizeOfFont: 17,
                        onClick: () async {
                          var dealStatus =
                              ('${Provider.of<CommonCounter>(context, listen: false).isNotification}');
                          var storeStatus =
                              ('${Provider.of<CommonCounter>(context, listen: false).isNotification_one}');
                          var mealStatus =
                              ('${Provider.of<CommonCounter>(context, listen: false).isNotification_two}');

                          if (dealStatus == "true") {
                            deal = 1;
                          } else {
                            deal = 0;
                          }
                          if (storeStatus == "true") {
                            store = 1;
                          } else {
                            store = 0;
                          }
                          if (mealStatus == "true") {
                            meal = 1;
                          } else {
                            meal = 0;
                          }

                          try {
                            var formData = {
                              RequestString.DEAL: deal,
                              RequestString.MEAL: meal,
                              RequestString.STORE: store,
                              RequestString.BROADCAST_NOTIFICATION: 1,
                            };

                            SendNotificationPrefResponse data =
                                await Provider.of<NotificationProvider>(context,
                                        listen: false)
                                    .sendNotificationPref(formData);

                            if (data.status == true &&
                                data.message ==
                                    "Notification update successfully") {
                              // Login successful

                              Navigator.pushNamedAndRemoveUntil(context, '/BaseHome', (Route route) => false);
                              // Print data to console

                              // Navigate to the next screen or perform other actions after login
                            } else {
                              // Login failed

                              final snackBar = SnackBar(
                                content: Text('${data.message}'),
                              );

                              // Show the SnackBar
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);

                              // Automatically hide the SnackBar after 1 second
                              Future.delayed(const Duration(milliseconds: 1000),
                                  () {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                              });
                            }
                          } catch (e) {
                            // Display error message
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

/*  */
/*Widget getWidget({String? title, String? subtitle = ""}) {
    return
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 8),
        decoration: BoxDecoration(
            color: editbgColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(width: 1, color: editbgColor)),
        child: Row(
          children: [
        Expanded(child: Image.asset(appLogo, height: 30, width: 30,)),
    Expanded(
    flex: 3,
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    const SizedBox(height: 10,),
    Align(
    child: CustomText(text:title! ,fontfamilly: montBold,color: hintColor,sizeOfFont: 10,
    isAlign: false,
    ),
    alignment: Alignment.topLeft,
    ),
    //SizedBox(height: 5,),
    Align(
    alignment: Alignment.topLeft,
    child: CustomText(text:subtitle! ,fontfamilly: montLight,color: hintColor,sizeOfFont: 10,
    isAlign: false,
    ),
    ),
    ],
    )),
    Consumer<CommonCounter>(builder: (context,commonProvider,child){
      return
    Expanded(child:
    GestureDetector(
    onTap: (){
     commonProvider.isNotification ? commonProvider.notificationShowOn(false) : commonProvider.notificationShowOn(true);
    },
    child: commonProvider.isNotification ? Image.asset(radioon,
    height: 17,
    width: 17,) : Image.asset(notification_off,
      height: 17,
      width: 17,
    ),
    )
    );

    }
    )
    ]
    ,
    )
    ,
    );
  }
*/
}
