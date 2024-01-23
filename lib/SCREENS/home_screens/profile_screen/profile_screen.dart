import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeaplate/UTILS/app_strings.dart';
import '../../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../../MULTI-PROVIDER/FavoriteOperationProvider.dart';
import '../../../MULTI-PROVIDER/HomeDataListProvider.dart';
import '../../../MULTI-PROVIDER/SharedPrefsUtils.dart';
import '../../../Response_Model/FavAddedResponse.dart';
import '../../../Response_Model/FavDeleteResponse.dart';
import '../../../Response_Model/RestaurantsListResponse.dart';
import '../../../UTILS/app_color.dart';
import '../../../UTILS/app_images.dart';
import '../../../UTILS/fontfaimlly_string.dart';
import '../../../main.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  final HomeDataListProvider homeProvider = HomeDataListProvider();

  TextEditingController selectedImagePathController = TextEditingController();
  double screenHeight = MediaQuery.of(navigatorKey.currentContext!).size.height;
  double screenWidth = MediaQuery.of(navigatorKey.currentContext!).size.width;

  bool isFavorite = false;
  int currentPage = 1;
  bool isLoading = false;
  bool hasMoreData = true;

  bool isDateSelected = false; // Add a flag to check if the date is already selected
  List<StoreData> favoriteStoresAndDeals = [];

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

        final nextPageData = await homeProvider.getHomePageList(
          page: currentPage,
        );



        if (nextPageData.favoriteStores != null &&
            nextPageData.favoriteStores!.isNotEmpty) {
          setState(() {
            if (mounted) {
              favoriteStoresAndDeals=nextPageData.favoriteStores!;
            }
          });
        } else {
          setState(() {
            if (mounted) {
              hasMoreData = false;
              favoriteStoresAndDeals.clear();
            }
          });
        }


      } catch (error) {
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
        padding: const EdgeInsets.only(top: 5.0, right: 25, left: 25, bottom: 10),
        child: FutureBuilder<Map<String, String>>(
          future: SharedPrefsUtils.getDefaultValuesFromPrefs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                Map<String, String> data = snapshot.data!;
                fullNameController.text = data["fullName"]!;
                emailController.text = data["email"]!;
                phoneNumberController.text = data["phoneNumber"]!;
                dobController.text = data["dob"]!;
                selectedImagePathController.text = data["selectedImagePath"]!;

                return Column(
                  children: [
                    const SizedBox(height: 20),
                    getView(context),
                  ],
                );
              }
            } else {
              // Show a loading indicator while fetching data
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );

  }


  Widget buildSection(String title, String viewAllText) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 15.0,top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: title, color: btnbgColor, fontfamilly: montHeavy, sizeOfFont: 20),
          GestureDetector(child: CustomText(text: viewAllText, color: viewallColor, fontfamilly: montRegular,sizeOfFont: 12, ),

            onTap: (){
              if(title=="CURRENT ORDERS") {
                Navigator.pushNamed(
                    navigatorKey.currentContext!, '/MyOrdersSccreen');
              }
              else if(title=="MY FAVOURITES"){
                Navigator.pushNamed(
                    navigatorKey.currentContext!, '/FavouriteScreen');
              }
              else{
                Navigator.pushNamed(
                    navigatorKey.currentContext!, '/PaymentMethodScreen');
              }
            },
          ),
        ],
      ),
    );
  }

  Widget getCards({Color? bclor}) {
    return
      GestureDetector(
        onTap: (){
          Navigator.pushNamed(navigatorKey.currentContext!, '/YourOrderScreen');
        },
        child:
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 0,   color: editbgColor.withOpacity(0.25),),
              color: bclor?.withOpacity(0.40)
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(text: "Surprise Pack",maxLin: 1, color: btntxtColor, fontfamilly: montBold,sizeOfFont: 18,),

                    const CustomText(text: "Salad & Co.", maxLin:1,color: viewallColor, fontfamilly: montRegular,sizeOfFont: 14,),

                    const CustomText(text: "Tomorrow-7:35-8:40 Am",maxLin: 1, color: graysColor,sizeOfFont: 12, fontfamilly: montRegular),
                    const SizedBox(height: 5,),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            decoration: BoxDecoration(
                              color: readybgColor,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(width: 1, color: Colors.white),
                            ),
                            child: const CustomText(text: "READY FOR PICKUP",maxLin:1,sizeOfFont: 11,fontfamilly:montHeavy,color: readyColor,),
                          ),
                        ),
                        const SizedBox(width: 5,),
                        const Expanded(child: CustomText(text: "84 Km", color: graysColor,sizeOfFont: 13, fontfamilly: montSemiBold,)),
                      ],

                    ),
                    const SizedBox(height: 0,),
                    const CustomText(text: "\$"+"9.99", color: dolorColor,sizeOfFont: 20, fontfamilly: montHeavy,),

                  ],
                ),
              ),
              const SizedBox(width: 18,),
              Expanded(
                flex: 0,
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
        ),
      );
  }
  Widget getView(BuildContext context){
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [


                selectedImagePathController.text !=''
                    ? ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(
                      selectedImagePathController.text,
                      fit: BoxFit.cover,
                      height: 94,width: 95,
                    )
                ): Image.asset(profile,height: 94,width: 95,),

                const SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(text: fullNameController.text,color: viewallColor,sizeOfFont: 20,fontfamilly: montBold,),
                    CustomText(text: emailController.text,maxLin:1,sizeOfFont: 13,fontfamilly:montRegular,color: viewallColor,),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: editprofilbgColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 1, color: Colors.white),
                      ),
                      child: GestureDetector(onTap:(){
                        Navigator.pushNamed(
                            navigatorKey.currentContext!, '/EditProfileScreen');
                      },child: const CustomText(text: "EDIT PROFILE",sizeOfFont: 10,fontfamilly:montBold,color: editprofileColor,)),
                    )
                  ],
                ),
                // profileSection()
              ],
            ),
            const SizedBox(height: 30,),
            buildSection("CURRENT ORDERS", viewAll),
            const SizedBox(height: 5,),
            getCards(bclor: onboardingBtn),
            getCards(),
            const Padding(
              padding: EdgeInsets.only(left: 25.0,right: 25,top: 15,bottom: 15),
              child: Divider(height: 0,color: grayColor,thickness: 0,),
            ),
            buildSection("MY FAVOURITES", viewAll),
            const SizedBox(height: 5,),
            buildMyFavoriteCards(context),
            const Padding(
              padding: EdgeInsets.only(left: 25.0,right: 25,top: 15,bottom: 15),
              child: Divider(height: 0,color: grayColor,thickness: 0,),
            ),
            buildSection("PAYMENT METHOD", viewAll),
            const SizedBox(height: 5,),
            getMasterCard()
          ],
        ),
      ),
    );
  }
  Widget getMasterCard(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: mastercardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 0,   color: editbgColor.withOpacity(0.25),),
      ),
      child:  Row(
        children: [
          Image.asset(master_card,fit: BoxFit.contain,height: 40,width: 70,),
          const SizedBox(width: 10,),
          const Expanded(child: CustomText(text: "MasterCard",color: btntxtColor,sizeOfFont: 15,fontfamilly: montBold,)),
          const CustomText(text: "-2211",color: btntxtColor,sizeOfFont: 14,fontfamilly: montRegular,),
        ],
      ),
    );
  }

  Widget buildMyFavoriteCards(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          favoriteStoresAndDeals.length,
              (index) => GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  navigatorKey.currentContext!,
                  '/RestaurantsProfileScreen',
                  arguments: favoriteStoresAndDeals[
                  index], // Pass the data as arguments
                );
              },
              child: getFavCardsData(index, favoriteStoresAndDeals[index],context)),
        ),
      ),
    );
  }

  Widget getFavCardsData(int index, StoreData favoriteStores, BuildContext context) {
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
                sizeOfFont: 22,
              ),
              CustomText(
                text: favoriteStores.category ?? '',
                color: btntxtColor,
                fontfamilly: montRegular,
                sizeOfFont: 14,
              ),
              const CustomText(
                text: '3 Offers available',
                color: offerColor,
                sizeOfFont: 12,
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
                    initialRating: 4,
                    size: 18,
                    maxRating: 5,
                  ),
                  const SizedBox(width: 10),
                  Container(
                    margin:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
          const SizedBox(width: 18),
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
                      colors: [
                        Colors.white,
                        Colors.grey
                      ], // Adjust colors as needed
                    ),
                  ),
                  child: favoriteStores.profileImage != null && !(favoriteStores.profileImage)!.contains("SocketException")
                      ? ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.network(
                        favoriteStores.profileImage!,
                        fit: BoxFit.cover,
                        height: 90,
                        width: 100,
                      ))
                      : Image.asset(
                    food_image,
                    height: 90,
                    width: 100,
                  ),
                ),
              ),
              Positioned(
                right: -4,
                child: GestureDetector(
                  onTap: () async {
                    bool? ratingStatus = favoriteStores.favourite;


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
                            favoriteStores.id ?? 0, formData);

                        if (favData.status == true &&
                            favData.message ==
                                "Store Added in favourite successfully.") {
                          // Print data to console

                          final snackBar = SnackBar(
                            content: Text('${favData.message}'),
                          );

                          // Show the SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          // Automatically hide the SnackBar after 1 second
                          Future.delayed(const Duration(milliseconds: 1000), () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          });

                          setState(() {
                            favoriteStores.favourite = true;
                          });

                          await refreshData();

                        } else {
                          // API call failed

                          final snackBar = SnackBar(
                            content: Text('${favData.message}'),
                          );

                          // Show the SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          // Automatically hide the SnackBar after 1 second
                          Future.delayed(const Duration(milliseconds: 1000), () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          });
                        }
                      } else if (favoriteStores.favourite == true) {
                        // If storeData.favourite is false, print its value
                        FavDeleteResponse delData = await Provider.of<
                            FavoriteOperationProvider>(context,
                            listen: false)
                            .RemoveFromFavoriteStore(favoriteStores.id ?? 0);

                        if (delData.status == true &&
                            delData.message ==
                                "Favourite Store deleted successfully") {
                          // Print data to console

                          final snackBar = SnackBar(
                            content: Text('${delData.message}'),
                          );

                          // Show the SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          // Automatically hide the SnackBar after 1 second
                          Future.delayed(const Duration(milliseconds: 1000), () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          });

                          setState(() {
                            favoriteStores.favourite = false;
                          });

                          await refreshData();

                        } else {
                          // API call failed

                          final snackBar = SnackBar(
                            content: Text('${delData.message}'),
                          );

                          // Show the SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          // Automatically hide the SnackBar after 1 second
                          Future.delayed(const Duration(milliseconds: 1000), () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
                    favoriteStores.favourite == true ? save_icon_red : save_icon,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> refreshData() async {
    final nextPageData = await homeProvider.getHomePageList(
      page: currentPage,
    );


    if (nextPageData.favoriteStores != null &&
        nextPageData.favoriteStores!.isNotEmpty) {
      setState(() {
        if (mounted) {
          favoriteStoresAndDeals = nextPageData.favoriteStores!;
        }
      });
    } else {
      setState(() {
        if (mounted) {
          hasMoreData = false;
          favoriteStoresAndDeals.clear();
        }
      });
    }
  }

}

