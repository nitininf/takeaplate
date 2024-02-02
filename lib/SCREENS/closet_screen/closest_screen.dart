import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:takeaplate/UTILS/app_strings.dart';
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
  final HomeDataListProvider homeProvider = HomeDataListProvider();
  int selectedCardIndex = -1;

  int currentPage = 1;
  bool isLoading = false;
  bool hasMoreData = true;
  List<StoreData> restaurantData = [];
  bool isFilterLoading = false;
  bool hasFilterMoreData = true;
  bool isRefresh=false;
  List<FilterData> filterList = [];
  int dataId = 0;

  final ScrollController _scrollController = ScrollController();

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


    Future.delayed(Duration.zero,() async {


      if (!isLoading && hasMoreData) {
        try {
          setState(() {
            isLoading = true;
          });

          final nextPageData =
          await restaurantsProvider.getClosestRestaurantsList(
            page: currentPage,dataId
          );

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
            // No more data available
            setState(() {

              if (mounted) {
                hasMoreData = false;
              }
            });
          }
        } catch (error) {
          //
        } finally {
          setState(() {
            if (mounted) {
              isLoading = false;
            }

            });
        }
      }

    },);




  }

  void _loadFilterData() async {
    if (!isFilterLoading && hasFilterMoreData) {
      try {
        setState(() {
          isFilterLoading = true;
        });

        final filterData = await homeProvider.getCategoryFilterData(

        );

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

              Consumer<SearchProvider>(
                builder: (context, searchProvider, child) {
                  return  TextFormField(
                    keyboardType: TextInputType.text,
                    onChanged: (query) async {
                      if (query.length >= 3) {
                        // Trigger API call after 3 characters
                        // You can call your API here using the search query
                        // and update the UI with the response

                          try {
                            var formData = {
                              "search_query": query,
                              'search_type': 'Closest Restaurant',

                            };

                            var data = await Provider.of<SearchProvider>(context, listen: false)
                                .getSearchResult(formData,);

                            if (data.status == true && data.message == "Search successful") {
                              // Login successful

                              // Print data to console
                              setState(() {
                                restaurantData = data.closestRestaurant!;

                              });


                              // Navigate to the next screen or perform other actions after login
                            } else {
                              // Login failed

                              final snackBar = SnackBar(
                                content:  Text('${data.message}'),

                              );

                              // Show the SnackBar
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);

                              // Automatically hide the SnackBar after 1 second
                              Future.delayed(const Duration(milliseconds: 1000), () {
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
                        padding: EdgeInsets.only(right: 20.0, top: 10, bottom: 10),
                        child: Icon(Icons.search, color: hintColor, size: 25),
                      ),

                      contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
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
                padding: EdgeInsets.only(left: 13.0, top: 20),
                child: CustomText(
                    text: closet,
                    color: btnbgColor,
                    fontfamilly: montHeavy,
                    sizeOfFont: 20),
              ),
              buildHorizontalList(filterList),
              buildVerticalCards()
            ],
          ),
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

              final nextPageData = await restaurantsProvider.getClosestRestaurantsList(
                  page: currentPage,dataId
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
    setState(() {
      isRefresh = true;

      currentPage = 1; // Reset the page to 1 as you loaded the first page.
      // hasMoreData = true; // Reset the flag for more data.
      // restaurantData=refreshedData.data!;

      _loadData(dataId);

    });
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
                const CustomText(
                  text: '3 offer available', // Assuming 'offers' is a key in your data
                  color: offerColor,
                  sizeOfFont: 9,
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
                      initialRating: 5,
                      size: 18,
                      maxRating: 5,
                    ),
                    const SizedBox(width: 10),
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
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    gradient: const LinearGradient(
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

                          setState(() async {
                            try {
                              final refreshedData = await restaurantsProvider
                                  .getClosestRestaurantsList(page: 1,dataId);

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
                              //
                            }
                          });
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

                          setState(() async {
                            try {
                              final refreshedData = await restaurantsProvider
                                  .getClosestRestaurantsList(page: 1,dataId);

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
                              //
                            }
                          });
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
