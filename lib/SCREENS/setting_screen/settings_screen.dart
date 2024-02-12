import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_button.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_edit_text.dart';
import 'package:takeaplate/SCREENS/login_flow/CreateOrLoginScreen.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/fontfamily_string.dart';
import 'package:takeaplate/main.dart';

import '../../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../../CUSTOM_WIDGETS/custom_text_field.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../MULTI-PROVIDER/AuthenticationProvider.dart';
import '../../MULTI-PROVIDER/common_counter.dart';
import '../../Response_Model/DeleteAccountResponse.dart';
import '../../UTILS/app_strings.dart';
import '../../UTILS/dialog_helper.dart';
import '../../UTILS/request_string.dart';
import '../../UTILS/utils.dart';
import '../home_screens/base_home.dart';

class SettingScreen extends StatelessWidget {
  //var counterProvider=Provider.of<CommonCounter>(navigatorKey.currentContext!, listen: false);
  static int count = 0;

  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 0.0, bottom: 20, left: 29, right: 29),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //CustomAppBar(),
            Expanded(child: getView()),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Column(
                children: [
                  CommonButton(
                      btnBgColor: btnbgColor,
                      btnText: "LOG OUT",
                      onClick: () {
                        showAccountOperationDialog(context, logout, proceed);
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      showAccountOperationDialog(
                          context, deleteAccount, proceed);
                    },
                    child: CustomText(
                      text: "DELETE ACCOUNT",
                      sizeOfFont: 15,
                      weight: FontWeight.w400,
                      color: grayColor,
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

  Widget getView() {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:
            Consumer<CommonCounter>(builder: (context, commonProvider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: CustomText(
                  text: "SETTINGS",
                  sizeOfFont: 20,
                  fontfamilly: montHeavy,
                  color: editbgColor,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              CommonTextField(
                hintText: "Notification Center",
                onTap: () {
                  //count=4;
                  //commonProvider.getCount(4);
                  Navigator.pushNamed(navigatorKey.currentContext!,
                      '/NotificationCenterScreen');
                },
              ),
              const SizedBox(
                height: 15,
              ),
              CommonTextField(
                hintText: "Edit Profile",
                onTap: () {
                  Navigator.pushNamed(
                      navigatorKey.currentContext!, '/EditProfileScreen');
                },
              ),
              const SizedBox(
                height: 15,
              ),
              CommonTextField(
                hintText: "Frequently Asked Questions",
                onTap: () {
                  Navigator.pushNamed(
                      navigatorKey.currentContext!, '/FaqScreenScreen');
                },
              ),
              const SizedBox(
                height: 15,
              ),
              CommonTextField(
                hintText: "Privacy Policy",
                onTap: () {
                  Navigator.pushNamed(
                      navigatorKey.currentContext!, '/PrivacyPolicyScreen');
                },
              ),
              const SizedBox(
                height: 15,
              ),
              CommonTextField(
                hintText: "Terms & Conditions",
                onTap: () {
                  Navigator.pushNamed(
                      navigatorKey.currentContext!, '/TermsAndConditionScreen');
                },
              ),
              const SizedBox(
                height: 15,
              ),
              CommonTextField(
                hintText: "Help",
                onTap: () {
                  Navigator.pushNamed(
                      navigatorKey.currentContext!, '/ContactUsSetting');
                },
              ),
            ],
          );
        }));
  }

  Future<void> showAccountOperationDialog(
      BuildContext context, String title, String description) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  description ?? '',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center, // Use textAlign property
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors
                                .deepOrangeAccent, // Customize the color as needed
                          ),
                          child: const Text('NO'),
                        ),
                      ),
                    ),
                    Flexible(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (title == deleteAccount) {
                            BaseHome.isSearch = false;
                            try {
                              DeleteAccountResponse data =
                                  await Provider.of<AuthenticationProvider>(
                                          context,
                                          listen: false)
                                      .deleteAccount();

                              if (data.status == true &&
                                  data.message ==
                                      "Account deleted successfully") {
                                SharedPreferences.getInstance().then((prefs) {
                                  prefs.clear();
                                });

                                // Navigate to the desired screen, e.g., login screen
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/Create_Login',
                                  (Route<dynamic> route) =>
                                      false, // Clear all routes in the stack
                                );

                                final snackBar = SnackBar(
                                  content: const Text(
                                      'Account deleted successfully.'),
                                );

// Show the SnackBar
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);

// Automatically hide the SnackBar after 1 second
                                Future.delayed(Duration(milliseconds: 500), () {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                });

                                // Navigate to the next screen or perform other actions after login
                              } else {
                                // Login failed
                                print("Something went wrong: ${data.message}");
                              }
                            } catch (e) {
                              // Display error message
                              print("Error: $e");
                            }
                          } else if (title == logout) {
                            BaseHome.isSearch = false;

                            SharedPreferences.getInstance().then((prefs) {
                              prefs.clear();
                            });
                            DefaultCacheManager().emptyCache();
                            // Navigate to the desired screen, e.g., login screen

                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/Login',
                                  (Route<dynamic> route) =>
                              false, // Clear all routes in the stack
                            );

                            final snackBar = SnackBar(
                              content: const Text('Logged out successfully.'),
                            );

// Show the SnackBar
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);

// Automatically hide the SnackBar after 1 second
                            Future.delayed(Duration(milliseconds: 500), () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary:
                              Colors.green, // Customize the color as needed
                        ),
                        child: const Text('YES'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
