import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/app_images.dart';
import 'package:takeaplate/UTILS/app_strings.dart';
import 'package:takeaplate/UTILS/fontfaimlly_string.dart';
import 'package:takeaplate/main.dart';
import '../../CUSTOM_WIDGETS/custom_search_field.dart';
import '../../MULTI-PROVIDER/FavCardsProvider.dart';

import '../../MULTI-PROVIDER/HomeDataListProvider.dart';
import '../../Response_Model/HomeItemsListingResponse.dart';
import '../../Response_Model/RestaurantDealResponse.dart';
import '../../Response_Model/RestaurantsListResponse.dart';




class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<String> items = ['Healthy', 'Sushi', 'Desserts', 'Sugar', 'Sweets'];
  final HomeDataListProvider restaurantsProvider = HomeDataListProvider();
  bool isFavorite = false;
  int currentPage = 1;
  bool isLoading = false;
  bool hasMoreData = true;

  List<StoreData>? closedRestaurants = [];
  List<DealData>? lastMinuteDeals = [];
  List<StoreData>? favoriteStoresAndDeals = [];
  List<StoreData>? collectTomorrowList = [];


  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    if (!isLoading && hasMoreData) {
      try {
        setState(() {
          isLoading = true;
        });

        final nextPageData = await restaurantsProvider.getHomePageList(
          page: currentPage,
        );




          if (nextPageData.data != null && nextPageData.data!.isNotEmpty) {
            currentPage++;

            setState(() {
              if (mounted) {
                closedRestaurants?.addAll(nextPageData.data!);

              }
            });
          }

          else {
            setState(() {
              if (mounted) {
                hasMoreData = false;
              }
            });
          }


          if (nextPageData.dealData != null && nextPageData.dealData!.isNotEmpty) {
            setState(() {
              if (mounted) {
                lastMinuteDeals?.addAll(nextPageData.dealData!);


              }
            });
          }

          else {
            setState(() {
              if (mounted) {
                hasMoreData = false;
              }
            });
          }




        if (nextPageData.favoriteStores != null && nextPageData.favoriteStores!.isNotEmpty) {
          setState(() {
            if (mounted) {
              favoriteStoresAndDeals?.addAll(nextPageData.favoriteStores!);
            }
          });
        }

        else {
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
        padding: const EdgeInsets.only(top: 9.0,right:20,left: 20 ,bottom: 10),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            CustomSearchField(hintText: "Search"),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [

                    buildHorizontalList(items),
                    buildSection(closet, viewall),
                    buildClosestDealCards(),
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0,left: 20,right: 20,bottom: 15),
                      child: Divider(
                        color: Colors.grey,
                        thickness: 0,),),
                    buildSection(lastminute, viewall),
                    buildLastMinuteDealCards(),

                    const Padding(
                      padding: EdgeInsets.only(top: 10.0,left: 15,right: 15,bottom: 15),
                      child: Divider(
                        color: Colors.grey,
                        thickness: 0,
                      ),
                    ),
                    buildSection(collectTomorrow, viewall),
                    buildCollectTomorrowCards(),

                    const Padding(
                      padding: EdgeInsets.only(top: 10.0,left: 15,right: 15,bottom: 15),
                      child: Divider(
                        color: Colors.grey,
                        thickness: 0,
                      ),
                    ),
                    buildSection(myfav, viewall),
                    buildMyFavoriteCards(),
                  ],
                ),
              ),
            ),
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
            onTap: (){
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 36),
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

  Widget buildSection(String title, String viewAllText) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0,right: 13.0,top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: title, color: btnbgColor, fontfamilly: montHeavy,  sizeOfFont: 20),
          GestureDetector(
              onTap: (){
                if(title==closet) {
                  Navigator.pushNamed(
                      navigatorKey.currentContext!, '/ClosestScreen');
                }
                else if(title==lastminute){
                  Navigator.pushNamed(navigatorKey.currentContext!, '/LastMinuteDealScreen');
                }
                else if(title==myfav){
                  Navigator.pushNamed(navigatorKey.currentContext!, '/FavouriteScreen');
                }
              },

              child: CustomText(text: viewAllText, color: viewallColor, fontfamilly: montRegular,sizeOfFont: 12,)),
        ],
      ),
    );
  }

  Widget buildClosestDealCards() {

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          closedRestaurants!.length,
              (index) => GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  navigatorKey.currentContext!,
                  '/RestaurantsProfileScreen',
                  arguments: closedRestaurants![index], // Pass the data as arguments
                );
              },
              child: getClosestDealData(index, closedRestaurants![index])),
        ),
      ),
    );
  }

  Widget getClosestDealData(int index, StoreData storeData) {

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: storeData.name ?? '',
                color: btntxtColor,
                fontfamilly: montBold,
                sizeOfFont: 24,
              ),
              CustomText(
                text: storeData.category ?? '',
                color: btntxtColor,
                fontfamilly: montRegular,
                sizeOfFont: 14,
              ),
              CustomText(
                text: '3 Offers available',
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
                    initialRating: 4,
                    size: 18,
                    maxRating: 5,
                  ),
                  SizedBox(width: 10),

                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: editbgColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const CustomText(text: "4 km",maxLin:1,sizeOfFont: 10,fontfamilly:montHeavy,color: btnbgColor,),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(width: 18),
          Stack(
            alignment: Alignment.topRight,
            clipBehavior: Clip.none,
            children: [

              storeData.profileImage != null ? ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    storeData.profileImage!,
                    fit: BoxFit.cover,
                    height: 100, width: 100,
                  )
              ): Image.asset(food_image,height: 100, width: 100,),

              Positioned(
                right: -4,
                child: Image.asset(
                  save_icon,
                  height: 15,
                  width: 18,
                ),
              ),
            ],
          ),


        ],
      ),
    );
  }

  Widget buildLastMinuteDealCards() {

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          lastMinuteDeals!.length,
              (index) => GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  navigatorKey.currentContext!,
                  '/OrderAndPayScreen',
                  arguments: lastMinuteDeals![index], // Pass the data as arguments
                );
              },
              child: getLastMinuteDealsData(index, lastMinuteDeals![index])),
        ),
      ),
    );
  }

  Widget getLastMinuteDealsData(int index, DealData lastMinuteDeal) {
    var startTiming = lastMinuteDeal.customTime?.startTime;
    var endTiming = lastMinuteDeal.customTime?.endTime;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 0,   color: editbgColor.withOpacity(0.25),),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: lastMinuteDeal.name ?? '', color: btntxtColor, fontfamilly: montBold,sizeOfFont: 18,),

              CustomText(text: lastMinuteDeal.store?.name ?? '', color: btntxtColor, fontfamilly: montRegular,sizeOfFont: 13,),

              CustomText(text: '${startTiming ?? ""} - ${endTiming ?? ""}', color: graysColor,sizeOfFont: 8, fontfamilly: montRegular),
              SizedBox(height: 5,),
              Row(
                children: [
                  RatingBar.readOnly(
                    filledIcon: Icons.star,
                    emptyIcon: Icons.star_border,
                    halfFilledIcon: Icons.star_half,
                    isHalfAllowed: true,
                    halfFilledColor: btnbgColor,
                    filledColor: btnbgColor,
                    size: 20,
                    initialRating: double.parse(lastMinuteDeal.averageRating ?? '0'),
                    maxRating: 5,
                  ),
                  SizedBox(width: 10,),
                  CustomText(text: '8KM', color: graysColor,sizeOfFont: 12, fontfamilly: montSemiBold),
                ],

              ),
              SizedBox(height: 5,),
              CustomText(text: '\$ ${lastMinuteDeal.price ?? "NA"}', color: dolorColor,sizeOfFont: 24, fontfamilly: montHeavy,),

            ],
          ),
          const SizedBox(width: 18,),
          Align(
            alignment: Alignment.centerRight,
            child: Stack(
              alignment: Alignment.topRight,
              clipBehavior: Clip.none,
              children: [
                // lastMinuteDeal.profileImage != null ? ClipRRect(
                //     borderRadius: BorderRadius.circular(15.0),
                //     child: Image.network(
                //       lastMinuteDeal.profileImage!,
                //       fit: BoxFit.cover,
                //       height: 120, width: 100,
                //     )
                // ): Image.asset(food_image,height: 100, width: 100,),

                Image.asset(food_image,height: 110, width: 100,fit: BoxFit.cover,),

                Positioned(
                  right: -4,
                  child: Image.asset(
                    save_icon,
                    height: 15,
                    width: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCollectTomorrowCards() {

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          lastMinuteDeals!.length,
              (index) => GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  navigatorKey.currentContext!,
                  '/OrderAndPayScreen',
                  arguments: lastMinuteDeals![index], // Pass the data as arguments
                );
              },
              child: getCollectTomorrowData(index, lastMinuteDeals![index])),
        ),
      ),
    );
  }


  Widget getCollectTomorrowData(int index, DealData lastMinuteDeal) {

    var startTiming = lastMinuteDeal.customTime?.startTime;
    var endTiming = lastMinuteDeal.customTime?.endTime;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 0,   color: editbgColor.withOpacity(0.25),),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: lastMinuteDeal.name ?? '', color: btntxtColor, fontfamilly: montBold,sizeOfFont: 18,),

              CustomText(text: lastMinuteDeal.store?.name ?? '', color: btntxtColor, fontfamilly: montRegular,sizeOfFont: 13,),

              CustomText(text: '${startTiming ?? ""} - ${endTiming ?? ""}', color: graysColor,sizeOfFont: 8, fontfamilly: montRegular),
              SizedBox(height: 5,),
              Row(
                children: [
                  RatingBar.readOnly(
                    filledIcon: Icons.star,
                    emptyIcon: Icons.star_border,
                    halfFilledIcon: Icons.star_half,
                    isHalfAllowed: true,
                    halfFilledColor: btnbgColor,
                    filledColor: btnbgColor,
                    size: 20,
                    initialRating: double.parse(lastMinuteDeal.averageRating ?? '0'),
                    maxRating: 5,
                  ),
                  SizedBox(width: 10,),
                  CustomText(text: '8KM', color: graysColor,sizeOfFont: 12, fontfamilly: montSemiBold),
                ],

              ),
              SizedBox(height: 5,),
              CustomText(text: '\$ ${lastMinuteDeal.price ?? "NA"}', color: dolorColor,sizeOfFont: 24, fontfamilly: montHeavy,),

            ],
          ),
          const SizedBox(width: 18,),
          Align(
            alignment: Alignment.centerRight,
            child: Stack(
              alignment: Alignment.topRight,
              clipBehavior: Clip.none,
              children: [
                // lastMinuteDeal.profileImage != null ? ClipRRect(
                //     borderRadius: BorderRadius.circular(15.0),
                //     child: Image.network(
                //       lastMinuteDeal.profileImage!,
                //       fit: BoxFit.cover,
                //       height: 120, width: 100,
                //     )
                // ): Image.asset(food_image,height: 100, width: 100,),

                Image.asset(food_image,height: 110, width: 100,fit: BoxFit.cover,),

                Positioned(
                  right: -4,
                  child: Image.asset(
                    save_icon,
                    height: 15,
                    width: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget buildMyFavoriteCards() {

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          favoriteStoresAndDeals!.length,
              (index) => GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  navigatorKey.currentContext!,
                  '/RestaurantsProfileScreen',
                  arguments: favoriteStoresAndDeals![index], // Pass the data as arguments
                );
              },
              child: getFavCardsData(index, favoriteStoresAndDeals![index])),
        ),
      ),
    );
  }

  Widget getFavCardsData(int index, StoreData favoriteStores) {

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: favoriteStores.name ?? '',
                color: btntxtColor,
                fontfamilly: montBold,
                sizeOfFont: 24,
              ),
              CustomText(
                text: favoriteStores.category ?? '',
                color: btntxtColor,
                fontfamilly: montRegular,
                sizeOfFont: 14,
              ),
              CustomText(
                text: '3 Offers available',
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
                    initialRating: 4,
                    size: 18,
                    maxRating: 5,
                  ),
                  SizedBox(width: 10),

                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: editbgColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const CustomText(text: "4 km",maxLin:1,sizeOfFont: 10,fontfamilly:montHeavy,color: btnbgColor,),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(width: 18),
          Stack(
            alignment: Alignment.topRight,
            clipBehavior: Clip.none,
            children: [

              favoriteStores.profileImage != null ? ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(
                    favoriteStores.profileImage!,
                    fit: BoxFit.cover,
                    height: 100, width: 100,
                  )
              ): Image.asset(food_image,height: 100, width: 100,),


              Positioned(
                right: -4,
                child: Image.asset(
                 save_icon_red,
                  height: 15,
                  width: 18,
                ),
              ),
            ],
          ),


        ],
      ),
    );
  }

}


