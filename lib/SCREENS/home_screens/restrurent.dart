import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../../CUSTOM_WIDGETS/custom_search_field.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../MULTI-PROVIDER/FavoriteOperationProvider.dart';
import '../../MULTI-PROVIDER/RestaurantsListProvider.dart';
import '../../Response_Model/FavAddedResponse.dart';
import '../../Response_Model/FavDeleteResponse.dart';
import '../../Response_Model/RestaurantsListResponse.dart';
import '../../UTILS/app_color.dart';
import '../../UTILS/app_images.dart';
import '../../UTILS/fontfaimlly_string.dart';
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
  final RestaurantsListProvider restaurantsProvider = RestaurantsListProvider();
  bool isFavorite = false;
  int currentPage = 1;
  bool isLoading = false;
  bool isRefresh = false;
  bool hasMoreData = true;
  List<StoreData> restaurantData = [];

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
    if (!isLoading && hasMoreData) {
      try {
        setState(() {
          isLoading = true;
        });

        final nextPageData = await restaurantsProvider.getRestaurantsList(
          page: currentPage,
        );

        if (nextPageData.data != null && nextPageData.data!.isNotEmpty) {
          setState(() {
            if (mounted) {

              if(isRefresh == true){

                restaurantData.clear();
                restaurantData.addAll(nextPageData.data!);
                currentPage++;
              }else{
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
        print('Error loading more data: $error');
      } finally {
        setState(() {
          if (mounted) {
            isLoading = false;
          }
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
            const CustomSearchField(hintText: "Search"),
            const Padding(
              padding: EdgeInsets.only(left: 13.0, top: 30),
              child: CustomText(
                  text: "RESTAURANTS",
                  color: btnbgColor,
                  fontfamilly: montHeavy,
                  sizeOfFont: 20),
            ),
            buildHorizontalList(items),
            buildVerticalCards(),
          ],
        ),
      ),
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
            } else {
              // Display loading indicator while fetching more data
              return FutureBuilder(
                future: Future.delayed(Duration(seconds: 3)),
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
    // Call your API here to refresh the data
    try {
      final refreshedData =
          await restaurantsProvider.getRestaurantsList(page: 1);

      if (refreshedData.data != null && refreshedData.data!.isNotEmpty) {
        setState(() {
          currentPage = 1; // Reset the page to 1 as you loaded the first page.
          hasMoreData = true; // Reset the flag for more data.
          isRefresh = true;
          restaurantData.clear(); // Clear existing data before adding new data.
          restaurantData.addAll(refreshedData.data!);
        });
      }
    } catch (error) {
      print('Error refreshing data: $error');
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
                SizedBox(
                  height: 5,
                ),
                Row(
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
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.white, Colors.grey], // Adjust colors as needed
                      ),
                    ),
                    child: storeData.profileImage != null && !(storeData.profileImage)!.contains("SocketException")? ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.network(
                          storeData.profileImage!,
                          fit: BoxFit.cover,
                          height: 80, width: 80,
                        )
                    ): Image.asset(food_image,height: 80, width: 80,),
                  ),
                ),

                Positioned(
                  right: -4,
                  child: GestureDetector(
                    onTap: () async {
                      bool? ratingStatus = storeData.favourite;

                      print('ratingStatus:$ratingStatus');
                      print('StoreId: ${storeData.id}');

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
                            print(favData);

                            final snackBar = SnackBar(
                              content: Text('${favData.message}'),
                            );

                            // Show the SnackBar
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);

                            // Automatically hide the SnackBar after 1 second
                            Future.delayed(Duration(milliseconds: 1000), () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                            });

                            setState(() {
                              storeData.favourite = true;
                            });
                            try {
                              final refreshedData = await restaurantsProvider
                                  .getRestaurantsList(page: 1);

                              if (refreshedData.data != null &&
                                  refreshedData.data!.isNotEmpty) {
                                setState(() {
                                  currentPage = 1; // Reset the page to 1 as you loaded the first page.
                                  hasMoreData = true; // Reset the flag for more data.
                                  isRefresh = true;
                                  restaurantData.clear(); // Clear existing data before adding new data.
                                  restaurantData.addAll(refreshedData.data!);
                                });
                              }
                            } catch (error) {
                              print('Error refreshing data: $error');
                            }
                          } else {
                            // API call failed
                            print("Something went wrong: ${favData.message}");

                            final snackBar = SnackBar(
                              content: Text('${favData.message}'),
                            );

                            // Show the SnackBar
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);

                            // Automatically hide the SnackBar after 1 second
                            Future.delayed(Duration(milliseconds: 1000), () {
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
                            print(delData);

                            final snackBar = SnackBar(
                              content: Text('${delData.message}'),
                            );

                            // Show the SnackBar
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);

                            // Automatically hide the SnackBar after 1 second
                            Future.delayed(Duration(milliseconds: 1000), () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                            });

                            setState(() {
                              storeData.favourite = false;
                            });

                            try {
                              final refreshedData = await restaurantsProvider
                                  .getRestaurantsList(page: 1);

                              if (refreshedData.data != null &&
                                  refreshedData.data!.isNotEmpty) {
                                currentPage = 1; // Reset the page to 1 as you loaded the first page.
                                hasMoreData = true; // Reset the flag for more data.
                                isRefresh = true;
                                restaurantData.clear(); // Clear existing data before adding new data.
                                restaurantData.addAll(refreshedData.data!);
                              }
                            } catch (error) {
                              print('Error refreshing data: $error');
                            }
                          } else {
                            // API call failed
                            print("Something went wrong: ${delData.message}");

                            final snackBar = SnackBar(
                              content: Text('${delData.message}'),
                            );

                            // Show the SnackBar
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);

                            // Automatically hide the SnackBar after 1 second
                            Future.delayed(Duration(milliseconds: 1000), () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                            });
                          }
                        }
                      } catch (e) {
                        // Display error message
                        print("Error: $e");
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
