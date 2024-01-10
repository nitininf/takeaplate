import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_button.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/app_images.dart';
import 'package:takeaplate/UTILS/app_strings.dart';
import 'package:takeaplate/UTILS/fontfaimlly_string.dart';
import 'package:takeaplate/main.dart';
import '../../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../../CUSTOM_WIDGETS/custom_search_field.dart';
import '../../MULTI-PROVIDER/FavCardsProvider.dart';
import '../../MULTI-PROVIDER/PlaceListProvider.dart';
import '../../UTILS/utils.dart';

class HomeScreen extends StatelessWidget {
  final List<String> items = ['Healthy', 'Sushi', 'Desserts', 'Sugar', 'Sweets'];



  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration.zero, () async {
      bool isLocationPermissionGranted =
      await requestLocationPermissionAndShowAlert(context);

      if (isLocationPermissionGranted) {
        Position position =
        await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        final snackBar = SnackBar(
          content:  Text('Current Location : ${position.latitude} - ${position.longitude}'),
          action: SnackBarAction(
            label: 'Ok',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });


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
                    buildLastMinuteDealCards(context),

                    const Padding(
                      padding: EdgeInsets.only(top: 10.0,left: 15,right: 15,bottom: 15),
                      child: Divider(
                        color: Colors.grey,
                        thickness: 0,
                      ),
                    ),
                    buildSection(collectTomorrow, viewall),
                    buildCollectTomorrowCards(context),

                    const Padding(
                      padding: EdgeInsets.only(top: 10.0,left: 15,right: 15,bottom: 15),
                      child: Divider(
                        color: Colors.grey,
                        thickness: 0,
                      ),
                    ),
                    buildSection(myfav, viewall),
                    buildMyFavoriteCards(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

  // Horizontal scroll for food type - healthy , sushi etc

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
    return Consumer<PlaceListProvider>(
      builder: (context, dataProvider, child) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              dataProvider.items.length,
                  (index) => getClosestDealData(context, dataProvider.items[index]),
            ),
          ),
        );
      },
    );
  }

  Widget getClosestDealData(BuildContext context, Map<String, dynamic> data) {

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
                text: data['title'],
                color: btntxtColor,
                fontfamilly: montBold,
                sizeOfFont: 24,
              ),
              CustomText(
                text: data['category'],
                color: btntxtColor,
                fontfamilly: montRegular,
                sizeOfFont: 14,
              ),
              CustomText(
                text: data['offers'],
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
                    filledColor: btnbgColor,
                    initialRating: data['rating'].toDouble(),
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
              data.length%2==0 ? Image.asset(restrorent_img, height: 83, width: 80, fit: BoxFit.contain) :Image.asset(food_image, height: 83, width: 80, fit: BoxFit.contain),
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

  Widget buildLastMinuteDealCards(BuildContext context) {
    return Consumer<FavCardsProvider>(
      builder: (context, dataProvider, child) {
        // List<Map<String, dynamic>> recentItems = dataProvider.items.take(2).toList();
        //
        // return Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: recentItems.map((item) {
        //
        //     return GestureDetector(
        //       // onTap: (){
        //       //   print(item.length);
        //       //   Navigator.pushNamed(
        //       //     context,
        //       //     '/OrderAndPayScreen',
        //       //   );
        //       // },
        //         child: getLastMinuteDealsCards(context, item));
        //   }).toList(),
        // );

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              dataProvider.items.length,
                  (index) => getLastMinuteDealsData(context, dataProvider.items[index]),
            ),
          ),
        );

      },
    );
  }

  Widget getLastMinuteDealsData(BuildContext context, Map<String, dynamic> data) {
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
              CustomText(text: data['name'], color: btntxtColor, fontfamilly: montBold,sizeOfFont: 18,),

              CustomText(text: data['restaurant'], color: btntxtColor, fontfamilly: montRegular,sizeOfFont: 13,),

              CustomText(text: data['time'], color: graysColor,sizeOfFont: 8, fontfamilly: montRegular),
              SizedBox(height: 5,),
              Row(
                children: [
                  RatingBar.readOnly(
                    filledIcon: Icons.star,
                    emptyIcon: Icons.star_border,
                    filledColor: btnbgColor,
                    size: 20,
                    initialRating: data['rating'].toDouble(),
                    maxRating: 5,
                  ),
                  SizedBox(width: 10,),
                  CustomText(text: data['distance'], color: graysColor,sizeOfFont: 12, fontfamilly: montSemiBold),
                ],

              ),
              SizedBox(height: 5,),
              CustomText(text: "\$"+data['price'], color: dolorColor,sizeOfFont: 24, fontfamilly: montHeavy,),

            ],
          ),
          const SizedBox(width: 18,),
          Align(
            alignment: Alignment.centerRight,
            child: Stack(
              alignment: Alignment.topRight,
              clipBehavior: Clip.none,
              children: [
                Image.asset(food_image, height: 100, width: 100, fit: BoxFit.cover),
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

  Widget buildCollectTomorrowCards(BuildContext context) {
    return Consumer<FavCardsProvider>(
      builder: (context, dataProvider, child) {
        // List<Map<String, dynamic>> recentItems = dataProvider.items.take(2).toList();
        //
        // return Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: recentItems.map((item) {
        //
        //     return GestureDetector(
        //       // onTap: (){
        //       //   print(item.length);
        //       //   Navigator.pushNamed(
        //       //     context,
        //       //     '/OrderAndPayScreen',
        //       //   );
        //       // },
        //         child: getLastMinuteDealsCards(context, item));
        //   }).toList(),
        // );

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              dataProvider.items.length,
                  (index) => getCollectTomorrowData(context, dataProvider.items[index]),
            ),
          ),
        );

      },
    );
  }

  Widget getCollectTomorrowData(BuildContext context, Map<String, dynamic> data) {
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
              CustomText(text: data['name'], color: btntxtColor, fontfamilly: montBold,sizeOfFont: 18,),

              CustomText(text: data['restaurant'], color: btntxtColor, fontfamilly: montRegular,sizeOfFont: 13,),

              CustomText(text: data['time'], color: graysColor,sizeOfFont: 8, fontfamilly: montRegular),
              SizedBox(height: 5,),
              Row(
                children: [
                  RatingBar.readOnly(
                    filledIcon: Icons.star,
                    emptyIcon: Icons.star_border,
                    filledColor: btnbgColor,
                    size: 20,
                    initialRating: data['rating'].toDouble(),
                    maxRating: 5,
                  ),
                  SizedBox(width: 10,),
                  CustomText(text: data['distance'], color: graysColor,sizeOfFont: 12, fontfamilly: montSemiBold),
                ],

              ),
              SizedBox(height: 5,),
              CustomText(text: "\$"+data['price'], color: dolorColor,sizeOfFont: 24, fontfamilly: montHeavy,),

            ],
          ),
          const SizedBox(width: 18,),
          Stack(
            alignment: Alignment.topRight,
            clipBehavior: Clip.none,
            children: [
              Image.asset(food_image, height: 100, width: 100, fit: BoxFit.cover),
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

  Widget buildMyFavoriteCards(BuildContext context) {
    return Consumer<FavCardsProvider>(
      builder: (context, dataProvider, child) {
        // List<Map<String, dynamic>> recentItems = dataProvider.items.take(2).toList();
        //
        // return Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: recentItems.map((item) {
        //
        //     return GestureDetector(
        //       // onTap: (){
        //       //   print(item.length);
        //       //   Navigator.pushNamed(
        //       //     context,
        //       //     '/OrderAndPayScreen',
        //       //   );
        //       // },
        //         child: getLastMinuteDealsCards(context, item));
        //   }).toList(),
        // );

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              dataProvider.items.length,
                  (index) => getFavCardsData(context, dataProvider.items[index]),
            ),
          ),
        );

      },
    );
  }

  Widget getFavCardsData(BuildContext context, Map<String, dynamic> data) {
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
              CustomText(text: data['name'], color: btntxtColor, fontfamilly: montBold,sizeOfFont: 18,),

              CustomText(text: data['restaurant'], color: btntxtColor, fontfamilly: montRegular,sizeOfFont: 13,),

              CustomText(text: data['time'], color: graysColor,sizeOfFont: 8, fontfamilly: montRegular),
              SizedBox(height: 5,),
              Row(
                children: [
                 RatingBar.readOnly(
                    filledIcon: Icons.star,
                    emptyIcon: Icons.star_border,
                    filledColor: btnbgColor,
                    size: 20,
                    initialRating: data['rating'].toDouble(),
                    maxRating: 5,
                  ),
                  SizedBox(width: 10,),
                  CustomText(text: data['distance'], color: graysColor,sizeOfFont: 12, fontfamilly: montSemiBold),
                   ],

              ),
              SizedBox(height: 5,),
              CustomText(text: "\$"+data['price'], color: dolorColor,sizeOfFont: 24, fontfamilly: montHeavy,),

            ],
          ),
          const SizedBox(width: 18,),
          Stack(
            alignment: Alignment.topRight,
            clipBehavior: Clip.none,
            children: [
              Image.asset(food_image, height: 100, width: 100, fit: BoxFit.cover),
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

  Future<bool> requestLocationPermissionAndShowAlert(BuildContext context) async {
    var status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      return true;
    } else if (status == PermissionStatus.denied) {
      final snackBar = SnackBar(
        content:  Text('Location permission denied", "To use the features of NearBy or location , Please allow the permission'),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () async {
            // Some code to undo the change.
           await requestLocationPermissionAndShowAlert(context);
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return false;
    } else {
      final snackBar = SnackBar(
        content:  Text('Location permission denied", "To use the features of NearBy or location , Please allow the permission'),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () async {
            // Some code to undo the change.
            await requestLocationPermissionAndShowAlert(context);

          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      // Handle other cases like PermissionStatus.permanentlyDenied
      // You may want to open app settings here
      return false;
    }
  }


}
