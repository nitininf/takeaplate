import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:takeaplate/UTILS/app_strings.dart';

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

class ClosestScreen extends StatefulWidget {
  const ClosestScreen({super.key});

  @override
  _ClosestScreenState createState() => _ClosestScreenState();
}

class _ClosestScreenState extends State<ClosestScreen> {
  final List<String> items = [
    'Healthy',
    'Sushi',
    'Desserts',
    'Sugar',
    'Sweets'
  ];
  final RestaurantsListProvider restaurantsProvider = RestaurantsListProvider();

  int currentPage = 1;
  bool isLoading = false;
  bool hasMoreData = true;
  List<StoreData> restaurantData = [];

  bool isRefresh=false;

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

        final nextPageData =
            await restaurantsProvider.getClosestRestaurantsList(
          page: currentPage,
        );

        if (nextPageData.data != null && nextPageData.data!.isNotEmpty) {
          setState(() {

           if(isRefresh == true){
             restaurantData.clear();
             restaurantData.addAll(nextPageData.data!);
             currentPage++;
           }else{
             restaurantData.addAll(nextPageData.data!);
             currentPage++;
           }

          });
        } else {
          // No more data available
          setState(() {
            hasMoreData = false;
          });
        }
      } catch (error) {
        print('Error loading more data: $error');
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
        padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05, // Adjust the horizontal padding based on the screen width
        vertical: 20,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(),
              const SizedBox(height: 20),
              const CustomSearchField(hintText: "Search"),
              const Padding(
                padding: EdgeInsets.only(left: 13.0, top: 20),
                child: CustomText(
                    text: closet,
                    color: btnbgColor,
                    fontfamilly: montHeavy,
                    sizeOfFont: 20),
              ),
              buildHorizontalList(items),
              buildVerticalCards()
            ],
          ),
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
    try {
      final refreshedData =
      await restaurantsProvider.getClosestRestaurantsList(page: 1);

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

  Widget getFavCards(int index, StoreData item) {
    return Container(
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
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: item.name ?? '',
                  // Assuming 'title' is a key in your data
                  color: btntxtColor,
                  fontfamilly: montBold,
                  maxLin: 1,
                  sizeOfFont: 20,
                ),
                CustomText(
                  text: item.category ?? '',
                  // Assuming 'category' is a key in your data
                  color: btntxtColor,
                  fontfamilly: montRegular,
                  sizeOfFont: 14,
                ),
                CustomText(
                  text: '3 offer available', // Assuming 'offers' is a key in your data
                  color: offerColor,
                  sizeOfFont: 9,
                  fontfamilly: montBook,
                ),
                SizedBox(height: 1),
                Row(
                  children: [
                    RatingBar.readOnly(
                      filledIcon: Icons.star,
                      emptyIcon: Icons.star_border,
                      halfFilledIcon: Icons.star_half,
                      isHalfAllowed: true,
                      halfFilledColor: btnbgColor,
                      filledColor: btnbgColor,
                      initialRating: 5,
                      size: 18,
                      maxRating: 5,
                    ),
                    SizedBox(width: 10),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 3),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
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
          ),
          const SizedBox(width: 10),
          Stack(
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
                  child: item.profileImage != null  && !(item.profileImage)!.contains("SocketException")? ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(
                        item.profileImage!,
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
                    bool? ratingStatus = item.favourite;

                    print('ratingStatus:$ratingStatus');

                    try {
                      if (ratingStatus == false) {
                        // Only hit the API if item.favourite is true
                        var formData = {
                          'favourite': 1,
                        };

                        FavAddedResponse favData =
                            await Provider.of<FavoriteOperationProvider>(
                                    context,
                                    listen: false)
                                .AddToFavoriteStore(item.id ?? 0, formData);

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

                          setState(() async {
                            try {
                              final refreshedData = await restaurantsProvider
                                  .getClosestRestaurantsList(page: 1);

                              if (refreshedData.data != null &&
                                  refreshedData.data!.isNotEmpty) {
                                setState(() {
                                  item.favourite == true;
                                  restaurantData = refreshedData.data!;
                                  currentPage =
                                      1; // Reset the page to 2 as you loaded the first page.
                                  hasMoreData =
                                      true; // Reset the flag for more data.
                                });
                              }
                            } catch (error) {
                              print('Error refreshing data: $error');
                            }
                          });
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
                      } else if (item.favourite == true) {
                        // If item.favourite is false, print its value
                        FavDeleteResponse delData =
                            await Provider.of<FavoriteOperationProvider>(
                                    context,
                                    listen: false)
                                .RemoveFromFavoriteStore(item.id ?? 0);

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

                          setState(() async {
                            try {
                              final refreshedData = await restaurantsProvider
                                  .getClosestRestaurantsList(page: 1);

                              if (refreshedData.data != null &&
                                  refreshedData.data!.isNotEmpty) {
                                setState(() {
                                  item.favourite == false;
                                  restaurantData = refreshedData.data!;
                                  currentPage =
                                      1; // Reset the page to 2 as you loaded the first page.
                                  hasMoreData =
                                      true; // Reset the flag for more data.
                                });
                              }
                            } catch (error) {
                              print('Error refreshing data: $error');
                            }
                          });
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
                    item.favourite == true ? save_icon_red : save_icon,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
