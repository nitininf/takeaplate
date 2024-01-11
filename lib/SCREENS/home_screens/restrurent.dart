import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';

import '../../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../../CUSTOM_WIDGETS/custom_search_field.dart';
import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../MULTI-PROVIDER/RestaurantsListProvider.dart';
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
  final List<String> items = ['Healthy', 'Sushi', 'Desserts', 'Sugar', 'Sweets'];
  final RestaurantsListProvider restaurantsProvider = RestaurantsListProvider();
  static const String placeholderImage = 'assets/placeholder_image.png';

  int currentPage = 1;
  bool isLoading = false;
  bool hasMoreData = true;
  List<Data> restaurantData = [];

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _loadData();
  }

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

        final nextPageData = await restaurantsProvider.getRestaurantsList(
          page: currentPage,
        );

        if (nextPageData.data != null && nextPageData.data!.isNotEmpty) {
          setState(() {
            restaurantData.addAll(nextPageData.data!);
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
    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 5.0, right: 20, left: 20, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const CustomSearchField(hintText: "Search"),
            const Padding(
              padding: EdgeInsets.only(left: 13.0, top: 30),
              child: CustomText(text: "RESTAURANTS", color: btnbgColor, fontfamilly: montHeavy, sizeOfFont: 20),
            ),
            buildHorizontalList(items),
            buildVeerticalCards(),
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
              child: CustomText(text: items[index], color: hintColor, fontfamilly: montBook, sizeOfFont: 19,),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildVeerticalCards() {
    return Expanded(
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
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }

  Widget getFavCards(int index, Data data) {
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
                CustomText(text: data.name ?? "", color: btntxtColor, fontfamilly: montBold, sizeOfFont: 27, maxLin: 1,),
                CustomText(text: data.category ?? "", color: graysColor, fontfamilly: montRegular, sizeOfFont: 16, maxLin: 1,),
                CustomText(text: data.address ?? "", color: graysColor, sizeOfFont: 12, fontfamilly: montLight, maxLin: 1,),
                SizedBox(height: 5,),
                Row(
                  children: [
                    RatingBar.readOnly(
                      filledIcon: Icons.star,
                      emptyIcon: Icons.star_border,
                      filledColor: btnbgColor,
                      initialRating: 4,
                      size: 20,
                      maxRating: 5,
                    ),
                    SizedBox(width: 10,),
                    Expanded(child: CustomText(text: "3 offers available", color: offerColor, sizeOfFont: 10, fontfamilly: montRegular, maxLin: 1,)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8,),
          Expanded(
            child: Stack(
              alignment: Alignment.topRight,
              clipBehavior: Clip.none,
              children: [
                Image.network(
                  data.profileImage ?? food_image,
                  fit: BoxFit.contain,
                ),
                Positioned(
                  right: -4,
                  child: Image.asset(save_icon, height: 15, width: 18,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
