import 'package:flutter/material.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:provider/provider.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../MULTI-PROVIDER/FavoriteOperationProvider.dart';
import '../../MULTI-PROVIDER/HomeDataListProvider.dart';
import '../../MULTI-PROVIDER/RestaurantsListProvider.dart';
import '../../MULTI-PROVIDER/SearchProvider.dart';
import '../../Response_Model/CategoryFilterResponse.dart';
import '../../Response_Model/FavAddedResponse.dart';
import '../../Response_Model/FavDeleteResponse.dart';
import '../../Response_Model/RestaurantsListResponse.dart';
import '../../UTILS/app_color.dart';
import '../../UTILS/app_images.dart';
import '../../UTILS/fontfamily_string.dart';
import '../../UTILS/request_string.dart';
import '../../UTILS/utils.dart';
import '../../main.dart';

class RestaurantsScreen extends StatefulWidget {
  @override
  _RestaurantsScreenState createState() => _RestaurantsScreenState();
}

class _RestaurantsScreenState extends State<RestaurantsScreen> {
  final List<String> items = [
    'Healthy',
    'Sushi',
    'Desserts',
    'Sugar',
    'Sweets'
  ];
  final HomeDataListProvider homeProvider = HomeDataListProvider();
  int selectedCardIndex = -1;

  final RestaurantsListProvider restaurantsProvider = RestaurantsListProvider();
  bool isFavorite = false;
  int currentPage = 1;
  bool isLoading = false;
  bool isRefresh = false;
  bool hasMoreData = true;
  List<StoreData> restaurantData = [];

  bool isFilterLoading = false;
  bool hasFilterMoreData = true;
  List<FilterData> filterList = [];
  int dataId = 0;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _loadData(dataId);
    _loadFilterData();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Reached the end of the list, load more data
      _loadData(dataId);
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



            var lat = await Utility.getStringValue(RequestString.LATITUDE);
            var long = await Utility.getStringValue(RequestString.LONGITUDE);


            var formData = {
              RequestString.LATITUDE: lat,
              RequestString.LONGITUDE: long,

            };

            final nextPageData = await restaurantsProvider.getRestaurantsList(
                page: currentPage, dataId,formData);

            if (nextPageData.data != null && nextPageData.data!.isNotEmpty) {
              setState(() {
                if (mounted) {
                  if (isRefresh == true) {
                    restaurantData.clear();
                    restaurantData.addAll(nextPageData.data!);
                    currentPage++;

                    isRefresh = false;
                  } else {
                    restaurantData.addAll(nextPageData.data!);
                    currentPage++;
                  }
                }
              });
            } else {
              setState(() {
                if (mounted) {
                  hasMoreData = false;
                }
              });
            }
          } catch (error) {
            print(error);
            //
          } finally {
            setState(() {
              if (mounted) {
                isLoading = false;
              }
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
    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 5.0, right: 20, left: 20, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Consumer<SearchProvider>(
              builder: (context, searchProvider, child) {
                return TextFormField(
                  keyboardType: TextInputType.text,
                  onChanged: (query) async {
                    if (query.length >= 3) {
                      // Trigger API call after 3 characters
                      // You can call your API here using the search query
                      // and update the UI with the response

                      try {
                        var formData = {
                          "search_query": query,
                          'search_type': 'Restaurant',
                        };

                        var data = await Provider.of<SearchProvider>(context,
                                listen: false)
                            .getSearchResult(formData);

                        if (data.status == true &&
                            data.message == "Search successful") {
                          // Login successful

                          // Print data to console
                          setState(() {
                            restaurantData = data.restaurant!;
                          });

                          // Navigate to the next screen or perform other actions after login
                        } else {
                          // Login failed

                          final snackBar = SnackBar(
                            content: Text('${data.message}'),
                          );

                          // Show the SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          // Automatically hide the SnackBar after 1 second
                          Future.delayed(const Duration(milliseconds: 1000),
                              () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          });
                        }
                      } catch (e) {
                        // Display error message
                      }

                      // For simplicity, I'll just print the search query for now
                    }
                    // Update the search query in the provider
                    // searchProvider.setSearchQuery(query);
                  },
                  textAlign: TextAlign.start,
                  //  focusNode: focusNode,
                  style: const TextStyle(
                    fontSize: 18,
                    color: hintColor,
                    fontFamily: montBook,
                  ),
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
                      padding:
                          EdgeInsets.only(right: 20.0, top: 10, bottom: 10),
                      child: Icon(Icons.search, color: hintColor, size: 25),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 13),
                    hintStyle: const TextStyle(
                      color: hintColor,
                      fontFamily: montBook,
                      fontSize: 18,
                    ),
                    hintText: "Search",
                  ),
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.only(left: 13.0, top: 30),
              child: CustomText(
                  text: "RESTAURANTS",
                  color: btnbgColor,
                  fontfamilly: montHeavy,
                  sizeOfFont: 20),
            ),
            buildHorizontalList(filterList),
            buildVerticalCards(),
          ],
        ),
      ),
    );
  }

  Widget buildHorizontalList(List<FilterData> filterList) {
    if (filterList.length <= 1) {
      return const SizedBox.shrink(); // Return an empty widget if there's only 1 or no items
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          filterList.length - 1,
              (index) => GestureDetector(
            onTap: () async {

              currentPage = 1;

              setState(() {
                selectedCardIndex = index;
              });
              print('filterId - ${filterList[index + 1].id!}');

              dataId = filterList[index + 1].id!;

              var lat = await Utility.getStringValue(RequestString.LATITUDE);
              var long = await Utility.getStringValue(RequestString.LONGITUDE);


              var formData = {
                RequestString.LATITUDE: lat,
                RequestString.LONGITUDE: long,

              };

              final nextPageData =
              await restaurantsProvider.getClosestRestaurantsList(
                  page: currentPage,dataId,formData
              );

              if (nextPageData.data != null && nextPageData.data!.isNotEmpty) {
                setState(() {
                  if (mounted) {

                    restaurantData = nextPageData.data!;
                    currentPage++;

                  }
                });

              } else {
                setState(() {
                  if (mounted) {
                    hasMoreData = false;
                    restaurantData.clear();
                  }
                });
              }
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
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


  Widget buildVerticalCards() {
    return Expanded(
      child: RefreshIndicator(
        key: _refreshIndicatorKey,
        color: Colors.white,
        backgroundColor: editbgColor,
        strokeWidth: 4.0,
        onRefresh: _refreshData,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: restaurantData.length + (hasMoreData ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < restaurantData.length) {
              // Display restaurant card
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    navigatorKey.currentContext!,
                    '/RestaurantsProfileScreen',
                    arguments: restaurantData[index],
                  );
                },
                child: getFavCards(index, restaurantData[index]),
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> _refreshData() async {
    // Call your API here to refresh the data
    try {
      // final refreshedData =
      //     await restaurantsProvider.getRestaurantsList(page: 1);
      //
      // if (refreshedData.data != null && refreshedData.data!.isNotEmpty) {

      setState(() {
        isRefresh = true;

        currentPage = 1; // Reset the page to 1 as you loaded the first page.
        // hasMoreData = true; // Reset the flag for more data.
        // restaurantData=refreshedData.data!;

        _loadData(dataId);
      });
    } catch (error) {
      //
    }
  }

  Widget getFavCards(int index, StoreData storeData) {
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
            flex: 2,
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
                const Row(
                  children: [
                    RatingBar.readOnly(
                      filledIcon: Icons.star,
                      emptyIcon: Icons.star_border,
                      filledColor: btnbgColor,
                      initialRating: 4,
                      size: 18,
                      maxRating: 5,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: CustomText(
                      text: "3 offers available",
                      color: offerColor,
                      sizeOfFont: 10,
                      fontfamilly: montRegular,
                      maxLin: 1,
                    )),
                  ],
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
                    child: storeData.profileImage != null &&
                            !(storeData.profileImage)!
                                .contains("SocketException")
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.network(
                              storeData.profileImage!,
                              fit: BoxFit.cover,
                              height: 80,
                              width: 80,
                            ))
                        : Image.asset(
                            food_image,
                            height: 80,
                            width: 80,
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
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);

                            // Automatically hide the SnackBar after 1 second
                            Future.delayed(const Duration(milliseconds: 1000),
                                () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                            });

                            setState(() {
                              storeData.favourite = true;
                            });
                            try {
                              var lat = await Utility.getStringValue(RequestString.LATITUDE);
                              var long = await Utility.getStringValue(RequestString.LONGITUDE);

                              var formData = {
                                RequestString.LATITUDE: lat,
                                RequestString.LONGITUDE: long,

                              };

                              final refreshedData = await restaurantsProvider
                                  .getRestaurantsList(page: 1, dataId,formData);

                              if (refreshedData.data != null &&
                                  refreshedData.data!.isNotEmpty) {
                                setState(() {
                                  currentPage =
                                      1; // Reset the page to 1 as you loaded the first page.
                                  hasMoreData =
                                      true; // Reset the flag for more data.
                                  isRefresh = true;
                                  restaurantData
                                      .clear(); // Clear existing data before adding new data.
                                  restaurantData.addAll(refreshedData.data!);
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
                            Future.delayed(const Duration(milliseconds: 1000),
                                () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
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
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);

                            // Automatically hide the SnackBar after 1 second
                            Future.delayed(const Duration(milliseconds: 1000),
                                () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                            });

                            setState(() {
                              storeData.favourite = false;
                            });

                            try {


                              var lat = await Utility.getStringValue(RequestString.LATITUDE);
                              var long = await Utility.getStringValue(RequestString.LONGITUDE);



                              var formData = {
                                RequestString.LATITUDE: lat,
                                RequestString.LONGITUDE: long,

                              };

                              final refreshedData = await restaurantsProvider
                                  .getRestaurantsList(page: 1, dataId,formData);

                              if (refreshedData.data != null &&
                                  refreshedData.data!.isNotEmpty) {
                                currentPage =
                                    1; // Reset the page to 1 as you loaded the first page.
                                hasMoreData =
                                    true; // Reset the flag for more data.
                                isRefresh = true;
                                restaurantData
                                    .clear(); // Clear existing data before adding new data.
                                restaurantData.addAll(refreshedData.data!);
                              }
                            } catch (error) {
                              //
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
                      storeData.favourite == true ? save_icon_red : save_icon,
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
}
