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
import '../../Response_Model/RestaurantDealResponse.dart';
import '../../UTILS/app_color.dart';
import '../../UTILS/app_images.dart';
import '../../UTILS/fontfaimlly_string.dart';
import '../../main.dart';

class LastMinuteDealScreen extends StatefulWidget {
  const LastMinuteDealScreen({super.key});

  @override
  _LastMinuteDealScreenState createState() => _LastMinuteDealScreenState();
}

class _LastMinuteDealScreenState extends State<LastMinuteDealScreen> {

  final List<String> items = ['Healthy', 'Sushi', 'Desserts', 'Sugar', 'Sweets'];
  final RestaurantsListProvider restaurantsProvider = RestaurantsListProvider();
  int currentPage = 1;
  bool isLoading = false;
  bool hasMoreData = true;
  List<DealData> dealListData = [];

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _loadData();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();


  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
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

        final nextPageData = await restaurantsProvider.getLastMinuteDealsList(
          page: currentPage,
        );

        if (nextPageData.data != null && nextPageData.data!.isNotEmpty) {
          setState(() {
            dealListData.addAll(nextPageData.data!);
            currentPage++;
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

    return  Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(padding: const EdgeInsets.only(top: 0.0,bottom: 20,left: 25,right: 25),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(),
              const SizedBox(height: 20),
              const CustomSearchField(hintText:"Search"),
              const Padding(
                padding: EdgeInsets.only(left: 13.0,top: 20),
                child: CustomText(text: closet, color: btnbgColor, fontfamilly: montHeavy, sizeOfFont: 20),
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
            onTap: (){
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              decoration: BoxDecoration(
                color: editbgColor,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(width: 1, color: Colors.white),
              ),
              child: CustomText(text: items[index], color: hintColor, fontfamilly: montBook,sizeOfFont: 19,),
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
          itemCount: dealListData.length + (hasMoreData ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < dealListData.length) {
              // Display restaurant card
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    navigatorKey.currentContext!,
                    '/OrderAndPayScreen',
                    arguments: dealListData[index],
                  );
                },
                child: getFavCards(index, dealListData[index]),
              );
            } else {
              // Display loading indicator while fetching more data
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator()),
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
      final refreshedData = await restaurantsProvider.getLastMinuteDealsList(page: 1);

      if (refreshedData.data != null && refreshedData.data!.isNotEmpty) {
        setState(() {
          dealListData = refreshedData.data!;
          currentPage = 1; // Reset the page to 2 as you loaded the first page.
          hasMoreData = true; // Reset the flag for more data.
        });
      }
    } catch (error) {
      print('Error refreshing data: $error');
    }
  }




  Widget getFavCards(int index, DealData data) {

    var startTiming = data.customTime?.startTime;
    var endTiming = data.customTime?.endTime;


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
                    sizeOfFont: 21,
                  ),
                  CustomText(
                    text: data.store?.name ?? "",
                    maxLin: 1,
                    color: btntxtColor,
                    fontfamilly: montRegular,
                    sizeOfFont: 16,
                  ),
                  CustomText(
                      text: '${startTiming ?? ""} - ${endTiming ?? ""}',
                      maxLin: 1,
                      color: graysColor,
                      sizeOfFont: 11,
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
                        size: 20,
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
                              sizeOfFont: 15,
                              fontfamilly: montSemiBold)),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  CustomText(
                    text: '\$ ${data.price ?? ""}',
                    color: dolorColor,
                    sizeOfFont: 27,
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
                  Image.asset(food_image,
                      height: 130, width: 130, fit: BoxFit.cover),
                  Positioned(
                    right: -4,
                    child: GestureDetector(
                      onTap: () async {

                        bool? ratingStatus = data.favourite;
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

                              setState(() async {
                                try {
                                  final refreshedData = await restaurantsProvider.getRestaurantsDealsList(storeId, page: 1);

                                  if (refreshedData.data != null && refreshedData.data!.isNotEmpty) {
                                    setState(() {
                                      data.favourite = true;

                                      dealListData = refreshedData.data!.cast<DealData>();
                                      currentPage = 1; // Reset the page to 2 as you loaded the first page.
                                      hasMoreData = true; // Reset the flag for more data.
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
                                  final refreshedData = await restaurantsProvider.getRestaurantsDealsList(storeId, page: 1);

                                  if (refreshedData.data != null && refreshedData.data!.isNotEmpty) {
                                    setState(() {
                                      data.favourite = false;
                                      dealListData = refreshedData.data!.cast<DealData>();
                                      currentPage = 1; // Reset the page to 2 as you loaded the first page.
                                      hasMoreData = true; // Reset the flag for more data.
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

