import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/cupertino.dart';
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
import '../../Response_Model/RestaurantDealResponse.dart';
import '../../UTILS/app_color.dart';
import '../../UTILS/app_images.dart';
import '../../UTILS/fontfamily_string.dart';
import '../../main.dart';

class CollectTomorrowScreen extends StatefulWidget {
  const CollectTomorrowScreen({super.key});

  @override
  _CollectTomorrowScreenState createState() => _CollectTomorrowScreenState();
}

class _CollectTomorrowScreenState extends State<CollectTomorrowScreen> {

  final List<String> items = ['Healthy', 'Sushi', 'Desserts', 'Sugar', 'Sweets'];
  final RestaurantsListProvider restaurantsProvider = RestaurantsListProvider();
  final HomeDataListProvider homeProvider = HomeDataListProvider();

  int currentPage = 1;
  bool isLoading = false;
  bool hasMoreData = true;
  bool isRefresh = false;

  bool isFilterLoading = false;
  bool hasFilterMoreData = true;
  List<FilterData> filterList = [];


  List<DealData> collectTomorrowData = [];

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _loadData();
    _loadFilterData();

  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();


  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
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

          final nextPageData = await restaurantsProvider.getCollectTomorrowList(
            page: currentPage,
          );

          if (nextPageData.data != null && nextPageData.data!.isNotEmpty) {
            setState(() {
              if(isRefresh == true){

                collectTomorrowData.clear();
                collectTomorrowData.addAll(nextPageData.data!);

                currentPage++;
                isRefresh = false;

              }else{
                collectTomorrowData.addAll(nextPageData.data!);
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
          isFilterLoading = false;
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(padding: const EdgeInsets.only(top: 0.0,bottom: 20,left: 25,right: 25),

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
                            'search_type': 'Collect Tomorrow',

                          };

                          var data = await Provider.of<SearchProvider>(context, listen: false)
                              .getSearchResult(formData);

                          if (data.status == true && data.message == "Search successful") {
                            // Login successful

                            // Print data to console
                            setState(() {
                              collectTomorrowData = data.collectTomorrowDeals!;

                            });


                            // Navigate to the next screen or perform other actions after login
                          } else {
                            // Login failed
                            print("Something went wrong: ${data.message}");

                            final snackBar = SnackBar(
                              content:  Text('${data.message}'),

                            );

                            // Show the SnackBar
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);

                            // Automatically hide the SnackBar after 1 second
                            Future.delayed(Duration(milliseconds: 1000), () {
                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            });

                          }
                        } catch (e) {
                          // Display error message
                          print("Error: $e");
                        }


                        // For simplicity, I'll just print the search query for now
                        print("Search query: $query");
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
                padding: EdgeInsets.only(left: 13.0,top: 20),
                child: CustomText(text: collectTomorrow, color: btnbgColor, fontfamilly: montHeavy, sizeOfFont: 20),
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
      return SizedBox.shrink(); // Return an empty widget if there's only 1 or no items
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          filterList.length - 1,
              (index) => GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 15),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: editbgColor,
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
          itemCount: collectTomorrowData.length + (hasMoreData ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < collectTomorrowData.length) {
              // Display restaurant card
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    navigatorKey.currentContext!,
                    '/OrderAndPayScreen',
                    arguments: collectTomorrowData[index],
                  );
                },
                child: getFavCards(index, collectTomorrowData[index]),
              );
            } else {
              // Display loading indicator while fetching more data
              return FutureBuilder(
                future: Future.delayed(Duration(seconds: 1)),
                builder: (context, snapshot) => snapshot.connectionState == ConnectionState.done ?
                SizedBox(): Padding(
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




  Widget getFavCards(int index, DealData data) {

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
        Navigator.pushNamed(navigatorKey.currentContext!, '/OrderAndPayScreen', arguments: data,);
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
                        initialRating: double.parse(data.averageRating ?? '0'),
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
                              sizeOfFont: 12,
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
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.white, Colors.grey], // Adjust colors as needed
                        ),
                      ),
                      child: data.profileImage != null  && !(data.profileImage)!.contains("SocketException")? ClipRRect(
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

                        bool? ratingStatus = data.favourite;
                        int? dealId = data.id;

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

                              setState(() async {
                                try {
                                  final refreshedData = await restaurantsProvider.getCollectTomorrowList( page: 1);

                                  if (refreshedData.data != null && refreshedData.data!.isNotEmpty) {
                                    setState(() {

                                      data.favourite = true;


                                      currentPage = 1; // Reset the page to 1 as you loaded the first page.
                                      hasMoreData = true; // Reset the flag for more data.
                                      isRefresh = true;
                                      collectTomorrowData.clear(); // Clear existing data before adding new data.
                                      collectTomorrowData.addAll(refreshedData.data!);
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

                              setState(() async {

                                try {
                                  final refreshedData = await restaurantsProvider.getCollectTomorrowList( page: 1);

                                  if (refreshedData.data != null && refreshedData.data!.isNotEmpty) {
                                    setState(() {
                                      data.favourite = false;
                                      currentPage = 1; // Reset the page to 1 as you loaded the first page.
                                      hasMoreData = true; // Reset the flag for more data.
                                      isRefresh = true;
                                      collectTomorrowData.clear(); // Clear existing data before adding new data.
                                      collectTomorrowData.addAll(refreshedData.data!);
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

