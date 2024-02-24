import 'dart:math';

import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:take_a_plate/UTILS/app_strings.dart';
import '../../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../../MULTI-PROVIDER/FavoriteOperationProvider.dart';
import '../../../MULTI-PROVIDER/HomeDataListProvider.dart';
import '../../../MULTI-PROVIDER/SharedPrefsUtils.dart';
import '../../../Response_Model/CardListResponse.dart';
import '../../../Response_Model/CurrentOrderResponse.dart';
import '../../../Response_Model/FavAddedResponse.dart';
import '../../../Response_Model/FavDeleteResponse.dart';
import '../../../Response_Model/ProfilePageResponse.dart';
import '../../../Response_Model/RestaurantDealResponse.dart';
import '../../../UTILS/app_color.dart';
import '../../../UTILS/app_images.dart';
import '../../../UTILS/fontfamily_string.dart';
import '../../../UTILS/request_string.dart';
import '../../../UTILS/utils.dart';
import '../../../main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  final HomeDataListProvider homeProvider = HomeDataListProvider();

  TextEditingController selectedImagePathController = TextEditingController();
  double screenHeight = MediaQuery.of(navigatorKey.currentContext!).size.height;
  double screenWidth = MediaQuery.of(navigatorKey.currentContext!).size.width;

  bool isFavorite = false;
  int currentPage = 1;
  bool isLoading = false;
  bool hasMoreData = true;

  bool isDateSelected =
      false; // Add a flag to check if the date is already selected
  List<DealData> favoriteStoresAndDeals = [];
  List<CurrentDeal> currentOrderDeals = [];
  List<DealData> previousOrderDeals = [];
  List<PaymentCard> cardListData = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {


    Future.delayed(Duration.zero,() async {

      if (!isLoading && hasMoreData) {
        try {
          setState(() {
            isLoading = true;
          });

          var lat = await Utility.getStringValue(RequestString.LATITUDE);
          var long = await Utility.getStringValue(RequestString.LONGITUDE);


          var formData = {
            RequestString.LATITUDE: lat,
            RequestString.LONGITUDE: long,

          };




          final nextPageData = await homeProvider.getProfilePageData(
            formData,
            page: currentPage,

          );

          if (nextPageData.currentDeal != null &&
              nextPageData.currentDeal!.isNotEmpty) {
            // currentPage++;

            setState(() {
              if (mounted) {
                currentOrderDeals = nextPageData.currentDeal!;
              }
            });
          } else {
            setState(() {
              if (mounted) {
                hasMoreData = false;
                currentOrderDeals.clear();
              }
            });
          }

          if (nextPageData.previousDeal != null &&
              nextPageData.previousDeal!.isNotEmpty) {
            setState(() {
              if (mounted) {
                previousOrderDeals = nextPageData.previousDeal!;
              }
            });
          } else {
            setState(() {
              if (mounted) {
                hasMoreData = false;
                previousOrderDeals.clear();
              }
            });
          }

          if (nextPageData.favoriteDeals != null &&
              nextPageData.favoriteDeals!.isNotEmpty) {
            setState(() {
              if (mounted) {
                favoriteStoresAndDeals = nextPageData.favoriteDeals!;
              }
            });
          } else {
            setState(() {
              if (mounted) {
                hasMoreData = false;
                favoriteStoresAndDeals.clear();
              }
            });
          }

          if (nextPageData.paymentCard != null &&
              nextPageData.paymentCard!.isNotEmpty) {
            setState(() {
              if (mounted) {
                cardListData = nextPageData.paymentCard!;
              }
            });
          } else {
            setState(() {
              if (mounted) {
                hasMoreData = false;
                cardListData.clear();
              }
            });
          }
        } catch (error) {
          // Display error message
        } finally {
          setState(() {
            isLoading = false;
          });
        }
      }



    },);



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 5.0, right: 25, left: 25, bottom: 10),
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
                    const SizedBox(height: 20),
                    getView(context),
                  ],
                );
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              // Show a loading indicator while fetching data
              return const Center(child: CircularProgressIndicator());
            } else {
              return Container(); // Handle other connection states if needed
            }
          },
        ),
      ),
    );
  }

  Widget buildSection(String title, String viewAllText) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 15.0, top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
              text: title,
              color: btnbgColor,
              fontfamilly: montHeavy,
              sizeOfFont: 20),
          GestureDetector(
            child: CustomText(
              text: viewAllText,
              color: viewallColor,
              fontfamilly: montRegular,
              sizeOfFont: 12,
            ),
            onTap: () {
              if (title == "CURRENT ORDERS") {
                Navigator.pushNamed(
                    navigatorKey.currentContext!, '/MyOrdersScreen');
              } else if (title == "PREVIOUS ORDERS") {
                Navigator.pushNamed(
                    navigatorKey.currentContext!, '/PreviousOrderScreen');
              } else if (title == "MY FAVOURITES") {
                Navigator.pushNamed(
                    navigatorKey.currentContext!, '/FavouriteScreen');
              } else {
                Navigator.pushNamed(
                    navigatorKey.currentContext!, '/PaymentMethodScreen');
              }
            },
          ),
        ],
      ),
    );
  }

  Widget getView(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                selectedImagePathController.text != ''
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.network(
                          selectedImagePathController.text,
                          fit: BoxFit.cover,
                          height: 94,
                          width: 95,
                        ))
                    : Image.asset(
                        profile,
                        height: 94,
                        width: 95,
                      ),

                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: fullNameController.text,
                      color: viewallColor,
                      sizeOfFont: 20,
                      fontfamilly: montBold,
                    ),
                    CustomText(
                      text: emailController.text,
                      maxLin: 1,
                      sizeOfFont: 13,
                      fontfamilly: montRegular,
                      color: viewallColor,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 3),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: editprofilbgColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 1, color: Colors.white),
                      ),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(navigatorKey.currentContext!,
                                '/EditProfileScreen');
                          },
                          child: const CustomText(
                            text: "EDIT PROFILE",
                            sizeOfFont: 10,
                            fontfamilly: montBold,
                            color: editprofileColor,
                          )),
                    )
                  ],
                ),
                // profileSection()
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            buildSection("CURRENT ORDERS", viewAll),
            const SizedBox(
              height: 5,
            ),
            // getCards(bclor: onboardingBtn),

            buildCurrentOrderCards(),

            buildSection("PREVIOUS ORDERS", viewAll),
            const SizedBox(
              height: 5,
            ),

            buildPreviousOrderCards(),

            buildSection("MY FAVOURITES", viewAll),
            const SizedBox(
              height: 5,
            ),
            buildMyFavoriteCards(),

            buildSection("PAYMENT METHOD", viewAll),
            const SizedBox(
              height: 5,
            ),
            getMasterCard()
          ],
        ),
      ),
    );
  }

  Widget buildCurrentOrderCards() {
    return
      SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child:

      Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          // Limit the number of items to 2
          min(2, currentOrderDeals.length),
          (index) => GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                navigatorKey.currentContext!,
                '/YourOrderScreen',
                arguments:
                    currentOrderDeals[index], // Pass the data as arguments
              );
            },
            child: getCurrentDealsDataData(index, currentOrderDeals[index]),
          ),
        ),
      ),
    );
  }

  Widget getCurrentDealsDataData(int index, CurrentDeal lastMinuteDeal) {
    var currentDay = DateTime.now().weekday;
    var startTiming = '';
    var endTiming = '';

    if (currentDay == 1) {
      startTiming = lastMinuteDeal.store?.openingHour?.monday?.start ?? '';
      endTiming = lastMinuteDeal.store?.openingHour?.monday?.end ?? '';
    } else if (currentDay == 2) {
      startTiming = lastMinuteDeal.store?.openingHour?.tuesday?.start ?? '';
      endTiming = lastMinuteDeal.store?.openingHour?.tuesday?.end ?? '';
    } else if (currentDay == 3) {
      startTiming = lastMinuteDeal.store?.openingHour?.wednesday?.start ?? '';
      endTiming = lastMinuteDeal.store?.openingHour?.wednesday?.end ?? '';
    } else if (currentDay == 4) {
      startTiming = lastMinuteDeal.store?.openingHour?.thursday?.start ?? '';
      endTiming = lastMinuteDeal.store?.openingHour?.thursday?.end ?? '';
    } else if (currentDay == 5) {
      startTiming = lastMinuteDeal.store?.openingHour?.friday?.start ?? '';
      endTiming = lastMinuteDeal.store?.openingHour?.friday?.end ?? '';
    } else if (currentDay == 6) {
      startTiming = lastMinuteDeal.store?.openingHour?.saturday?.start ?? '';
      endTiming = lastMinuteDeal.store?.openingHour?.saturday?.end ?? '';
    } else if (currentDay == 7) {
      startTiming = lastMinuteDeal.store?.openingHour?.sunday?.start ?? '';
      endTiming = lastMinuteDeal.store?.openingHour?.sunday?.end ?? '';
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 0,
          color: editbgColor.withOpacity(0.25),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: lastMinuteDeal.name ?? '',
                  color: btntxtColor,
                  fontfamilly: montBold,
                  sizeOfFont: 18,
                ),
                CustomText(
                  text: lastMinuteDeal.store?.name ?? '',
                  color: btntxtColor,
                  fontfamilly: montRegular,
                  sizeOfFont: 13,
                ),
                CustomText(
                    text: '$startTiming - $endTiming',
                    color: graysColor,
                    sizeOfFont: 12,
                    fontfamilly: montRegular),
                const SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      decoration: BoxDecoration(
                        color: readybgColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 1, color: Colors.white),
                      ),
                      child: CustomText(
                        text: lastMinuteDeal.status == 0
                            ? "PENDING"
                            : "READY FOR PICKUP",
                        maxLin: 1,
                        sizeOfFont: 9,
                        fontfamilly: montHeavy,
                        color: readyColor,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                     CustomText(
                        text: '${lastMinuteDeal.store?.distanceKm} Km',
                        color: graysColor,
                        sizeOfFont: 12,
                        fontfamilly: montSemiBold),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                CustomText(
                  text: '\$ ${lastMinuteDeal.price ?? "NA"}',
                  color: dolorColor,
                  sizeOfFont: 24,
                  fontfamilly: montHeavy,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 18,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Stack(
              alignment: Alignment.topRight,
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white,
                          Colors.grey
                        ], // Adjust colors as needed
                      ),
                    ),
                    child: lastMinuteDeal.profileImage != null &&
                            !(lastMinuteDeal.profileImage)!
                                .contains("SocketException")
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.network(
                              lastMinuteDeal.profileImage!,
                              fit: BoxFit.cover,
                              height: 100,
                              width: 100,
                            ))
                        : Image.asset(
                            food_image,
                            height: 100,
                            width: 100,
                          ),
                  ),
                ),
                Positioned(
                  right: -4,
                  child: GestureDetector(
                    onTap: () async {
                      int? dealId = lastMinuteDeal.id;

                      try {
                        if (lastMinuteDeal.favourite == false) {
                          // Only hit the API if data.favourite is true
                          var formData = {
                            'favourite': 1,
                          };

                          FavAddedResponse favData =
                              await Provider.of<FavoriteOperationProvider>(
                                      context,
                                      listen: false)
                                  .AddToFavoriteDeal(dealId ?? 0, formData);

                          if (favData.status == true &&
                              favData.message ==
                                  "Deal Added in favourite successfully.") {
                            // Print data to console

                            final snackBar = SnackBar(
                              content: Text('${favData.message}'),
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

                            setState(() {
                              lastMinuteDeal.favourite = true;
                            });

                            await refreshData();
                          } else {
                            // API call failed

                            final snackBar = SnackBar(
                              content: Text('${favData.message}'),
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
                        } else if (lastMinuteDeal.favourite == true) {
                          // If data.favourite is false, print its value
                          FavDeleteResponse delData = await Provider.of<
                                      FavoriteOperationProvider>(context,
                                  listen: false)
                              .RemoveFromFavoriteDeal(lastMinuteDeal.id ?? 0);

                          if (delData.status == true &&
                              delData.message ==
                                  "Favourite Deal deleted successfully.") {
                            // Print data to console

                            final snackBar = SnackBar(
                              content: Text('${delData.message}'),
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

                            setState(() {
                              lastMinuteDeal.favourite = false;
                            });

                            await refreshData();
                          } else {
                            // API call failed

                            final snackBar = SnackBar(
                              content: Text('${delData.message}'),
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
                        }
                      } catch (e) {
                        // Display error message
                      }
                    },
                    child: Image.asset(
                      height: 15,
                      width: 18,
                      lastMinuteDeal.favourite == true
                          ? save_icon_red
                          : save_icon,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPreviousOrderCards() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          previousOrderDeals.length,
          (index) => GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  navigatorKey.currentContext!,
                  '/OrderAndPayScreen',
                  arguments:
                      previousOrderDeals[index], // Pass the data as arguments
                );
              },
              child: getPreviousOrderData(index, previousOrderDeals[index])),
        ),
      ),
    );
  }

  Widget getMasterCard() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          // Limit the number of items to 2
          min(2, cardListData.length),
          (index) => GestureDetector(
            child: getMasterCardData(index, cardListData[index]),
          ),
        ),
      ),
    );
  }

  Widget getMasterCardData(int index, PaymentCard cardListData) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 0,
          color: editbgColor.withOpacity(0.25),
        ),
      ),
      child: Row(
        children: [
          cardListData.imagePath != null &&
                  !(cardListData.imagePath)!.contains("SocketException")
              ? Container(
                  child: ClipRRect(
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0, // Adjust the width as needed
                        ),
                      ),
                      child: Image.network(
                        cardListData.imagePath!,
                        fit: BoxFit.cover,
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                )
              : Image.asset(
                  food_image,
                  height: 40,
                  width: 70,
                ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: CustomText(
            text: cardListData.cardType ?? "",
            color: viewallColor,
            sizeOfFont: 14,
            fontfamilly: montBold,
          )),
          CustomText(
            text:
                '- ${cardListData.cardNumber?.substring(cardListData.cardNumber!.length - 4, cardListData.cardNumber!.length)}',
            color: viewallColor,
            sizeOfFont: 14,
            fontfamilly: montRegular,
          ),
        ],
      ),
    );
  }

  Widget getPreviousOrderData(int index, DealData lastMinuteDeal) {
    var currentDay = DateTime.now().weekday;
    var startTiming = '';
    var endTiming = '';

    if (currentDay == 1) {
      startTiming = lastMinuteDeal.store?.openingHour?.monday?.start ?? '';
      endTiming = lastMinuteDeal.store?.openingHour?.monday?.end ?? '';
    } else if (currentDay == 2) {
      startTiming = lastMinuteDeal.store?.openingHour?.tuesday?.start ?? '';
      endTiming = lastMinuteDeal.store?.openingHour?.tuesday?.end ?? '';
    } else if (currentDay == 3) {
      startTiming = lastMinuteDeal.store?.openingHour?.wednesday?.start ?? '';
      endTiming = lastMinuteDeal.store?.openingHour?.wednesday?.end ?? '';
    } else if (currentDay == 4) {
      startTiming = lastMinuteDeal.store?.openingHour?.thursday?.start ?? '';
      endTiming = lastMinuteDeal.store?.openingHour?.thursday?.end ?? '';
    } else if (currentDay == 5) {
      startTiming = lastMinuteDeal.store?.openingHour?.friday?.start ?? '';
      endTiming = lastMinuteDeal.store?.openingHour?.friday?.end ?? '';
    } else if (currentDay == 6) {
      startTiming = lastMinuteDeal.store?.openingHour?.saturday?.start ?? '';
      endTiming = lastMinuteDeal.store?.openingHour?.saturday?.end ?? '';
    } else if (currentDay == 7) {
      startTiming = lastMinuteDeal.store?.openingHour?.sunday?.start ?? '';
      endTiming = lastMinuteDeal.store?.openingHour?.sunday?.end ?? '';
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 0,
          color: editbgColor.withOpacity(0.25),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: lastMinuteDeal.name ?? '',
                color: btntxtColor,
                fontfamilly: montBold,
                sizeOfFont: 18,
              ),
              CustomText(
                text: lastMinuteDeal.store?.name ?? '',
                color: btntxtColor,
                fontfamilly: montRegular,
                sizeOfFont: 13,
              ),
              CustomText(
                  text: '$startTiming - $endTiming',
                  color: graysColor,
                  sizeOfFont: 12,
                  fontfamilly: montRegular),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  RatingBar.readOnly(
                    filledIcon: Icons.star,
                    emptyIcon: Icons.star_border,
                    halfFilledIcon: Icons.star_half,
                    isHalfAllowed: true,
                    halfFilledColor: btnbgColor,
                    filledColor: btnbgColor,
                    size: 20,
                    initialRating:
                        double.parse(lastMinuteDeal.averageRating ?? '0'),
                    maxRating: 5,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                   CustomText(
                      text: '${lastMinuteDeal.store?.distanceKm} Km',
                      color: graysColor,
                      sizeOfFont: 12,
                      fontfamilly: montSemiBold),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              CustomText(
                text: '\$ ${lastMinuteDeal.price ?? "NA"}',
                color: dolorColor,
                sizeOfFont: 24,
                fontfamilly: montHeavy,
              ),
            ],
          ),
          const SizedBox(
            width: 18,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Stack(
              alignment: Alignment.topRight,
              clipBehavior: Clip.none,
              children: [
                // lastMinuteDeal.profileImage != null ? ClipRRect(
                //     borderRadius: BorderRadius.circular(15.0),
                //     child: Image.network(
                //       lastMinuteDeal.profileImage!,
                //       fit: BoxFit.cover,
                //       height: 120, width: 100,
                //     )
                // ): Image.asset(food_image,height: 100, width: 100,),

                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white,
                          Colors.grey
                        ], // Adjust colors as needed
                      ),
                    ),
                    child: lastMinuteDeal.profileImage != null &&
                            !(lastMinuteDeal.profileImage)!
                                .contains("SocketException")
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.network(
                              lastMinuteDeal.profileImage!,
                              fit: BoxFit.cover,
                              height: 100,
                              width: 100,
                            ))
                        : Image.asset(
                            food_image,
                            height: 100,
                            width: 100,
                          ),
                  ),
                ),
                Positioned(
                  right: -4,
                  child: GestureDetector(
                    onTap: () async {
                      int? dealId = lastMinuteDeal.id;

                      try {
                        if (lastMinuteDeal.favourite == false) {
                          // Only hit the API if data.favourite is true
                          var formData = {
                            'favourite': 1,
                          };

                          FavAddedResponse favData =
                              await Provider.of<FavoriteOperationProvider>(
                                      context,
                                      listen: false)
                                  .AddToFavoriteDeal(dealId ?? 0, formData);

                          if (favData.status == true &&
                              favData.message ==
                                  "Deal Added in favourite successfully.") {
                            // Print data to console

                            final snackBar = SnackBar(
                              content: Text('${favData.message}'),
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

                            setState(() {
                              lastMinuteDeal.favourite = true;
                            });

                            await refreshData();
                          } else {
                            // API call failed

                            final snackBar = SnackBar(
                              content: Text('${favData.message}'),
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
                        } else if (lastMinuteDeal.favourite == true) {
                          // If data.favourite is false, print its value
                          FavDeleteResponse delData = await Provider.of<
                                      FavoriteOperationProvider>(context,
                                  listen: false)
                              .RemoveFromFavoriteDeal(lastMinuteDeal.id ?? 0);

                          if (delData.status == true &&
                              delData.message ==
                                  "Favourite Deal deleted successfully.") {
                            // Print data to console

                            final snackBar = SnackBar(
                              content: Text('${delData.message}'),
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

                            setState(() {
                              lastMinuteDeal.favourite = false;
                            });

                            await refreshData();
                          } else {
                            // API call failed

                            final snackBar = SnackBar(
                              content: Text('${delData.message}'),
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
                        }
                      } catch (e) {
                        // Display error message
                      }
                    },
                    child: Image.asset(
                      height: 15,
                      width: 18,
                      lastMinuteDeal.favourite == true
                          ? save_icon_red
                          : save_icon,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMyFavoriteCards() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          favoriteStoresAndDeals.length,
          (index) => GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  navigatorKey.currentContext!,
                  '/OrderAndPayScreen',
                  arguments: favoriteStoresAndDeals[
                      index], // Pass the data as arguments
                );
              },
              child: getFavCardData(index, favoriteStoresAndDeals[index])),
        ),
      ),
    );
  }

  Widget getFavCardData(int index, DealData lastMinuteDeal) {
    var currentDay = DateTime.now().weekday;
    var startTiming = '';
    var endTiming = '';

    if (currentDay == 1) {
      startTiming = lastMinuteDeal.store?.openingHour?.monday?.start ?? '';
      endTiming = lastMinuteDeal.store?.openingHour?.monday?.end ?? '';
    } else if (currentDay == 2) {
      startTiming = lastMinuteDeal.store?.openingHour?.tuesday?.start ?? '';
      endTiming = lastMinuteDeal.store?.openingHour?.tuesday?.end ?? '';
    } else if (currentDay == 3) {
      startTiming = lastMinuteDeal.store?.openingHour?.wednesday?.start ?? '';
      endTiming = lastMinuteDeal.store?.openingHour?.wednesday?.end ?? '';
    } else if (currentDay == 4) {
      startTiming = lastMinuteDeal.store?.openingHour?.thursday?.start ?? '';
      endTiming = lastMinuteDeal.store?.openingHour?.thursday?.end ?? '';
    } else if (currentDay == 5) {
      startTiming = lastMinuteDeal.store?.openingHour?.friday?.start ?? '';
      endTiming = lastMinuteDeal.store?.openingHour?.friday?.end ?? '';
    } else if (currentDay == 6) {
      startTiming = lastMinuteDeal.store?.openingHour?.saturday?.start ?? '';
      endTiming = lastMinuteDeal.store?.openingHour?.saturday?.end ?? '';
    } else if (currentDay == 7) {
      startTiming = lastMinuteDeal.store?.openingHour?.sunday?.start ?? '';
      endTiming = lastMinuteDeal.store?.openingHour?.sunday?.end ?? '';
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 0,
          color: editbgColor.withOpacity(0.25),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: lastMinuteDeal.name ?? '',
                color: btntxtColor,
                fontfamilly: montBold,
                sizeOfFont: 18,
              ),
              CustomText(
                text: lastMinuteDeal.store?.name ?? '',
                color: btntxtColor,
                fontfamilly: montRegular,
                sizeOfFont: 13,
              ),
              CustomText(
                  text: '$startTiming - $endTiming',
                  color: graysColor,
                  sizeOfFont: 12,
                  fontfamilly: montRegular),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  RatingBar.readOnly(
                    filledIcon: Icons.star,
                    emptyIcon: Icons.star_border,
                    halfFilledIcon: Icons.star_half,
                    isHalfAllowed: true,
                    halfFilledColor: btnbgColor,
                    filledColor: btnbgColor,
                    size: 20,
                    initialRating:
                        double.parse(lastMinuteDeal.averageRating ?? '0'),
                    maxRating: 5,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                   CustomText(
                      text: '${lastMinuteDeal.store?.distanceKm} Km',
                      color: graysColor,
                      sizeOfFont: 12,
                      fontfamilly: montSemiBold),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              CustomText(
                text: '\$ ${lastMinuteDeal.price ?? "NA"}',
                color: dolorColor,
                sizeOfFont: 24,
                fontfamilly: montHeavy,
              ),
            ],
          ),
          const SizedBox(
            width: 18,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Stack(
              alignment: Alignment.topRight,
              clipBehavior: Clip.none,
              children: [
                // lastMinuteDeal.profileImage != null ? ClipRRect(
                //     borderRadius: BorderRadius.circular(15.0),
                //     child: Image.network(
                //       lastMinuteDeal.profileImage!,
                //       fit: BoxFit.cover,
                //       height: 120, width: 100,
                //     )
                // ): Image.asset(food_image,height: 100, width: 100,),

                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white,
                          Colors.grey
                        ], // Adjust colors as needed
                      ),
                    ),
                    child: lastMinuteDeal.profileImage != null &&
                            !(lastMinuteDeal.profileImage)!
                                .contains("SocketException")
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.network(
                              lastMinuteDeal.profileImage!,
                              fit: BoxFit.cover,
                              height: 100,
                              width: 100,
                            ))
                        : Image.asset(
                            food_image,
                            height: 100,
                            width: 100,
                          ),
                  ),
                ),
                Positioned(
                  right: -4,
                  child: GestureDetector(
                    onTap: () async {
                      int? dealId = lastMinuteDeal.id;

                      try {
                        if (lastMinuteDeal.favourite == false) {
                          // Only hit the API if data.favourite is true
                          var formData = {
                            'favourite': 1,
                          };

                          FavAddedResponse favData =
                              await Provider.of<FavoriteOperationProvider>(
                                      context,
                                      listen: false)
                                  .AddToFavoriteDeal(dealId ?? 0, formData);

                          if (favData.status == true &&
                              favData.message ==
                                  "Deal Added in favourite successfully.") {
                            // Print data to console

                            final snackBar = SnackBar(
                              content: Text('${favData.message}'),
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

                            setState(() {
                              lastMinuteDeal.favourite = true;
                            });

                            await refreshData();
                          } else {
                            // API call failed

                            final snackBar = SnackBar(
                              content: Text('${favData.message}'),
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
                        } else if (lastMinuteDeal.favourite == true) {
                          // If data.favourite is false, print its value
                          FavDeleteResponse delData = await Provider.of<
                                      FavoriteOperationProvider>(context,
                                  listen: false)
                              .RemoveFromFavoriteDeal(lastMinuteDeal.id ?? 0);

                          if (delData.status == true &&
                              delData.message ==
                                  "Favourite Deal deleted successfully.") {
                            // Print data to console

                            final snackBar = SnackBar(
                              content: Text('${delData.message}'),
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

                            setState(() {
                              lastMinuteDeal.favourite = false;
                            });

                            await refreshData();
                          } else {
                            // API call failed

                            final snackBar = SnackBar(
                              content: Text('${delData.message}'),
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
                        }
                      } catch (e) {
                        // Display error message
                      }
                    },
                    child: Image.asset(
                      height: 15,
                      width: 18,
                      lastMinuteDeal.favourite == true
                          ? save_icon_red
                          : save_icon,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> refreshData() async {


    var lat = await Utility.getStringValue(RequestString.LATITUDE);
    var long = await Utility.getStringValue(RequestString.LONGITUDE);


    var formData = {
      RequestString.LATITUDE: lat,
      RequestString.LONGITUDE: long,

    };


    final nextPageData = await homeProvider.getProfilePageData(
      formData,
      page: currentPage,
    );

    if (nextPageData.currentDeal != null &&
        nextPageData.currentDeal!.isNotEmpty) {
      // currentPage++;

      setState(() {
        if (mounted) {
          currentOrderDeals = nextPageData.currentDeal!;
        }
      });
    } else {
      setState(() {
        if (mounted) {
          hasMoreData = false;
          currentOrderDeals.clear();
        }
      });
    }

    if (nextPageData.previousDeal != null &&
        nextPageData.previousDeal!.isNotEmpty) {
      setState(() {
        if (mounted) {
          previousOrderDeals = nextPageData.previousDeal!;
        }
      });
    } else {
      setState(() {
        if (mounted) {
          hasMoreData = false;
          previousOrderDeals.clear();
        }
      });
    }
    //
    if (nextPageData.favoriteDeals != null &&
        nextPageData.favoriteDeals!.isNotEmpty) {
      setState(() {
        if (mounted) {
          favoriteStoresAndDeals = nextPageData.favoriteDeals!;
        }
      });
    } else {
      setState(() {
        if (mounted) {
          hasMoreData = false;
          favoriteStoresAndDeals.clear();
        }
      });
    }

    if (nextPageData.paymentCard != null &&
        nextPageData.paymentCard!.isNotEmpty) {
      setState(() {
        if (mounted) {
          cardListData = nextPageData.paymentCard!;
        }
      });
    } else {
      setState(() {
        if (mounted) {
          hasMoreData = false;
          cardListData.clear();
        }
      });
    }
  }
}
