import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/MULTI-PROVIDER/NotificationProvider.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/fontfamily_string.dart';

import '../../Response_Model/GetNotificationPrefResponse.dart';
import '../../Response_Model/NotificationListResponse.dart';

class YourNotificationScreen extends StatefulWidget {
  const YourNotificationScreen({super.key});

  @override
  State<YourNotificationScreen> createState() => _YourNotificationScreenState();
}

class _YourNotificationScreenState extends State<YourNotificationScreen> {
  final NotificationProvider notificationProvider = NotificationProvider();

  int isFavorite = 0;
  int currentPage = 1;

  bool isNotificationDataLoading = false;
  bool isRefresh = false;
  bool hasMoreData = true;
  List<NotificationListData> notificationList = [];

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _loadData();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Reached the end of the list, load more data
      _loadData();
    }
  }

  void _loadData() async {
    Future.delayed(
      Duration.zero,
      () async {
        if (!isNotificationDataLoading && hasMoreData) {
          try {
            setState(() {
              isNotificationDataLoading = true;
            });

            final nextPageRestaurantData =
                await notificationProvider.getNotificationList(
              page: currentPage,
            );

            if (nextPageRestaurantData.data != null &&
                nextPageRestaurantData.data!.isNotEmpty) {
              setState(() {
                if (isRefresh == true) {
                  notificationList.clear();
                  notificationList.addAll(nextPageRestaurantData.data!);
                  isRefresh = false;

                  currentPage++;
                } else {
                  notificationList.addAll(nextPageRestaurantData.data!);
                  currentPage++;
                }
              });
            }
          } catch (error) {
            print('Error loading more data: $error');
          } finally {
            setState(() {
              isNotificationDataLoading = false;
            });
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 0.0, bottom: 20, left: 25, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              const CustomText(
                text: "YOUR NOTIFICATIONS",
                fontfamilly: montHeavy,
                sizeOfFont: 20,
                color: editbgColor,
              ),
              SizedBox(
                height: 20,
              ),
              buildVerticalCards()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildVerticalCards() {
    if (notificationList.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(20.0),
        child: CustomText(
          text: 'No Item Found',
          maxLin: 1,
          color: btntxtColor,
          fontfamilly: montBold,
          sizeOfFont: 15,
        ),
      );
    }

    return Expanded(
      child: RefreshIndicator(
        key: _refreshIndicatorKey,
        color: Colors.white,
        backgroundColor: editbgColor,
        strokeWidth: 4.0,
        onRefresh: _refreshData,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: notificationList.length + (hasMoreData ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < notificationList.length) {
              // Display restaurant card
              return getView(index, notificationList[index]);
            } else {
              // Display loading indicator while fetching more data
              return FutureBuilder(
                future: Future.delayed(Duration(seconds: 1)),
                builder: (context, snapshot) =>
                    snapshot.connectionState == ConnectionState.done
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: CircularProgressIndicator()),
                          ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> _refreshData() async {
    setState(() {
      isRefresh = true;

      currentPage = 1; // Reset the page to 1 as you loaded the first page.
      // hasMoreData = true; // Reset the flag for more data.
      // restaurantData=refreshedData.data!;

      _loadData();
    });
  }

  Widget getView(int index, NotificationListData notificationList) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 0, color: Colors.grey),
      ),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: CustomText(
                text: notificationList.title ?? '',
                color: editbgColor,
                sizeOfFont: 14,
                fontfamilly: montSemiBold,
              )),
          Expanded(
              flex: 0,
              child: CustomText(
                text: "${notificationList.time} \n ${notificationList.date}",
                color: btnbgColor,
                sizeOfFont: 11,
                fontfamilly: montSemiBold,
                isAlign: true,
              )),
        ],
      ),
    );
  }
}
