import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/MULTI-PROVIDER/NotificationProvider.dart';
import 'package:takeaplate/Response_Model/GetNotificationPrefResponse.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/fontfamily_string.dart';

import '../../MULTI-PROVIDER/common_counter.dart';
import '../../UTILS/app_images.dart';
import '../../UTILS/app_strings.dart';

class NotificationCenterScreen extends StatefulWidget {
  const NotificationCenterScreen({Key? key}) : super(key: key);

  @override
  State<NotificationCenterScreen> createState() =>
      _NotificationCenterScreenState();
}

class _NotificationCenterScreenState extends State<NotificationCenterScreen> {
  final NotificationProvider notificationProvider = NotificationProvider();
  late Future<GetNotificationPrefResponse> notificationPrefFuture;

  @override
  void initState() {
    super.initState();
    notificationPrefFuture = notificationProvider.getNotificationPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0, bottom: 20, left: 29, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: FutureBuilder<GetNotificationPrefResponse>(
                  future: notificationPrefFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      final getNotificationPrefResponse = snapshot.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            child: const CustomText(
                              text: "NOTIFICATION CENTRE",
                              fontfamilly: montHeavy,
                              color: editbgColor,
                              sizeOfFont: 20,
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, '/YourNotificationScreen');
                            },
                          ),
                          const SizedBox(height: 10),
                          getView("New Deal From Favourite Restaurant", 0, getNotificationPrefResponse),
                          getView("New Restaurant added nearby", 1, getNotificationPrefResponse),
                          getView("New meal purchase confirmation", 2, getNotificationPrefResponse),
                          getView("Broadcast notifications", 3, getNotificationPrefResponse),
                        ],
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getView(String title, int pos, GetNotificationPrefResponse getNotificationPrefResponse) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomText(
                text: title,
                fontfamilly: montRegular,
                color: editbgColor,
                sizeOfFont: 17,
              ),
            ),
            getSelectedRadio(pos, getNotificationPrefResponse),
          ],
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Divider(
            height: 0,
            color: grayColor,
            thickness: 0,
          ),
        ),
      ],
    );
  }

  Widget getSelectedRadio(
      int pos, GetNotificationPrefResponse getNotificationPrefResponse) {
    int isNotificationEnabled = 0;

    switch (pos) {
      case 0:
        isNotificationEnabled = getNotificationPrefResponse.data?.deal ?? 0;
        break;
      case 1:
        isNotificationEnabled = getNotificationPrefResponse.data?.store ?? 0;
        break;
      case 2:
        isNotificationEnabled = getNotificationPrefResponse.data?.meal ?? 0;
        break;
      case 3:
        isNotificationEnabled = 1;
        break;
    // Add more cases for other positions if needed
      default:
        break;
    }

    return GestureDetector(
      onTap: () async {
        // Toggle the notification status
        setState(() {
          switch (pos) {
            case 0:
              getNotificationPrefResponse.data?.deal =
              isNotificationEnabled == 1 ? 0 : 1;
              break;
            case 1:
              getNotificationPrefResponse.data?.store =
              isNotificationEnabled == 1 ? 0 : 1;
              break;
            case 2:
              getNotificationPrefResponse.data?.meal =
              isNotificationEnabled == 1 ? 0 : 1;
              break;
            case 3:
              showNotificationConfirmationDialog(context);
              break;
          // Add more cases for other positions if needed
            default:
              break;
          }
        });

        // Prepare formData for the API call
        final formData = {
          'deal': getNotificationPrefResponse.data?.deal,
          'store': getNotificationPrefResponse.data?.store,
          'meal': getNotificationPrefResponse.data?.meal,
        };

        // Call the API to update the notification preferences
        try {
          await notificationProvider.sendNotificationPref(formData);
          // If the update is successful, you can show a confirmation message or perform any other actions.
          print('Notification preferences updated successfully.');
        } catch (error) {
          // Handle error
          print('Failed to update notification preferences: $error');
          // Reset the state to the previous value in case of an error
          setState(() {
            switch (pos) {
              case 0:
                getNotificationPrefResponse.data?.deal =
                isNotificationEnabled == 1 ? 0 : 1;
                break;
              case 1:
                getNotificationPrefResponse.data?.store =
                isNotificationEnabled == 1 ? 0 : 1;
                break;
              case 2:
                getNotificationPrefResponse.data?.meal =
                isNotificationEnabled == 1 ? 0 : 1;
                break;


            // Add more cases for other positions if needed
              default:
                break;
            }
          });
        }
      },
      child: isNotificationEnabled == 1
          ? Image.asset(
        radioon,
        height: 35,
        width: 35,
      )
          : Image.asset(
        radiofficon,
        height: 35,
        width: 35,
      ),
    );
  }

  void showNotificationConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(proceed),
          content: const Text(
              notification_disable),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("CANCEL"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

          ],
        );
      },
    );
  }
}
