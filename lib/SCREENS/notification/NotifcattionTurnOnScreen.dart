import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_button.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/app_images.dart';
import 'package:takeaplate/UTILS/app_strings.dart';
import 'package:takeaplate/UTILS/fontfaimlly_string.dart';

import '../../MULTI-PROVIDER/common_counter.dart';
import '../../UTILS/request_string.dart';
import '../../UTILS/utils.dart';

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
                  const Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: CustomText(
                        text: skip,
                        color: hintColor,
                        fontfamilly: montBold,
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
                              Expanded(
                                  child: Image.asset(
                                appLogo,
                                height: 33,
                                width: 33,
                              )),
                              Expanded(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        child: CustomText(
                                          text: favRes!,
                                          fontfamilly: montBold,
                                          color: hintColor,
                                          sizeOfFont: 12,
                                          isAlign: false,
                                        ),
                                        alignment: Alignment.topLeft,
                                      ),
                                      //SizedBox(height: 5,),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: CustomText(
                                          text: "",
                                          fontfamilly: montLight,
                                          color: hintColor,
                                          sizeOfFont: 12,
                                          isAlign: false,
                                        ),
                                      ),
                                    ],
                                  )),
                              Consumer<CommonCounter>(
                                  builder: (context, commonProvider, child) {
                                return Expanded(
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
                              Expanded(
                                  child: Image.asset(
                                appLogo,
                                height: 33,
                                width: 33,
                              )),
                              Expanded(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Align(
                                        child: CustomText(
                                          text: nearby,
                                          fontfamilly: montBold,
                                          color: hintColor,
                                          sizeOfFont: 12,
                                          isAlign: false,
                                        ),
                                        alignment: Alignment.topLeft,
                                      ),
                                      //SizedBox(height: 5,),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: CustomText(
                                          text: miss!,
                                          fontfamilly: montLight,
                                          color: hintColor,
                                          sizeOfFont: 12,
                                          isAlign: false,
                                        ),
                                      ),
                                    ],
                                  )),
                              Consumer<CommonCounter>(
                                  builder: (context, commonProvider, child) {
                                return Expanded(
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
                              Expanded(
                                  child: Image.asset(
                                appLogo,
                                height: 33,
                                width: 33,
                              )),
                              Expanded(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        child: CustomText(
                                          text: confirm!,
                                          fontfamilly: montBold,
                                          color: hintColor,
                                          sizeOfFont: 12,
                                          isAlign: false,
                                        ),
                                        alignment: Alignment.topLeft,
                                      ),
                                      //SizedBox(height: 5,),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: CustomText(
                                          text: ""!,
                                          fontfamilly: montLight,
                                          color: hintColor,
                                          sizeOfFont: 12,
                                          isAlign: false,
                                        ),
                                      ),
                                    ],
                                  )),
                              Consumer<CommonCounter>(
                                  builder: (context, commonProvider, child) {
                                return Expanded(
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
                      Align(
                        alignment: Alignment.center,
                        child: CustomText(
                          text: dealAgain,
                          fontfamilly: montBold,
                          color: hintColor,
                          sizeOfFont: 18,
                          isAlign: false,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
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
                          var token =
                              await Utility.getStringValue(RequestString.TOKEN);
                          print(token);
                          print(
                              'Notification 1 Status: ${Provider.of<CommonCounter>(context, listen: false).isNotification}');
                          print(
                              'Notification 2 Status: ${Provider.of<CommonCounter>(context, listen: false).isNotification_one}');
                          print(
                              'Notification 3 Status: ${Provider.of<CommonCounter>(context, listen: false).isNotification_two}');

                          Navigator.pushNamed(context, '/BaseHome');
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
        Expanded(child: Image.asset(appLogo, height: 33, width: 33,)),
    Expanded(
    flex: 3,
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    const SizedBox(height: 10,),
    Align(
    child: CustomText(text:title! ,fontfamilly: montBold,color: hintColor,sizeOfFont: 12,
    isAlign: false,
    ),
    alignment: Alignment.topLeft,
    ),
    //SizedBox(height: 5,),
    Align(
    alignment: Alignment.topLeft,
    child: CustomText(text:subtitle! ,fontfamilly: montLight,color: hintColor,sizeOfFont: 12,
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
