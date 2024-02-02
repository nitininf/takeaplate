import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_app_bar.dart';
import '../../MULTI-PROVIDER/FavoriteOperationProvider.dart';
import '../../MULTI-PROVIDER/SearchProvider.dart';
import '../../Response_Model/FavAddedResponse.dart';
import '../../Response_Model/FavDeleteResponse.dart';
import '../../Response_Model/RestaurantDealResponse.dart';
import '../../Response_Model/RestaurantsListResponse.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../MULTI-PROVIDER/RestaurantsListProvider.dart';
import '../../MULTI-PROVIDER/common_counter.dart';
import '../../UTILS/app_color.dart';
import '../../UTILS/app_images.dart';
import '../../UTILS/fontfamily_string.dart';
import '../../main.dart';

class SearchResultScreen extends StatefulWidget {
  SearchResultScreen({super.key, required this.context});

  BuildContext context;

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  final List<String> items = [
    'Healthy',
    'Sushi',
    'Desserts',
    'Sugar',
    'Sweets'
  ];
  final RestaurantsListProvider restaurantsProvider = RestaurantsListProvider();
  final SearchProvider searchProvider = SearchProvider();

  int isFavorite = 0;
  int currentRestaurantPage = 1;
  int currentDealPage = 1;
  bool isRestaurantLoading = false;
  bool isRefresh = false;
  bool isDealLoading = false;
  bool hasMoreData = true;
  List<StoreData> restaurantData = [];
  List<DealData> dealListingData = [];
  late var data;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_scrollListener);

    data = ModalRoute.of(widget.context)!.settings.arguments;

    _loadData(data);
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Reached the end of the list, load more data
      _loadData(data);
    }
  }

  void _loadData(Object? data) async {
    Future.delayed(
      Duration.zero,
      () async {
        if (!isRestaurantLoading && hasMoreData) {
          try {
            setState(() {
              isRestaurantLoading = true;
            });

            var formData = {"search_query": data};

            final searchQueryData =
                await searchProvider.getSearchQueryResultList(
              formData,
              page: currentRestaurantPage,
            );

            if (searchQueryData.stores != null &&
                searchQueryData.stores!.isNotEmpty) {
              setState(() {
                if (isRefresh == true) {
                  // restaurantData.clear();
                  // dealListingData.clear();

                  restaurantData.addAll(searchQueryData.stores!);
                  isRefresh = false;

                  currentRestaurantPage++;
                } else {
                  restaurantData.addAll(searchQueryData.stores!);

                  currentRestaurantPage++;
                }
              });
            }

            if (searchQueryData.deals != null &&
                searchQueryData.deals!.isNotEmpty) {
              setState(() {
                if (isRefresh == true) {
                  // restaurantData.clear();
                  // dealListingData.clear();

                  dealListingData.addAll(searchQueryData.deals!);
                  isRefresh = false;

                  currentDealPage++;
                } else {
                  dealListingData.addAll(searchQueryData.deals!);

                  currentDealPage++;
                }
              });
            }
          } catch (error) {
          } finally {
            setState(() {
              isRestaurantLoading = false;
            });
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {

        Navigator.of(context)
            .pushNamedAndRemoveUntil('/BaseHome', (Route route) => false);

        // Allow the back button action
        return true;
      },
      child: Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppBar(),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0, top: 26),
                  child: CustomText(
                      text: "SEARCH RESULTS",
                      color: btnbgColor,
                      fontfamilly: montHeavy,
                      sizeOfFont: 20),
                ),
                getView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getView() {
    return Consumer<CommonCounter>(builder: (context, commonProvider, child) {
      return Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            getCards(commonProvider),
            !commonProvider.isStore
                ? buildSection("AVAILABLE DEALS", "")
                : buildSection("AVAILABLE RESTAURANTS", ""),
            // buildHorizontalList(items),
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

  Widget getCards(CommonCounter commonCounter) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const SizedBox(height: 5,),

        const SizedBox(
          height: 10,
        ),
        Row(

          children: [
            commonCounter.isStore
                ? Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 3),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: btnbgColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 1, color: Colors.white),
                      ),
                      child: GestureDetector(
                          onTap: () {
                            commonCounter.getFavStore(false);
                          },
                          child: const Center(
                            child: CustomText(
                              text: "RESTAURANTS",
                              sizeOfFont: 10,
                              fontfamilly: montBook,
                              color: hintColor,
                            ),
                          )),
                    ),
                  )
                : Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 3),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: btnbgColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 1, color: Colors.white),
                      ),
                      child: GestureDetector(
                          onTap: () {
                            commonCounter.getFavStore(true);
                          },
                          child: const Center(
                            child: CustomText(
                              text: "RESTAURANTS",
                              sizeOfFont: 10,
                              fontfamilly: montBook,
                              color: hintColor,
                            ),
                          )),
                    ),
                  ),
            const SizedBox(
              width: 20,
            ),
            !commonCounter.isStore
                ? Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 3),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: btnbgColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 1, color: Colors.white),
                      ),
                      child: GestureDetector(
                          onTap: () {
                            commonCounter.getFavStore(true);
                          },
                          child: const Center(
                            child: CustomText(
                              text: "DEALS",
                              sizeOfFont: 10,
                              fontfamilly: montBook,
                              color: hintColor,
                            ),
                          )),
                    ),
                  )
                : Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 3),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: btnbgColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 1, color: Colors.white),
                      ),
                      child: GestureDetector(
                          onTap: () {
                            commonCounter.getFavStore(false);
                          },
                          child: const Center(
                            child: CustomText(
                              text: "DEALS",
                              sizeOfFont: 10,
                              fontfamilly: montBook,
                              color: hintColor,
                            ),
                          )),
                    ),
                  )
          ],
        )
      ],
    );
  }

  Widget buildHorizontalList(List<String> items) {



    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          items.length,
          (index) => GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              decoration: BoxDecoration(
                color: editbgColor,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(width: 1, color: Colors.white),
              ),
              child: CustomText(
                text: items[index],
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

  Widget buildVerticalCards(CommonCounter commonCounter) {
    // var currentList = restaurantData;

  //   if (restaurantData.isEmpty) {
  //   return const Padding(
  //     padding: EdgeInsets.all(20.0),
  //     child: CustomText(
  //       text: 'No Item Found',
  //       maxLin: 1,
  //       color: btntxtColor,
  //       fontfamilly: montBold,
  //       sizeOfFont: 15,
  //     ),
  //   );
  // }


    var currentList = commonCounter.isStore ? restaurantData : dealListingData;

    return Expanded(
      child: RefreshIndicator(
        key: _refreshIndicatorKey,
        color: Colors.white,
        backgroundColor: editbgColor,
        strokeWidth: 4.0,
        onRefresh: _refreshData,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: currentList.length + (hasMoreData ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < currentList.length) {
              // Display restaurant card
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    navigatorKey.currentContext!,
                    '/RestaurantsProfileScreen',
                    arguments: currentList[index],
                  );
                },
                child: commonCounter.isStore
                    ? getFavStoreCards(index, currentList[index] as StoreData)
                    : getFavDealCards(index, currentList[index] as DealData),
              );
            } else {
              // Display loading indicator while fetching more data
              return FutureBuilder(
                  future: Future.delayed(const Duration(seconds: 1)),
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
      var formData = {"search_query": data};

      final searchQueryData = await searchProvider.getSearchQueryResultList(
        formData,
        page: currentRestaurantPage,
      );

      if (searchQueryData.stores != null &&
          searchQueryData.stores!.isNotEmpty) {
        setState(() {
          currentRestaurantPage =
              1; // Reset the page to 1 as you loaded the first page.
          hasMoreData = true; // Reset the flag for more data.

          restaurantData.clear(); // Clear existing data before adding new data.
          dealListingData
              .clear(); // Clear existing data before adding new data.

          restaurantData.addAll(searchQueryData.stores!);
          dealListingData.addAll(searchQueryData.deals!);
          isRefresh = true;
        });
      }
    } catch (error) {
    }
  }

  Widget getFavStoreCards(int index, StoreData storeData) {
    // Use the 'data' parameter to access properties from the 'Data' class
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 0, color: editbgColor.withOpacity(0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: storeData.name ?? "",
                  color: btntxtColor,
                  fontfamilly: montBold,
                  sizeOfFont: 18,
                  maxLin: 1,
                ),
                CustomText(
                  text: storeData.category ?? "",
                  color: graysColor,
                  fontfamilly: montRegular,
                  sizeOfFont: 14,
                  maxLin: 1,
                ),
                CustomText(
                  text: storeData.address ?? "",
                  color: graysColor,
                  sizeOfFont: 12,
                  fontfamilly: montLight,
                  maxLin: 1,
                ),
                const SizedBox(
                  height: 5,
                ),
                const CustomText(
                  text: "3 offers available",
                  color: offerColor,
                  sizeOfFont: 10,
                  fontfamilly: montRegular,
                  maxLin: 1,
                ),
                const SizedBox(
                  height: 5,
                ),
                const RatingBar.readOnly(
                  filledIcon: Icons.star,
                  emptyIcon: Icons.star_border,
                  filledColor: btnbgColor,
                  initialRating: 4,
                  size: 18,
                  maxRating: 5,
                ),
              ],
            ),
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
                    child: storeData.profileImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.network(
                              storeData.profileImage!,
                              fit: BoxFit.cover,
                              height: 90,
                              width: 90,
                            ))
                        : Image.asset(
                            food_image,
                            height: 90,
                            width: 90,
                          ),
                  ),
                ),
                Positioned(
                  right: -4,
                  child: GestureDetector(
                    onTap: () async {
                      var ratingStatus = storeData.favourite as int;


                      try {
                        if (ratingStatus == 0) {
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
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);

                            // Automatically hide the SnackBar after 1 second
                            Future.delayed(const Duration(milliseconds: 1000),
                                () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                            });

                            setState(() {
                              ratingStatus = 1;
                            });

                            try {
                              var formData = {"search_query": data};

                              final searchQueryData =
                                  await searchProvider.getSearchQueryResultList(
                                formData,
                                page: currentRestaurantPage,
                              );

                              if (searchQueryData.stores != null &&
                                  searchQueryData.stores!.isNotEmpty) {
                                setState(() {
                                  currentRestaurantPage =
                                      1; // Reset the page to 1 as you loaded the first page.
                                  hasMoreData =
                                      true; // Reset the flag for more data.
                                  isRefresh = true;
                                  restaurantData
                                      .clear(); // Clear existing data before adding new data.

                                  restaurantData
                                      .addAll(searchQueryData.stores!);
                                });
                              }
                            } catch (error) {
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
                            Future.delayed(const Duration(milliseconds: 1000),
                                () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                            });
                          }
                        } else if (ratingStatus == 1) {
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
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);

                            // Automatically hide the SnackBar after 1 second
                            Future.delayed(const Duration(milliseconds: 1000),
                                () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                            });

                            setState(() {
                              ratingStatus = 0;
                            });

                            try {
                              var formData = {"search_query": data};

                              final searchQueryData =
                                  await searchProvider.getSearchQueryResultList(
                                formData,
                                page: currentRestaurantPage,
                              );

                              if (searchQueryData.stores != null &&
                                  searchQueryData.stores!.isNotEmpty) {
                                setState(() {
                                  currentRestaurantPage =
                                      1; // Reset the page to 1 as you loaded the first page.
                                  hasMoreData =
                                      true; // Reset the flag for more data.
                                  isRefresh = true;
                                  restaurantData
                                      .clear(); // Clear existing data before adding new data.

                                  restaurantData
                                      .addAll(searchQueryData.stores!);
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
                      storeData.favourite == 1 ? save_icon_red : save_icon,
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

  Widget getFavDealCards(int index, DealData data) {
    var currentDay = DateTime.now().weekday;
    var startTiming = '';
    var endTiming = '';

    if (currentDay == 1) {
      startTiming = data.store?.openingHour?.monday?.start ?? '';
      endTiming = data.store?.openingHour?.monday?.end ?? '';
    } else if (currentDay == 2) {
      startTiming = data.store?.openingHour?.tuesday?.start ?? '';
      endTiming = data.store?.openingHour?.tuesday?.end ?? '';
    } else if (currentDay == 3) {
      startTiming = data.store?.openingHour?.wednesday?.start ?? '';
      endTiming = data.store?.openingHour?.wednesday?.end ?? '';
    } else if (currentDay == 4) {
      startTiming = data.store?.openingHour?.thursday?.start ?? '';
      endTiming = data.store?.openingHour?.thursday?.end ?? '';
    } else if (currentDay == 5) {
      startTiming = data.store?.openingHour?.friday?.start ?? '';
      endTiming = data.store?.openingHour?.friday?.end ?? '';
    } else if (currentDay == 6) {
      startTiming = data.store?.openingHour?.saturday?.start ?? '';
      endTiming = data.store?.openingHour?.saturday?.end ?? '';
    } else if (currentDay == 7) {
      startTiming = data.store?.openingHour?.sunday?.start ?? '';
      endTiming = data.store?.openingHour?.sunday?.end ?? '';
    }
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          navigatorKey.currentContext!,
          '/OrderAndPayScreen',
          arguments: data,
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: data.name ?? "",
                    maxLin: 1,
                    color: btntxtColor,
                    fontfamilly: montBold,
                    sizeOfFont: 18,
                  ),
                  CustomText(
                    text: data.store?.name ?? "",
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
                        initialRating: double.parse(data.averageRating ?? '2'),
                        size: 16,
                        maxRating: 5,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Expanded(
                          child: CustomText(
                              text: "84 Km",
                              maxLin: 1,
                              color: graysColor,
                              sizeOfFont: 13,
                              fontfamilly: montSemiBold)),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomText(
                    text: '\$ ${data.price ?? ""}',
                    color: dolorColor,
                    sizeOfFont: 20,
                    fontfamilly: montHeavy,
                  ),
                ],
              ),
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
                      child: data.profileImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network(
                                data.profileImage!,
                                fit: BoxFit.cover,
                                height: 90,
                                width: 90,
                              ))
                          : Image.asset(
                              food_image,
                              height: 90,
                              width: 90,
                            ),
                    ),
                  ),
                  Positioned(
                    right: -4,
                    child: GestureDetector(
                      onTap: () async {
                        int? dealId = data.id;


                        try {
                          if (data.favourite == false) {
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
                                data.favourite = true;
                              });

                              try {
                                var formData = {"search_query": data};

                                final searchQueryData = await searchProvider
                                    .getSearchQueryResultList(
                                  formData,
                                  page: currentRestaurantPage,
                                );

                                if (searchQueryData.stores != null &&
                                    searchQueryData.stores!.isNotEmpty) {
                                  setState(() {
                                    currentRestaurantPage =
                                        1; // Reset the page to 1 as you loaded the first page.
                                    hasMoreData =
                                        true; // Reset the flag for more data.
                                    isRefresh = true;
                                    dealListingData
                                        .clear(); // Clear existing data before adding new data.

                                    dealListingData
                                        .addAll(searchQueryData.deals!);
                                  });
                                }
                              } catch (error) {
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
                              Future.delayed(const Duration(milliseconds: 1000),
                                  () {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                              });
                            }
                          } else if (data.favourite == true) {
                            // If data.favourite is false, print its value
                            FavDeleteResponse delData =
                                await Provider.of<FavoriteOperationProvider>(
                                        context,
                                        listen: false)
                                    .RemoveFromFavoriteDeal(data.id ?? 0);

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
                                data.favourite = false;
                              });

                              try {
                                var formData = {"search_query": data};

                                final searchQueryData = await searchProvider
                                    .getSearchQueryResultList(
                                  formData,
                                  page: currentRestaurantPage,
                                );

                                if (searchQueryData.stores != null &&
                                    searchQueryData.stores!.isNotEmpty) {
                                  setState(() {
                                    currentRestaurantPage =
                                        1; // Reset the page to 1 as you loaded the first page.
                                    hasMoreData =
                                        true; // Reset the flag for more data.
                                    isRefresh = true;
                                    dealListingData
                                        .clear(); // Clear existing data before adding new data.

                                    dealListingData
                                        .addAll(searchQueryData.deals!);
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
                        data.favourite == true ? save_icon_red : save_icon,
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
