import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:takeaplate/UTILS/utils.dart';
import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../MULTI-PROVIDER/common_counter.dart';
import '../main.dart';
import 'app_color.dart';
import 'app_strings.dart';
import 'fontfaimlly_string.dart';

class DialogHelper {



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
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0.7, color: Colors.grey),
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(16.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(
                    text: logoutPop,
                    sizeOfFont: 14,
                    fontfamilly: poppinsSemiBold,
                    weight: FontWeight.w600,
                    color: jobwiishColor,
                  ),
                  const SizedBox(height: 10),
                  const CustomText(
                    text: areYouSure,
                    sizeOfFont: 10,
                    fontfamilly: poppinsLight,
                    weight: FontWeight.w400,
                    color: jobwiishColor,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: hintColor.withOpacity(0.2),
                                  maximumSize: Size.infinite,
                                  minimumSize: Size(double.maxFinite, 50)),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(cancel,
                                  style: TextStyle(
                                      color: jobwiishColor,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: poppinsMedium,
                                      fontSize: 13)))),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: secondaryColor,
                                  maximumSize: Size.infinite,
                                  minimumSize: Size(double.maxFinite, 50)),
                              onPressed: () async{
                                await Utility.clearAll();
                                Navigator.pushReplacementNamed(context, '/Log_in');
                              },
                              child: const Text(logout,
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: poppinsMedium,
                                      fontSize: 13)))),
                    ],
                  ),
                ],
              ),
            ),
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
  }) async {
    return showDialog<void>(
      context: context!,
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
}
