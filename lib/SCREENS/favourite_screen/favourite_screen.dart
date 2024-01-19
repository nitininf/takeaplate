import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_app_bar.dart';
import '../../MULTI-PROVIDER/FavoriteOperationProvider.dart';
import '../../Response_Model/FavAddedResponse.dart';
import '../../Response_Model/FavDeleteResponse.dart';
import '../../Response_Model/RestaurantDealResponse.dart';
import '../../Response_Model/RestaurantsListResponse.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../MULTI-PROVIDER/RestaurantsListProvider.dart';
import '../../MULTI-PROVIDER/common_counter.dart';
import '../../UTILS/app_color.dart';
import '../../UTILS/app_images.dart';
import '../../UTILS/fontfaimlly_string.dart';
import '../../main.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final List<String> items = [
    'Healthy',
    'Sushi',
    'Desserts',
    'Sugar',
    'Sweets'
  ];
  final RestaurantsListProvider restaurantsProvider = RestaurantsListProvider();
  int isFavorite = 0;
  int currentRestaurantPage = 1;
  int currentDealPage = 1;
  bool isRestaurantLoading = false;
  bool isRefresh = false;
  bool isDealLoading = false;
  bool hasMoreData = true;
  List<StoreData> restaurantData = [];
  List<DealData> dealListingData = [];

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
    if (!isRestaurantLoading && hasMoreData) {
      try {
        setState(() {
          isRestaurantLoading = true;
        });

        final nextPageRestaurantData =
            await restaurantsProvider.getFavRestaurantsList(
          page: currentRestaurantPage,
        );

        if (nextPageRestaurantData.data != null &&
            nextPageRestaurantData.data!.isNotEmpty) {
          setState(() {

            if(isRefresh == true) {
              restaurantData.clear();
              restaurantData.addAll(nextPageRestaurantData.data!);
              currentRestaurantPage++;
            }else{
              restaurantData.addAll(nextPageRestaurantData.data!);
              currentRestaurantPage++;
            }
          });
        }



      } catch (error) {
        print('Error loading more data: $error');
      } finally {
        setState(() {
          isRestaurantLoading = false;
        });
      }
    }
    if (!isDealLoading && hasMoreData) {
      try {
        setState(() {
          isDealLoading = true;
        });

        final nextPageDealData = await restaurantsProvider.getFavDealsList(
          page: currentDealPage,
        );

        if (nextPageDealData.data != null &&
            nextPageDealData.data!.isNotEmpty) {
          setState(() {
            if(isRefresh == true) {
              dealListingData.clear();
              dealListingData.addAll(nextPageDealData.data!);
              currentDealPage++;
            }else{
              dealListingData.addAll(nextPageDealData.data!);
              currentDealPage++;
            }
          });

          print(dealListingData);
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
          isDealLoading = false;
        });
      }
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: 20, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(),
              const Padding(
                padding: EdgeInsets.only(left: 8.0, top: 26),
                child: CustomText(
                    text: "YOUR FAVOURITES",
                    color: btnbgColor,
                    fontfamilly: montHeavy,
                    sizeOfFont: 20),
              ),
              getView(),
            ],
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
            SizedBox(
              height: 10,
            ),
            getCards(commonProvider),
            !commonProvider.isStore
                ? buildSection("DEALS", "")
                : buildSection("STORES", ""),
            buildHorizontalList(items),
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

        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            commonCounter.isStore
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
                          commonCounter.getFavStore(false);
                        },
                        child: CustomText(
                          text: "Stores you loved",
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
                          commonCounter.getFavStore(true);
                        },
                        child: CustomText(
                          text: "Stores you loved",
                          sizeOfFont: 10,
                          fontfamilly: montBook,
                          color: hintColor,
                        )),
                  ),
            SizedBox(
              width: 8,
            ),
            !commonCounter.isStore
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
                          commonCounter.getFavStore(true);
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
                          commonCounter.getFavStore(false);
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
                child: commonCounter.isStore ? getFavStoreCards(index, currentList[index] as StoreData)  : getFavDealCards(index, currentList[index] as DealData) ,
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
      final refreshedData = await restaurantsProvider.getFavRestaurantsList(page: 1);
      final refreshedDealData = await restaurantsProvider.getFavDealsList(page: 1);

      if (refreshedData.data != null && refreshedData.data!.isNotEmpty) {
        setState(() {

          currentRestaurantPage = 1; // Reset the page to 1 as you loaded the first page.
          hasMoreData = true; // Reset the flag for more data.
          isRefresh = true;
          restaurantData.clear(); // Clear existing data before adding new data.
          restaurantData.addAll(refreshedData.data!);


        });
      }if (refreshedDealData.data != null && refreshedDealData.data!.isNotEmpty) {
        setState(() {

          currentDealPage = 1; // Reset the page to 1 as you loaded the first page.
          hasMoreData = true; // Reset the flag for more data.
          isRefresh = true;
          dealListingData.clear(); // Clear existing data before adding new data.
          dealListingData.addAll(refreshedDealData.data!);

        });
      }
    } catch (error) {
      print('Error refreshing data: $error');
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
                    child: storeData.profileImage != null ? ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Image.network(
                          storeData.profileImage!,
                          fit: BoxFit.cover,
                          height: 90, width: 90,
                        )
                    ): Image.asset(food_image,height: 90, width: 90,),
                  ),
                ),

                Positioned(
                  right: -4,
                  child: GestureDetector(
                    onTap: () async {
                      int? ratingStatus = storeData.favourite as int;

                      print('ratingStatus:$ratingStatus');

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
                              storeData.favourite = 1;
                            });
                            try {
                              final refreshedData = await restaurantsProvider
                                  .getFavRestaurantsList(page: 1);

                              if (refreshedData.data != null &&
                                  refreshedData.data!.isNotEmpty) {
                                setState(() {
                                  currentRestaurantPage = 1; // Reset the page to 1 as you loaded the first page.
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
                        } else if (storeData.favourite == 1) {
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
                              storeData.favourite = 0;
                            });

                            try {
                              final refreshedData = await restaurantsProvider
                                  .getFavRestaurantsList(page: 1);

                              if (refreshedData.data != null &&
                                  refreshedData.data!.isNotEmpty) {
                                setState(() {
                                  currentRestaurantPage = 1; // Reset the page to 1 as you loaded the first page.
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
    var  currentDay = DateTime.now().weekday;
    var  startTiming = '';
    var endTiming = '';

    if(currentDay == 1){
      startTiming = data.store?.openingHour?.monday?.start ?? '';
      endTiming = data.store?.openingHour?.monday?.end ?? '';

    }else if(currentDay == 2){

      startTiming = data.store?.openingHour?.tuesday?.start ?? '';
      endTiming = data.store?.openingHour?.tuesday?.end ?? '';
    }else if(currentDay == 3){

      startTiming = data.store?.openingHour?.wednesday?.start ?? '';
      endTiming = data.store?.openingHour?.wednesday?.end ?? '';
    }else if(currentDay == 4){

      startTiming = data.store?.openingHour?.thursday?.start ?? '';
      endTiming = data.store?.openingHour?.thursday?.end ?? '';
    }else if(currentDay == 5){

      startTiming = data.store?.openingHour?.friday?.start ?? '';
      endTiming = data.store?.openingHour?.friday?.end ?? '';
    }else if(currentDay == 6){

      startTiming = data.store?.openingHour?.saturday?.start ?? '';
      endTiming = data.store?.openingHour?.saturday?.end ?? '';
    }else if(currentDay == 7){

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
                      text: '${startTiming ?? ""} - ${endTiming ?? ""}',
                      maxLin: 1,
                      color: graysColor,
                      sizeOfFont: 12,
                      fontfamilly: montRegular),
                  SizedBox(
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
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: CustomText(
                              text: "84 Km",
                              maxLin: 1,
                              color: graysColor,
                              sizeOfFont: 13,
                              fontfamilly: montSemiBold)),
                    ],
                  ),
                  SizedBox(
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
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.white, Colors.grey], // Adjust colors as needed
                        ),
                      ),
                      child: data.profileImage != null ? ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.network(
                            data.profileImage!,
                            fit: BoxFit.cover,
                            height: 90, width: 90,
                          )
                      ): Image.asset(food_image,height: 90, width: 90,),
                    ),
                  ),
              
                  Positioned(
                    right: -4,
                    child: GestureDetector(
                      onTap: () async {
              
                       var ratingStatus = data.favourite as bool;
                        int? dealId = data.id;
                        int? storeId = data.storeId;
              
                        print('ratingStatus:$ratingStatus');
              
                        try {
              
                          if (data.favourite == false) {
                            // Only hit the API if data.favourite is true
                            var formData = {
                              'favourite': 1,
                            };
              
                            FavAddedResponse favData = await Provider.of<FavoriteOperationProvider>(context, listen: false)
                                .AddToFavoriteDeal(dealId??0,formData);
              
                            if (favData.status == true && favData.message == "Deal Added in favourite successfully.") {
                              // Print data to console
                              print(favData);
              
                              final snackBar = SnackBar(
                                content:  Text('${favData.message}'),
                              );
              
                              // Show the SnackBar
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              
                              // Automatically hide the SnackBar after 1 second
                              Future.delayed(Duration(milliseconds: 1000), () {
                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              });
              
                              setState(() {
              
                                data.favourite = true;
              
              
                              });
              
              
                              try {
                                final refreshedData = await restaurantsProvider.getFavDealsList( page: 1);
              
                                if (refreshedData.data != null && refreshedData.data!.isNotEmpty) {
              
                                      setState(() {

                                        currentDealPage = 1; // Reset the page to 1 as you loaded the first page.
                                        hasMoreData = true; // Reset the flag for more data.
                                        isRefresh = true;
                                        dealListingData.clear(); // Clear existing data before adding new data.
                                        dealListingData.addAll(refreshedData.data!);
                                      });
              
              
              
              
              
                                }
                              } catch (error) {
                                print('Error refreshing data: $error');
                              }
              
              
                            } else {
                              // API call failed
                              print("Something went wrong: ${favData.message}");
              
                              final snackBar = SnackBar(
                                content:  Text('${favData.message}'),
                              );
              
                              // Show the SnackBar
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              
                              // Automatically hide the SnackBar after 1 second
                              Future.delayed(Duration(milliseconds: 1000), () {
                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              });
                            }
                          } else if (data.favourite == true){
                            // If data.favourite is false, print its value
                            FavDeleteResponse delData = await Provider.of<FavoriteOperationProvider>(context, listen: false)
                                .RemoveFromFavoriteDeal(data.id ?? 0);
              
                            if (delData.status == true && delData.message == "Favourite Deal deleted successfully.") {
                              // Print data to console
                              print(delData);
              
                              final snackBar = SnackBar(
                                content:  Text('${delData.message}'),
                              );
              
                              // Show the SnackBar
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              
                              // Automatically hide the SnackBar after 1 second
                              Future.delayed(Duration(milliseconds: 1000), () {
                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                              });
              
                              setState(() {
              
                                data.favourite = false;
              
              
                              });
              
                              try {
                                final refreshedData = await restaurantsProvider.getFavDealsList( page: 1);
              
                                if (refreshedData.data != null && refreshedData.data!.isNotEmpty) {
              
              
              
              
                                      setState(() {

                                        currentDealPage = 1; // Reset the page to 1 as you loaded the first page.
                                        hasMoreData = true; // Reset the flag for more data.
                                        isRefresh = true;
                                        dealListingData.clear(); // Clear existing data before adding new data.
                                        dealListingData.addAll(refreshedData.data!);
                                      });
              
              
              
              
                                }
                              } catch (error) {
                                print('Error refreshing data: $error');
                              }
              
              
                            } else {
                              // API call failed
                              print("Something went wrong: ${delData.message}");
              
                              final snackBar = SnackBar(
                                content:  Text('${delData.message}'),
                              );
              
                              // Show the SnackBar
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              
                              // Automatically hide the SnackBar after 1 second
                              Future.delayed(Duration(milliseconds: 1000), () {
                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
                        data.favourite == true  ? save_icon_red : save_icon,
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
