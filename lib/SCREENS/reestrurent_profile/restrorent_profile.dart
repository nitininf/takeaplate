import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:take_a_plate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:take_a_plate/main.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../MULTI-PROVIDER/FavoriteOperationProvider.dart';
import '../../MULTI-PROVIDER/RestaurantsListProvider.dart';
import '../../MULTI-PROVIDER/common_counter.dart';
import '../../Response_Model/FavAddedResponse.dart';
import '../../Response_Model/FavDeleteResponse.dart';
import '../../Response_Model/RestaurantsListResponse.dart';
import '../../Response_Model/RestaurantDealResponse.dart';
import '../../UTILS/app_color.dart';
import '../../UTILS/app_images.dart';
import '../../UTILS/fontfamily_string.dart';
import '../../UTILS/request_string.dart';
import '../../UTILS/utils.dart';

class RestaurantsProfileScreen extends StatefulWidget {
  RestaurantsProfileScreen({super.key, required this.context});

  BuildContext context;

  @override
  _RestaurantsProfileScreenState createState() =>
      _RestaurantsProfileScreenState();
}

class _RestaurantsProfileScreenState extends State<RestaurantsProfileScreen> {
  final RestaurantsListProvider restaurantsProvider = RestaurantsListProvider();
  bool isFavorite = false;
  int currentPage = 1;
  late StoreData data;
  bool isRefresh = false;

  bool isLoading = false;
  bool hasMoreData = true;
  List<DealData> dealListData = [];
  List<DealData> favouriteDealListData = [];

  List<DealData> dealList = [];
  List<DealData> favouriteDealList = [];

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    data = ModalRoute.of(widget.context)!.settings.arguments as StoreData;

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

          final nextPageData = await restaurantsProvider.getRestaurantsDealsList(
            data.id,formData,
            page: currentPage,
          );

          if (nextPageData.data != null && nextPageData.data!.isNotEmpty) {

            setState(() {
              if (mounted) {


                for (DealData deal in nextPageData.data!) {
                  if (deal.favourite == false) {
                    setState(() {
                      dealListData.add(deal);
                    });
                  } else if (deal.favourite == true) {
                    setState(() {
                      favouriteDealListData.add(deal);
                    });
                  }
                }

                if (isRefresh == true) {
                  dealListData.clear();
                  favouriteDealListData.clear();
                  dealListData.addAll(dealList);
                  isRefresh = false;
                  favouriteDealListData.addAll(favouriteDealList);
                  currentPage++;
                } else {
                  dealListData.addAll(dealList);
                  favouriteDealListData.addAll(favouriteDealList);
                  currentPage++;
                }
              }
            });
          } else {
            // No more data available
            setState(() {
              hasMoreData = false;

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



    },);




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
            mainAxisSize: MainAxisSize.min,
            children: [const CustomAppBar(), getView(data, data.id)],
          ),
        ),
      ),
    );
  }

  Widget getView(StoreData data, int? restaurantId) {
    return Consumer<CommonCounter>(builder: (context, commonProvider, child) {
      return Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            getCards(commonProvider, data),
            !commonProvider.isDeal
                ? buildSection("YOUR FAVOURITES", "")
                : buildSection("TODAY'S DEALS", ""),
            buildVerticalCards(commonProvider)
          ],
        ),
      );
    });
  }

  Widget buildSection(String title, String viewAllText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
              text: title,
              color: editbgColor,
              fontfamilly: montHeavy,
              sizeOfFont: 20),
          CustomText(
              text: viewAllText,
              color: Colors.black,
              fontfamilly: montLight,
              weight: FontWeight.w900),
        ],
      ),
    );
  }

  Widget getCards(CommonCounter commonCounter, StoreData data) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            data.bannerImage != null &&
                    !(data.bannerImage)!.contains("SocketException")
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(
                      data.bannerImage!,
                      fit: BoxFit.contain,
                      height: 200,
                    ),
                  )
                : Image.asset(restrorent_food),
            Positioned(
              bottom: -60,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                      navigatorKey.currentContext!, '/OrderAndPayScreen');
                },
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: imgbgColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 0, color: Colors.grey),
                  ),
                  child: Center(
                      child: Image.asset(restrorent_img, fit: BoxFit.fill)),
                ),
              ),
            ),
          ],
        ),
        // const SizedBox(height: 5,),
        Padding(
          padding: const EdgeInsets.only(right: 9.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: data.name ?? 'NA',
                      sizeOfFont: 18,
                      color: viewallColor,
                      fontfamilly: montBold,
                    ),
                    CustomText(
                        text: data.category ?? 'NA',
                        color: viewallColor,
                        sizeOfFont: 14,
                        fontfamilly: montRegular),
                    CustomText(
                        text: data.address ?? 'NA',
                        weight: FontWeight.w300,
                        sizeOfFont: 12,
                        color: viewallColor,
                        fontfamilly: montLight),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                      navigatorKey.currentContext!, '/OrderAndPayScreen');
                },
                child: const SizedBox(
                  width: 120,
                  height: 60,
                  child: Text(""),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(
          height: 5,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                RatingBar.readOnly(
                  filledIcon: Icons.star,
                  emptyIcon: Icons.star_border,
                  halfFilledIcon: Icons.star_half,
                  isHalfAllowed: true,
                  halfFilledColor: btnbgColor,
                  filledColor: btnbgColor,
                  initialRating: 4,
                  size: 20,
                  maxRating: 5,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        CustomText(
            text: data.description ?? 'NA',
            sizeOfFont: 10,
            color: onboardingbgColor,
            fontfamilly: montBook),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            commonCounter.isDeal
                ? Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: btnbgColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1, color: Colors.white),
                    ),
                    child: GestureDetector(
                        onTap: () {
                          commonCounter.gettodayDeal(false);
                        },
                        child: const CustomText(
                          text: "Deals",
                          sizeOfFont: 10,
                          fontfamilly: montBook,
                          color: hintColor,
                        )),
                  )
                : Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: btnbgColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1, color: Colors.white),
                    ),
                    child: GestureDetector(
                        onTap: () {
                          commonCounter.gettodayDeal(true);
                        },
                        child: const CustomText(
                          text: "Deals",
                          sizeOfFont: 10,
                          fontfamilly: montBook,
                          color: hintColor,
                        )),
                  ),
            const SizedBox(
              width: 8,
            ),
            !commonCounter.isDeal
                ? Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: btnbgColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1, color: Colors.white),
                    ),
                    child: GestureDetector(
                        onTap: () {
                          commonCounter.gettodayDeal(true);
                        },
                        child: const CustomText(
                          text: "Deals you loved",
                          sizeOfFont: 10,
                          fontfamilly: montBook,
                          color: hintColor,
                        )),
                  )
                : Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: btnbgColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1, color: Colors.white),
                    ),
                    child: GestureDetector(
                        onTap: () {
                          commonCounter.gettodayDeal(false);
                        },
                        child: const CustomText(
                          text: "Deals you loved",
                          sizeOfFont: 10,
                          fontfamilly: montBook,
                          color: hintColor,
                        )),
                  )
          ],
        )
      ],
    );
  }

  Widget buildVerticalCards(CommonCounter commonCounter) {
    List<DealData> currentList =
        commonCounter.isDeal ? dealListData : favouriteDealListData;

    return Expanded(
      child: RefreshIndicator(
        key: _refreshIndicatorKey,
        color: Colors.white,
        backgroundColor: editbgColor,
        strokeWidth: 4.0,
        onRefresh: _refreshData,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: currentList.length,
          itemBuilder: (context, index) {
            if (index < currentList.length) {
              // Display restaurant card
              return getFavCards(index, currentList[index]);
            } else {
              // Display loading indicator while fetching more data
              return FutureBuilder(
                  future: Future.delayed(const Duration(seconds: 3)),
                  builder: (context, snapshot) =>
                      snapshot.connectionState == ConnectionState.done
                          ? const SizedBox()
                          : const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(child: CircularProgressIndicator()),
                            ));
            }
          },
        ),
      ),
    );
  }

  Future<void> _refreshData() async {
    // Call your API here to refresh the data
    try {

      var lat = await Utility.getStringValue(RequestString.LATITUDE);
      var long = await Utility.getStringValue(RequestString.LONGITUDE);


      var formData = {
        RequestString.LATITUDE: lat,
        RequestString.LONGITUDE: long,

      };



      final nextPageData = await restaurantsProvider.getRestaurantsDealsList(
        data.id,formData,
        page: currentPage,
      );

      if (nextPageData.data != null && nextPageData.data!.isNotEmpty) {

        setState(() {

          isRefresh = true;
          if (mounted) {


            for (DealData deal in nextPageData.data!) {
              if (deal.favourite == false) {
                setState(() {
                  dealListData.add(deal);
                });
              } else if (deal.favourite == true) {
                setState(() {
                  favouriteDealListData.add(deal);
                });
              }
            }

            if (isRefresh == true) {
              dealListData.clear();
              favouriteDealListData.clear();
              dealListData.addAll(dealList);
              isRefresh = false;
              favouriteDealListData.addAll(favouriteDealList);
              currentPage++;
            } else {
              dealListData.addAll(dealList);
              favouriteDealListData.addAll(favouriteDealList);
              currentPage++;
            }
          }
        });
      } else {
        // No more data available
        setState(() {
          hasMoreData = false;

        });
      }

    } catch (error) {
      //
    }
  }

  Widget getFavCards(int index, DealData dealData) {
    var currentDay = DateTime.now().weekday;
    var startTiming = '';
    var endTiming = '';

    if (currentDay == 1) {
      startTiming = dealData.store?.openingHour?.monday?.start ?? '';
      endTiming = dealData.store?.openingHour?.monday?.end ?? '';
    } else if (currentDay == 2) {
      startTiming = dealData.store?.openingHour?.tuesday?.start ?? '';
      endTiming = dealData.store?.openingHour?.tuesday?.end ?? '';
    } else if (currentDay == 3) {
      startTiming = dealData.store?.openingHour?.wednesday?.start ?? '';
      endTiming = dealData.store?.openingHour?.wednesday?.end ?? '';
    } else if (currentDay == 4) {
      startTiming = dealData.store?.openingHour?.thursday?.start ?? '';
      endTiming = dealData.store?.openingHour?.thursday?.end ?? '';
    } else if (currentDay == 5) {
      startTiming = dealData.store?.openingHour?.friday?.start ?? '';
      endTiming = dealData.store?.openingHour?.friday?.end ?? '';
    } else if (currentDay == 6) {
      startTiming = dealData.store?.openingHour?.saturday?.start ?? '';
      endTiming = dealData.store?.openingHour?.saturday?.end ?? '';
    } else if (currentDay == 7) {
      startTiming = dealData.store?.openingHour?.sunday?.start ?? '';
      endTiming = dealData.store?.openingHour?.sunday?.end ?? '';
    }

    var storeData = dealData.store.toString();


    print('store:${storeData}\ndealData:${dealData.id}\nstoreId:${dealData.store?.id}\nkilometer:${dealData.store?.distanceKm}');

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          navigatorKey.currentContext!,
          '/OrderAndPayScreen',
          arguments: dealData,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 0, color: Colors.grey),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: dealData.name ?? "",
                    maxLin: 1,
                    color: btntxtColor,
                    fontfamilly: montBold,
                    sizeOfFont: 18,
                  ),
                  CustomText(
                    text: dealData.store?.name ?? "",
                    maxLin: 1,
                    color: btntxtColor,
                    fontfamilly: montRegular,
                    sizeOfFont: 14,
                  ),
                  CustomText(
                      text: '$startTiming - $endTiming',
                      maxLin: 1,
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
                        initialRating: double.parse(dealData.averageRating ?? '2'),
                        size: 18,
                        maxRating: 5,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                       Expanded(
                          child: CustomText(
                              text: '${data.distanceKm} Km',
                              maxLin: 1,
                              color: graysColor,
                              sizeOfFont: 12,
                              fontfamilly: montSemiBold)),
                    ],
                  ),
                  CustomText(
                    text: '\$ ${dealData.price ?? ""}',
                    color: dolorColor,
                    sizeOfFont: 20,
                    fontfamilly: montHeavy,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 18,
            ),
            Expanded(
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
                      child: dealData.profileImage != null &&
                              !(dealData.profileImage)!.contains("SocketException")
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network(
                                dealData.profileImage!,
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
                        int? dealId = dealData.id;
                        int? storeId = dealData.storeId;


                        try {
                          if (dealData.favourite == false) {
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
                              Future.delayed(const Duration(milliseconds: 1000), () {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                              });

                              setState(() {
                                dealData.favourite = true;
                              });

                              try {
                                var lat = await Utility.getStringValue(RequestString.LATITUDE);
                                var long = await Utility.getStringValue(RequestString.LONGITUDE);


                                var formData = {
                                  RequestString.LATITUDE: lat,
                                  RequestString.LONGITUDE: long,

                                };

                                final refreshedData = await restaurantsProvider
                                    .getRestaurantsDealsList(storeId,formData, page: 1);

                                if (refreshedData.data != null &&
                                    refreshedData.data!.isNotEmpty) {
                                  for (DealData deal in refreshedData.data!) {
                                    if (deal.favourite == false) {
                                      setState(() {
                                        dealListData =
                                            refreshedData as List<DealData>;
                                        currentPage =
                                            1; // Reset the page to 2 as you loaded the first page.
                                        hasMoreData =
                                            true; // Reset the flag for more data.
                                      });
                                    } else if (deal.favourite == true) {
                                      setState(() {
                                        favouriteDealListData =
                                            refreshedData as List<DealData>;

                                        currentPage =
                                            1; // Reset the page to 2 as you loaded the first page.
                                        hasMoreData =
                                            true; // Reset the flag for more data.
                                      });
                                    }
                                  }
                                } else {
                                  setState(() {
                                    hasMoreData = false;
                                    dealListData.clear();
                                    favouriteDealListData.clear();
                                  });
                                }
                              } catch (error) {
                                //
                              }
                            } else {
                              // API call failed

                              final snackBar = SnackBar(
                                content: Text('${favData.message}'),
                              );

                              // Show the SnackBar
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);

                              // Automatically hide the SnackBar after 1 second
                              Future.delayed(const Duration(milliseconds: 1000), () {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                              });
                            }
                          } else if (dealData.favourite == true) {
                            // If data.favourite is false, print its value
                            FavDeleteResponse delData =
                                await Provider.of<FavoriteOperationProvider>(
                                        context,
                                        listen: false)
                                    .RemoveFromFavoriteDeal(dealData.id ?? 0);

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
                              Future.delayed(const Duration(milliseconds: 1000), () {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                              });

                              setState(() {
                                dealData.favourite = false;
                              });

                              try {


                                var lat = await Utility.getStringValue(RequestString.LATITUDE);
                                var long = await Utility.getStringValue(RequestString.LONGITUDE);


                                var formData = {
                                  RequestString.LATITUDE: lat,
                                  RequestString.LONGITUDE: long,

                                };
                                final refreshedData = await restaurantsProvider
                                    .getRestaurantsDealsList(storeId,formData, page: 1);

                                if (refreshedData.data != null &&
                                    refreshedData.data!.isNotEmpty) {
                                  for (DealData deal in refreshedData.data!) {
                                    if (deal.favourite == false) {
                                      setState(() {
                                        dealListData =
                                            refreshedData as List<DealData>;
                                        currentPage =
                                            1; // Reset the page to 2 as you loaded the first page.
                                        hasMoreData =
                                            true; // Reset the flag for more data.
                                      });
                                    } else if (deal.favourite == true) {
                                      setState(() {
                                        favouriteDealListData =
                                            refreshedData as List<DealData>;

                                        currentPage =
                                            1; // Reset the page to 2 as you loaded the first page.
                                        hasMoreData =
                                            true; // Reset the flag for more data.
                                      });
                                    }
                                  }
                                } else {
                                  setState(() {
                                    hasMoreData = false;
                                    dealListData.clear();
                                    favouriteDealListData.clear();
                                  });
                                }
                              } catch (error) {
                              }
                            } else {
                              // API call failed

                              final snackBar = SnackBar(
                                content: Text('${delData.message}'),
                              );

                              // Show the SnackBar
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);

                              // Automatically hide the SnackBar after 1 second
                              Future.delayed(const Duration(milliseconds: 1000), () {
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
                        dealData.favourite == true ? save_icon_red : save_icon,
                      ),
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
}
