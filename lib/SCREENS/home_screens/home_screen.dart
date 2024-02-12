import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/app_images.dart';
import 'package:takeaplate/UTILS/app_strings.dart';
import 'package:takeaplate/UTILS/fontfamily_string.dart';
import 'package:takeaplate/main.dart';
import '../../MULTI-PROVIDER/FavoriteOperationProvider.dart';
import '../../MULTI-PROVIDER/HomeDataListProvider.dart';
import '../../MULTI-PROVIDER/RestaurantsListProvider.dart';
import '../../Response_Model/CategoryFilterResponse.dart';
import '../../Response_Model/FavAddedResponse.dart';
import '../../Response_Model/FavDeleteResponse.dart';
import '../../Response_Model/RestaurantDealResponse.dart';
import '../../Response_Model/RestaurantsListResponse.dart';
import 'base_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FocusNode _searchFocusNode = FocusNode();

  final List<String> items = [
    'Healthy',
    'Sushi',
    'Desserts',
    'Sugar',
    'Sweets'
  ];

  final HomeDataListProvider homeProvider = HomeDataListProvider();
  bool isFavorite = false;
  int currentPage = 1;
  bool isLoading = false;
  bool hasMoreData = true;
  int selectedCardIndex = -1;

  bool isFilterLoading = false;
  bool hasFilterMoreData = true;

  final RestaurantsListProvider restaurantsProvider = RestaurantsListProvider();

  List<StoreData> closestRestaurants = [];
  List<DealData> lastMinuteDeals = [];
  List<StoreData> favoriteStoresAndDeals = [];
  List<DealData> collectTomorrowList = [];
  List<FilterData> filterList = [];

  int dataId = 0;

  String _latitude = 'Unknown';
  String _longitude = 'Unknown';

  @override
  void initState() {
    super.initState();
    _loadData(dataId);
    _loadFilterData();
    _getLocation();
  }

  Future<void> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    // Request location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return;
    }

    try {
      // Get the current location
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      setState(() {
        _latitude = '${position.latitude}';
        _longitude = '${position.longitude}';
      });

      print(
          'Coordinates : \n _________\n Latitude: $_latitude \n Longitude: $_longitude');
    } catch (e) {
      print(e);
    }
  }

  void _loadData(int dataId) async {
    Future.delayed(
      Duration.zero,
      () async {
        if (!isLoading && hasMoreData) {
          try {
            setState(() {
              isLoading = true;
            });

            final nextPageData =
                await homeProvider.getHomePageList(page: currentPage, dataId);

            if (nextPageData.data != null && nextPageData.data!.isNotEmpty) {
              currentPage++;

              setState(() {
                if (mounted) {
                  closestRestaurants = nextPageData.data!;
                }
              });
            } else {
              setState(() {
                if (mounted) {
                  hasMoreData = false;
                  closestRestaurants.clear();
                }
              });
            }

            if (nextPageData.dealData != null &&
                nextPageData.dealData!.isNotEmpty) {
              setState(() {
                if (mounted) {
                  lastMinuteDeals = nextPageData.dealData!;
                }
              });
            } else {
              setState(() {
                if (mounted) {
                  hasMoreData = false;
                  lastMinuteDeals.clear();
                }
              });
            }

            if (nextPageData.favoriteStores != null &&
                nextPageData.favoriteStores!.isNotEmpty) {
              setState(() {
                if (mounted) {
                  favoriteStoresAndDeals = nextPageData.favoriteStores!;
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

            if (nextPageData.collectTomorrow != null &&
                nextPageData.collectTomorrow!.isNotEmpty) {
              setState(() {
                if (mounted) {
                  collectTomorrowList = nextPageData.collectTomorrow!;
                }
              });
            } else {
              setState(() {
                if (mounted) {
                  hasMoreData = false;
                  collectTomorrowList.clear();
                }
              });
            }
          } catch (error) {
            //
          } finally {
            setState(() {
              isLoading = false;
            });
          }
        }
      },
    );
  }

  void _loadFilterData() async {
    if (!isFilterLoading && hasFilterMoreData) {
      try {
        setState(() {
          isFilterLoading = true;
        });

        final filterData = await homeProvider.getCategoryFilterData();

        if (filterData.data != null && filterData.data!.isNotEmpty) {
          setState(() {
            if (mounted) {
              filterList = filterData.data!;
            }
          });
        } else {
          setState(() {
            if (mounted) {
              hasFilterMoreData = false;
              filterList.clear();
            }
          });
        }
      } catch (error) {
        //
      } finally {
        setState(() {
          isFilterLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        backgroundColor: bgColor,
        body: Padding(
          padding:
              const EdgeInsets.only(top: 9.0, right: 20, left: 20, bottom: 10),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.text,
                readOnly: true,
                focusNode: _searchFocusNode,
                textAlign: TextAlign.start,
                //  focusNode: focusNode,
                style: const TextStyle(
                  fontSize: 18,
                  color: hintColor,
                  fontFamily: montBook,
                ),
                autofocus: false,

                decoration: InputDecoration(
                  filled: true,
                  fillColor: editbgColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: const Padding(
                    padding: EdgeInsets.only(right: 20.0, top: 10, bottom: 10),
                    child: Icon(Icons.search, color: hintColor, size: 25),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
                  hintStyle: const TextStyle(
                    color: hintColor,
                    fontFamily: montBook,
                    fontSize: 18,
                  ),
                  hintText: "Search",
                ),
                onTap: () {
                  // Navigate to login screen

                  BaseHome.isSearch = true;

                  Navigator.pushReplacementNamed(context, '/BaseHome');
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      buildHorizontalList(filterList),
                      buildSection(
                          closet, closestRestaurants.isNotEmpty ? viewAll : ""),
                      buildClosestDealCards(),
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, left: 20, right: 20, bottom: 15),
                        child: Divider(
                          color: Colors.grey,
                          thickness: 0,
                        ),
                      ),
                      buildSection(lastMinute,
                          lastMinuteDeals.isNotEmpty ? viewAll : ""),
                      buildLastMinuteDealCards(),
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, left: 15, right: 15, bottom: 15),
                        child: Divider(
                          color: Colors.grey,
                          thickness: 0,
                        ),
                      ),
                      buildSection(collectTomorrow,
                          collectTomorrowList.isNotEmpty ? viewAll : ""),
                      buildCollectTomorrowCards(),
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 10.0, left: 15, right: 15, bottom: 15),
                        child: Divider(
                          color: Colors.grey,
                          thickness: 0,
                        ),
                      ),
                      buildSection(myFav,
                          favoriteStoresAndDeals.isNotEmpty ? viewAll : ""),
                      buildMyFavoriteCards(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Visibility(
        visible: isLoading,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    ]);
  }

  Widget buildHorizontalList(List<FilterData> filterList) {
    if (filterList.isEmpty) {
      return const SizedBox
          .shrink(); // Return an empty widget if there's only 1 or no items
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          filterList.length - 1,
          (index) => GestureDetector(
            onTap: () async {
              setState(() {
                selectedCardIndex = index;
              });
              print('filterId - ${filterList[index + 1].id!}');

              dataId = filterList[index + 1].id!;
              await refreshData();
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 26),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              decoration: BoxDecoration(
                color: selectedCardIndex == index ? Colors.grey : editbgColor,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(width: 1, color: Colors.white),
              ),
              child: CustomText(
                text: filterList[index + 1].category ?? "",
                color: hintColor,
                fontfamilly: montBook,
                sizeOfFont: 19,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSection(String title, String viewAllText) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 13.0, top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
              text: title,
              color: btnbgColor,
              fontfamilly: montHeavy,
              sizeOfFont: 20),
          GestureDetector(
              onTap: () {
                if (title == closet) {
                  Navigator.pushNamed(
                      navigatorKey.currentContext!, '/ClosestScreen');
                } else if (title == lastMinute) {
                  Navigator.pushNamed(
                      navigatorKey.currentContext!, '/LastMinuteDealScreen');
                } else if (title == collectTomorrow) {
                  Navigator.pushNamed(
                      navigatorKey.currentContext!, '/CollectTomorrowScreen');
                } else if (title == myFav) {
                  Navigator.pushNamed(
                      navigatorKey.currentContext!, '/FavouriteScreen');
                }
              },
              child: CustomText(
                text: viewAllText,
                color: viewallColor,
                fontfamilly: montRegular,
                sizeOfFont: 12,
              )),
        ],
      ),
    );
  }

  Widget buildClosestDealCards() {
    if (closestRestaurants.isEmpty) {
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

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          closestRestaurants.length,
          (index) => GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  navigatorKey.currentContext!,
                  '/RestaurantsProfileScreen',
                  arguments:
                      closestRestaurants[index], // Pass the data as arguments
                );
              },
              child: getClosestDealData(index, closestRestaurants[index])),
        ),
      ),
    );
  }

  Widget getClosestDealData(int index, StoreData storeData) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 0, color: editbgColor.withOpacity(0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: storeData.name ?? '',
                color: btntxtColor,
                fontfamilly: montBold,
                sizeOfFont: 22,
              ),
              CustomText(
                text: storeData.category ?? '',
                color: btntxtColor,
                fontfamilly: montRegular,
                sizeOfFont: 14,
              ),
              const CustomText(
                text: '3 Offers available',
                color: offerColor,
                sizeOfFont: 12,
                fontfamilly: montBook,
              ),
              const SizedBox(height: 1),
              Row(
                children: [
                  const RatingBar.readOnly(
                    filledIcon: Icons.star,
                    emptyIcon: Icons.star_border,
                    halfFilledIcon: Icons.star_half,
                    isHalfAllowed: true,
                    halfFilledColor: btnbgColor,
                    filledColor: btnbgColor,
                    initialRating: 4,
                    size: 18,
                    maxRating: 5,
                  ),
                  const SizedBox(width: 10),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: editbgColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const CustomText(
                      text: "4 km",
                      maxLin: 1,
                      sizeOfFont: 10,
                      fontfamilly: montHeavy,
                      color: btnbgColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(width: 18),
          Stack(
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
                  child: storeData.profileImage != null &&
                          !(storeData.profileImage)!.contains("SocketException")
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.network(
                            storeData.profileImage!,
                            fit: BoxFit.cover,
                            height: 90,
                            width: 100,
                          ))
                      : Image.asset(
                          food_image,
                          height: 90,
                          width: 100,
                        ),
                ),
              ),
              Positioned(
                right: -4,
                child: GestureDetector(
                  onTap: () async {
                    bool? ratingStatus = storeData.favourite;

                    try {
                      if (ratingStatus == false) {
                        // Only hit the API if storeData.favourite is true
                        var formData = {
                          'favourite': 1,
                        };

                        FavAddedResponse favData =
                            await Provider.of<FavoriteOperationProvider>(
                                    context,
                                    listen: false)
                                .AddToFavoriteStore(
                                    storeData.id ?? 0, formData);

                        if (favData.status == true &&
                            favData.message ==
                                "Store Added in favourite successfully.") {
                          // Print data to console

                          final snackBar = SnackBar(
                            content: Text('${favData.message}'),
                          );

                          // Show the SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          // Automatically hide the SnackBar after 1 second
                          Future.delayed(const Duration(milliseconds: 1000),
                              () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          });

                          setState(() {
                            storeData.favourite = true;
                          });

                          await refreshData();
                        } else {
                          // API call failed

                          final snackBar = SnackBar(
                            content: Text('${favData.message}'),
                          );

                          // Show the SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          // Automatically hide the SnackBar after 1 second
                          Future.delayed(const Duration(milliseconds: 1000),
                              () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          });
                        }
                      } else if (storeData.favourite == true) {
                        // If storeData.favourite is false, print its value
                        FavDeleteResponse delData =
                            await Provider.of<FavoriteOperationProvider>(
                                    context,
                                    listen: false)
                                .RemoveFromFavoriteStore(storeData.id ?? 0);

                        if (delData.status == true &&
                            delData.message ==
                                "Favourite Store deleted successfully") {
                          // Print data to console

                          final snackBar = SnackBar(
                            content: Text('${delData.message}'),
                          );

                          // Show the SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          // Automatically hide the SnackBar after 1 second
                          Future.delayed(const Duration(milliseconds: 1000),
                              () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          });

                          setState(() {
                            storeData.favourite = false;
                          });

                          await refreshData();
                        } else {
                          // API call failed

                          final snackBar = SnackBar(
                            content: Text('${delData.message}'),
                          );

                          // Show the SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          // Automatically hide the SnackBar after 1 second
                          Future.delayed(const Duration(milliseconds: 1000),
                              () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
                    storeData.favourite == true ? save_icon_red : save_icon,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildLastMinuteDealCards() {
    if (lastMinuteDeals.isEmpty) {
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          lastMinuteDeals.length,
          (index) => GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  navigatorKey.currentContext!,
                  '/OrderAndPayScreen',
                  arguments:
                      lastMinuteDeals[index], // Pass the data as arguments
                );
              },
              child: getLastMinuteDealsData(index, lastMinuteDeals[index])),
        ),
      ),
    );
  }

  Widget getLastMinuteDealsData(int index, DealData lastMinuteDeal) {
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
                  const CustomText(
                      text: '8KM',
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

  Widget buildCollectTomorrowCards() {
    if (collectTomorrowList.isEmpty) {
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          collectTomorrowList.length,
          (index) => GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  navigatorKey.currentContext!,
                  '/OrderAndPayScreen',
                  arguments:
                      collectTomorrowList[index], // Pass the data as arguments
                );
              },
              child: getCollectTomorrowData(index, collectTomorrowList[index])),
        ),
      ),
    );
  }

  Widget getCollectTomorrowData(int index, DealData collectTomorrowData) {
    var currentDay = DateTime.now().weekday;
    var startTiming = '';
    var endTiming = '';

    if (currentDay == 1) {
      startTiming = collectTomorrowData.store?.openingHour?.monday?.start ?? '';
      endTiming = collectTomorrowData.store?.openingHour?.monday?.end ?? '';
    } else if (currentDay == 2) {
      startTiming =
          collectTomorrowData.store?.openingHour?.tuesday?.start ?? '';
      endTiming = collectTomorrowData.store?.openingHour?.tuesday?.end ?? '';
    } else if (currentDay == 3) {
      startTiming =
          collectTomorrowData.store?.openingHour?.wednesday?.start ?? '';
      endTiming = collectTomorrowData.store?.openingHour?.wednesday?.end ?? '';
    } else if (currentDay == 4) {
      startTiming =
          collectTomorrowData.store?.openingHour?.thursday?.start ?? '';
      endTiming = collectTomorrowData.store?.openingHour?.thursday?.end ?? '';
    } else if (currentDay == 5) {
      startTiming = collectTomorrowData.store?.openingHour?.friday?.start ?? '';
      endTiming = collectTomorrowData.store?.openingHour?.friday?.end ?? '';
    } else if (currentDay == 6) {
      startTiming =
          collectTomorrowData.store?.openingHour?.saturday?.start ?? '';
      endTiming = collectTomorrowData.store?.openingHour?.saturday?.end ?? '';
    } else if (currentDay == 7) {
      startTiming = collectTomorrowData.store?.openingHour?.sunday?.start ?? '';
      endTiming = collectTomorrowData.store?.openingHour?.sunday?.end ?? '';
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
                text: collectTomorrowData.name ?? '',
                color: btntxtColor,
                fontfamilly: montBold,
                sizeOfFont: 18,
              ),
              CustomText(
                text: collectTomorrowData.store?.name ?? '',
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
                        double.parse(collectTomorrowData.averageRating ?? '0'),
                    maxRating: 5,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const CustomText(
                      text: '8KM',
                      color: graysColor,
                      sizeOfFont: 12,
                      fontfamilly: montSemiBold),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              CustomText(
                text: '\$ ${collectTomorrowData.price ?? "NA"}',
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
                    child: collectTomorrowData.profileImage != null &&
                            !(collectTomorrowData.profileImage)!
                                .contains("SocketException")
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.network(
                              collectTomorrowData.profileImage!,
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
                      int? dealId = collectTomorrowData.id;

                      try {
                        if (collectTomorrowData.favourite == false) {
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
                              collectTomorrowData.favourite = true;
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
                        } else if (collectTomorrowData.favourite == true) {
                          // If data.favourite is false, print its value
                          FavDeleteResponse delData =
                              await Provider.of<FavoriteOperationProvider>(
                                      context,
                                      listen: false)
                                  .RemoveFromFavoriteDeal(
                                      collectTomorrowData.id ?? 0);

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
                              collectTomorrowData.favourite = false;
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
                      collectTomorrowData.favourite == true
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
    if (favoriteStoresAndDeals.isEmpty) {
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
                  '/RestaurantsProfileScreen',
                  arguments: favoriteStoresAndDeals[
                      index], // Pass the data as arguments
                );
              },
              child: getFavCardsData(index, favoriteStoresAndDeals[index])),
        ),
      ),
    );
  }

  Widget getFavCardsData(int index, StoreData favoriteStores) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 0, color: editbgColor.withOpacity(0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: favoriteStores.name ?? '',
                color: btntxtColor,
                fontfamilly: montBold,
                sizeOfFont: 22,
              ),
              CustomText(
                text: favoriteStores.category ?? '',
                color: btntxtColor,
                fontfamilly: montRegular,
                sizeOfFont: 14,
              ),
              const CustomText(
                text: '3 Offers available',
                color: offerColor,
                sizeOfFont: 12,
                fontfamilly: montBook,
              ),
              const SizedBox(height: 1),
              Row(
                children: [
                  const RatingBar.readOnly(
                    filledIcon: Icons.star,
                    emptyIcon: Icons.star_border,
                    halfFilledIcon: Icons.star_half,
                    isHalfAllowed: true,
                    halfFilledColor: btnbgColor,
                    filledColor: btnbgColor,
                    initialRating: 4,
                    size: 18,
                    maxRating: 5,
                  ),
                  const SizedBox(width: 10),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: editbgColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const CustomText(
                      text: "4 km",
                      maxLin: 1,
                      sizeOfFont: 10,
                      fontfamilly: montHeavy,
                      color: btnbgColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(width: 18),
          Stack(
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
                  child: favoriteStores.profileImage != null &&
                          !(favoriteStores.profileImage)!
                              .contains("SocketException")
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.network(
                            favoriteStores.profileImage!,
                            fit: BoxFit.cover,
                            height: 90,
                            width: 100,
                          ))
                      : Image.asset(
                          food_image,
                          height: 90,
                          width: 100,
                        ),
                ),
              ),
              Positioned(
                right: -4,
                child: GestureDetector(
                  onTap: () async {
                    bool? ratingStatus = favoriteStores.favourite;

                    try {
                      if (ratingStatus == false) {
                        // Only hit the API if storeData.favourite is true
                        var formData = {
                          'favourite': 1,
                        };

                        FavAddedResponse favData =
                            await Provider.of<FavoriteOperationProvider>(
                                    context,
                                    listen: false)
                                .AddToFavoriteStore(
                                    favoriteStores.id ?? 0, formData);

                        if (favData.status == true &&
                            favData.message ==
                                "Store Added in favourite successfully.") {
                          // Print data to console

                          final snackBar = SnackBar(
                            content: Text('${favData.message}'),
                          );

                          // Show the SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          // Automatically hide the SnackBar after 1 second
                          Future.delayed(const Duration(milliseconds: 1000),
                              () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          });

                          setState(() {
                            favoriteStores.favourite = true;
                          });

                          await refreshData();
                        } else {
                          // API call failed

                          final snackBar = SnackBar(
                            content: Text('${favData.message}'),
                          );

                          // Show the SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          // Automatically hide the SnackBar after 1 second
                          Future.delayed(const Duration(milliseconds: 1000),
                              () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          });
                        }
                      } else if (favoriteStores.favourite == true) {
                        // If storeData.favourite is false, print its value
                        FavDeleteResponse delData = await Provider.of<
                                    FavoriteOperationProvider>(context,
                                listen: false)
                            .RemoveFromFavoriteStore(favoriteStores.id ?? 0);

                        if (delData.status == true &&
                            delData.message ==
                                "Favourite Store deleted successfully") {
                          // Print data to console

                          final snackBar = SnackBar(
                            content: Text('${delData.message}'),
                          );

                          // Show the SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          // Automatically hide the SnackBar after 1 second
                          Future.delayed(const Duration(milliseconds: 1000),
                              () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          });

                          setState(() {
                            favoriteStores.favourite = false;
                          });

                          await refreshData();
                        } else {
                          // API call failed

                          final snackBar = SnackBar(
                            content: Text('${delData.message}'),
                          );

                          // Show the SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          // Automatically hide the SnackBar after 1 second
                          Future.delayed(const Duration(milliseconds: 1000),
                              () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
                    favoriteStores.favourite == true
                        ? save_icon_red
                        : save_icon,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> refreshData() async {
    final nextPageData =
        await homeProvider.getHomePageList(page: currentPage, dataId);

    if (nextPageData.data != null && nextPageData.data!.isNotEmpty) {
      currentPage++;

      setState(() {
        if (mounted) {
          closestRestaurants = nextPageData.data!;
        }
      });
    } else {
      setState(() {
        if (mounted) {
          hasMoreData = false;
          closestRestaurants.clear();
        }
      });
    }

    if (nextPageData.dealData != null && nextPageData.dealData!.isNotEmpty) {
      setState(() {
        if (mounted) {
          lastMinuteDeals = nextPageData.dealData!;
        }
      });
    } else {
      setState(() {
        if (mounted) {
          hasMoreData = false;
          lastMinuteDeals.clear();
        }
      });
    }

    if (nextPageData.favoriteStores != null &&
        nextPageData.favoriteStores!.isNotEmpty) {
      setState(() {
        if (mounted) {
          favoriteStoresAndDeals = nextPageData.favoriteStores!;
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

    if (nextPageData.collectTomorrow != null &&
        nextPageData.collectTomorrow!.isNotEmpty) {
      setState(() {
        if (mounted) {
          collectTomorrowList = nextPageData.collectTomorrow!;
        }
      });
    } else {
      setState(() {
        if (mounted) {
          hasMoreData = false;
          collectTomorrowList.clear();
        }
      });
    }
  }
}
