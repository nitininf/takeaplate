import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_button.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/main.dart';

import '../../../UTILS/app_images.dart';
import '../../../UTILS/fontfamily_string.dart';
import '../../CUSTOM_WIDGETS/common_edit_text.dart';
import '../../MULTI-PROVIDER/CartOperationProvider.dart';
import '../../MULTI-PROVIDER/PaymentDetailsProvider.dart';
import '../../Response_Model/AddPaymentCardResponse.dart';
import '../../Response_Model/AddToCartResponse.dart';
import '../../Response_Model/CardListResponse.dart';
import '../../Response_Model/CartListingResponse.dart';
import '../../UTILS/app_strings.dart';
import '../../UTILS/dialog_helper.dart';
import '../../UTILS/request_string.dart';

TextEditingController nameController = TextEditingController();
TextEditingController cardNumberController = TextEditingController();
TextEditingController expiryController = TextEditingController();
TextEditingController cvvController = TextEditingController();

final CartOperationProvider cartOperationProvider = CartOperationProvider();
final PaymentDetailsProvider carDOperationProvider = PaymentDetailsProvider();

class OrderSummeryScreen extends StatefulWidget {
  const OrderSummeryScreen({super.key});

  @override
  _OrderSummeryScreenState createState() => _OrderSummeryScreenState();
}

class _OrderSummeryScreenState extends State<OrderSummeryScreen> {
  int currentPage = 1;
  bool isLoading = false;
  bool hasMoreData = true;
  List<CartItems> cartItemsData = [];
  List<CardData> cardListData = [];
  var totalPrice = 0;

  int selectedCardIndex = -1;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  void _loadData() async {


    Future.delayed(Duration.zero,() async {

      if (!isLoading && hasMoreData) {
        try {
          setState(() {
            isLoading = true;
          });

          final nextPageData = await cartOperationProvider.getCartList();

          totalPrice = nextPageData.totalPrice ?? 0;

          if (nextPageData.cartItems != null &&
              nextPageData.cartItems!.isNotEmpty) {
            setState(() {
              if (mounted) {
                cartItemsData = nextPageData.cartItems!;

                // cartItemsData.addAll(nextPageData.cartItems!);
                // currentPage++;
              }
            });
          } else {
            setState(() {
              if (mounted) {
                hasMoreData = false;
                cartItemsData.clear();
              }
            });
          }

          final paymentCardData = await carDOperationProvider.getCardList();

          if (paymentCardData.data != null && paymentCardData.data!.isNotEmpty) {
            setState(() {
              if (mounted) {
                cardListData = paymentCardData.data!;

                // cartItemsData.addAll(nextPageData.cartItems!);
                // currentPage++;
              }
            });
          } else {
            setState(() {
              if (mounted) {
                hasMoreData = false;
                cardListData.clear();
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

    },);



  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Scaffold(
            backgroundColor: bgColor,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 25.0, left: 25, bottom: 0, top: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomAppBar(),
                    SizedBox(
                      height: 10,
                    ),
                    getView(screenHeight, context),
                  ],
                ),
              ),
            )),
        Visibility(
          visible: isLoading,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: Colors.black.withOpacity(0.1),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget getView(double screenHeight, BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "ORDER SUMMARY",
                  color: editbgColor,
                  sizeOfFont: 20,
                  fontfamilly: montHeavy,
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: editprofilbgColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1, color: Colors.white),
                  ),
                  child: const CustomText(
                    text: "ADD MORE",
                    sizeOfFont: 10,
                    weight: FontWeight.w800,
                    color: editprofileColor,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(width: 0.5, color: editprofileColor)),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  getVerticalItemList(),
                  SizedBox(height: screenHeight * 0.040),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                    decoration: BoxDecoration(
                        color: onboardingBtn.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(width: 0, color: grayColor)),
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "Total",
                            color: viewallColor,
                            sizeOfFont: 21,
                            fontfamilly: montBold,
                          ),
                          CustomText(
                            text: "\$${totalPrice}",
                            color: offerColor,
                            sizeOfFont: 21,
                            fontfamilly: montBold,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "PAYMENT METHOD",
                  color: editbgColor,
                  sizeOfFont: 21,
                  fontfamilly: montBold,
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: editprofilbgColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1, color: Colors.white),
                  ),
                  child: GestureDetector(
                    child: const CustomText(
                      text: "ADD NEW",
                      sizeOfFont: 10,
                      weight: FontWeight.w800,
                      color: editprofileColor,
                    ),
                    onTap: () {
                      addCardDialoge(navigatorKey.currentContext!);
                    },
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            getPaymentCardList(),
            Padding(
              padding: const EdgeInsets.only(
                  top: 30.0, right: 33, left: 33, bottom: 20),
              child: CommonButton(
                  btnBgColor: btnbgColor,
                  btnText: "ORDER & PAY",
                  onClick: () {
                    // Check if any item is selected
                    if (selectedCardIndex != -1) {
                      // Get the selected item details using selectedCardIndex
                      CardData selectedCard = cardListData[selectedCardIndex];

                      // Print the selected item details
                      print("Selected Card Details:");
                      print("Card Type: ${selectedCard.cardType}");
                      print("Card Id: ${selectedCard.id}");
                      print(
                          "Last 4 Digits: ${selectedCard.cardNumber?.substring(selectedCard.cardNumber!.length - 4, selectedCard.cardNumber!.length)}");

                      // Show the success popup
                      DialogHelper.showCommonPopup(navigatorKey.currentContext!,
                          title: "YOUR PAYMENT WAS SUCCESSFUL",
                          subtitle:
                              "YOU WILL GET A NOTIFICATION WHEN THE ORDER IS CONFIRMED");
                    } else {
                      // No item selected, show an error message or handle as needed

                      final snackBar = SnackBar(
                        content: Text('No card selected'),
                      );

                      // Show the SnackBar
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      // Automatically hide the SnackBar after 1 second
                      Future.delayed(Duration(milliseconds: 1000), () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      });
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget getPaymentCardList() {
    return Container(
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: editprofileColor, width: 0.5),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: cardListData.length,
        itemBuilder: (context, index) {
          if (index < cardListData.length) {
            return GestureDetector(
              onTap: () {
                // Set the selected index when an item is clicked
                setState(() {
                  selectedCardIndex = index;
                });
              },
              child: Container(
                // Adjust the bottom margin as needed

                child: getMasterCard(hintColor, index, cardListData[index]),
              ),
            );
          } else {
            return FutureBuilder(
              future: Future.delayed(Duration(milliseconds: 500)),
              builder: (context, snapshot) =>
                  snapshot.connectionState == ConnectionState.done
                      ? SizedBox()
                      : Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }

  Widget getMasterCard(Color colorbg, int index, CardData cardListData) {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 0),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: selectedCardIndex == index ? editprofileColor : null,
        borderRadius: BorderRadius.circular(20),
        border: null,
      ),
      child: Row(
        children: [
          cardListData.imagePath != null &&
                  !(cardListData.imagePath)!.contains("SocketException")
              ? Container(
                  child: ClipRRect(
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0, // Adjust the width as needed
                        ),
                      ),
                      child: Image.network(
                        cardListData.imagePath!,
                        fit: BoxFit.cover,
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                )
              : Image.asset(
                  food_image,
                  height: 40,
                  width: 70,
                ),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: CustomText(
            text: cardListData.cardType ?? "",
            color: viewallColor,
            sizeOfFont: 14,
            fontfamilly: montBold,
          )),
          CustomText(
            text:
                '- ${cardListData.cardNumber?.substring(cardListData.cardNumber!.length - 4, cardListData.cardNumber!.length)}' ??
                    "",
            color: viewallColor,
            sizeOfFont: 14,
            fontfamilly: montRegular,
          ),
        ],
      ),
    );
  }

  Widget getVerticalItemList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: cartItemsData.length,
      itemBuilder: (context, index) {
        if (index < cartItemsData.length) {
          return getCardViews(index, cartItemsData[index]);
        } else {
          return FutureBuilder(
            future: Future.delayed(Duration(milliseconds: 500)),
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.done
                    ? SizedBox()
                    : Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Widget getCardViews(int index, CartItems itemData) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0, left: 10, top: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              itemData.dealImage != null &&
                      !(itemData.dealImage)!.contains("SocketException")
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        itemData.dealImage!,
                        fit: BoxFit.cover,
                        height: 40,
                        width: 40,
                      ))
                  : Image.asset(
                      food_image,
                      height: 40,
                      width: 40,
                    ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: itemData.dealName ?? '',
                      maxLin: 1,
                      color: btntxtColor,
                      fontfamilly: montBold,
                      sizeOfFont: 15,
                    ),
                    CustomText(
                      text: itemData.storeName ?? '',
                      maxLin: 1,
                      color: btntxtColor,
                      fontfamilly: montRegular,
                      sizeOfFont: 11,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                flex: 0,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  decoration: BoxDecoration(
                    color: btnbgColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(width: 1, color: Colors.white),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          var cartId = itemData.cartId ?? '';

                          print('cartId:$cartId');

                          try {
                            AddToCartResponse decrementStatus =
                                await Provider.of<CartOperationProvider>(
                                        context,
                                        listen: false)
                                    .decreaseItemQuantity(cartId);

                            if (decrementStatus.status == true &&
                                decrementStatus.message ==
                                    "Quantity decremented successfully.") {
                              // Print data to console
                              print(decrementStatus);

                              // try {
                              //   final refreshedData =
                              //       await cartOperationProvider.getCartList();
                              //
                              //   if (refreshedData.cartItems != null &&
                              //       refreshedData.cartItems!.isNotEmpty) {
                              //     setState(() {
                              //       cartItemsData = refreshedData.cartItems!;
                              //     });
                              //   }
                              // } catch (error) {
                              //   print('Error refreshing data: $error');
                              // }

                              _loadData();
                            } else {
                              // API call failed
                              print(
                                  "Something went wrong: ${decrementStatus.message}");

                              final snackBar = SnackBar(
                                content: Text('${decrementStatus.message}'),
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
                          } catch (e) {
                            // Display error message
                            print("Error: $e");
                          }
                        },
                        child: Image.asset(
                          delete_icon,
                          height: 9,
                          width: 9,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      CustomText(
                        text: itemData.quantity.toString() ?? '',
                        sizeOfFont: 12,
                        color: hintColor,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: () async {
                          var cartId = itemData.cartId ?? '';

                          print('cartId:$cartId');

                          try {
                            AddToCartResponse incrementStatus =
                                await Provider.of<CartOperationProvider>(
                                        context,
                                        listen: false)
                                    .increaseItemQuantity(cartId);

                            if (incrementStatus.status == true &&
                                incrementStatus.message ==
                                    "Quantity incremented successfully.") {
                              // Print data to console
                              print(incrementStatus);

                              try {
                                final refreshedData =
                                    await cartOperationProvider.getCartList();

                                if (refreshedData.cartItems != null &&
                                    refreshedData.cartItems!.isNotEmpty) {
                                  setState(() {
                                    cartItemsData = refreshedData.cartItems!;
                                  });
                                }
                              } catch (error) {
                                print('Error refreshing data: $error');
                              }

                              _loadData();
                            } else {
                              // API call failed
                              print(
                                  "Something went wrong: ${incrementStatus.message}");

                              final snackBar = SnackBar(
                                content: Text('${incrementStatus.message}'),
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
                          } catch (e) {
                            // Display error message
                            print("Error: $e");
                          }
                        },
                        child: Icon(
                          Icons.add,
                          color: hintColor,
                          size: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CustomText(
                // Calculate the total price based on the count and item price
                text: "\$${itemData.subtotal.toString() ?? 0}",
                sizeOfFont: 15,
                color: offerColor,
                fontfamilly: montHeavy,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            color: grayColor,
            thickness: 0,
          )
        ],
      ),
    );
  }

  Future<void> addCardDialoge(BuildContext context) async {
    showDialog(
      context: context,
      useSafeArea: false,
      useRootNavigator: false,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog.fullscreen(
            backgroundColor: Colors.transparent,
            child: Stack(
              children: [
                Container(
                  color: dailogColor.withOpacity(0.75),
                  height: double.infinity,
                  width: double.infinity,
                ),
                paymentDetails(context)
              ],
            ));
      },
    );
  }

  Widget paymentDetails(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    String validateCardType(String testCard) {
      RegExp regVisa = RegExp(r"^4[0-9]{12}(?:[0-9]{3})?$");
      RegExp regMaster = RegExp(r"^5[1-5][0-9]{14}$");
      RegExp regExpress = RegExp(r"^3[47][0-9]{13}$");
      RegExp regDiners = RegExp(r"^3(?:0[0-5]|[68][0-9])[0-9]{11}$");
      RegExp regDiscover = RegExp(r"^6(?:011|5[0-9]{2})[0-9]{12}$");
      RegExp regJCB = RegExp(r"^(?:2131|1800|35\d{3})\d{11}$");

      if (regVisa.hasMatch(testCard)) {
        return "Visa";
      } else if (regMaster.hasMatch(testCard)) {
        return "MasterCard";
      } else if (regExpress.hasMatch(testCard)) {
        return "American Express";
      } else if (regDiners.hasMatch(testCard)) {
        return "Diners Club";
      } else if (regDiscover.hasMatch(testCard)) {
        return "Discover";
      } else if (regJCB.hasMatch(testCard)) {
        return "JCB";
      }

      return "";
    }

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: screenHeight * 0.16,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 0.0, right: 0.0, top: 30.0, bottom: 10),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                  color: onboardingbgColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(width: 1, color: hintColor)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    const CustomText(
                      text: "ADD NEW CARD",
                      color: btnbgColor,
                      fontfamilly: montBold,
                      sizeOfFont: 20,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: nameController,
                      style: const TextStyle(
                        decoration: TextDecoration.none,
                        decorationThickness: 0,
                        fontSize: 16,
                        fontFamily: montBook,
                        color:
                            onboardingBtn, // Make sure to define your colors properly
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: newcardbgColor,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: editbgColor, style: BorderStyle.solid)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: editbgColor, style: BorderStyle.solid)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        hintStyle: TextStyle(
                          fontFamily: montBook,
                          fontSize: 16,
                          color:
                              onboardingBtn, // Define your hint color properly
                        ),
                        hintText: cardName,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: cardNumberController,
                      style: const TextStyle(
                        decoration: TextDecoration.none,
                        decorationThickness: 0,
                        fontSize: 16,
                        fontFamily: montBook,
                        color:
                            onboardingBtn, // Make sure to define your colors properly
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(16),
                        // Limit to 19 characters
                        CreditCardFormatter(),
                      ],
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: newcardbgColor,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: editbgColor, style: BorderStyle.solid)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: editbgColor, style: BorderStyle.solid)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        hintStyle: TextStyle(
                          fontFamily: montBook,
                          fontSize: 16,
                          color:
                              onboardingBtn, // Define your hint color properly
                        ),
                        hintText: cardNum,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: expiryController,
                            style: const TextStyle(
                              decoration: TextDecoration.none,
                              decorationThickness: 0,
                              fontSize: 16,
                              fontFamily: montBook,
                              color:
                                  onboardingBtn, // Make sure to define your colors properly
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                              // Limit to 4 characters (MMYY)

                              // Limit to 19 characters
                              ExpiryDateFormatter(),
                            ],
                            decoration: InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: newcardbgColor,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: editbgColor,
                                      style: BorderStyle.solid)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: editbgColor,
                                      style: BorderStyle.solid)),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              hintStyle: TextStyle(
                                fontFamily: montBook,
                                fontSize: 16,
                                color:
                                    onboardingBtn, // Define your hint color properly
                              ),
                              hintText: expiry,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            controller: cvvController,
                            style: const TextStyle(
                              decoration: TextDecoration.none,
                              decorationThickness: 0,
                              fontSize: 16,
                              fontFamily: montBook,
                              color:
                                  onboardingBtn, // Make sure to define your colors properly
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(3),
                            ],
                            decoration: InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: newcardbgColor,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: editbgColor,
                                      style: BorderStyle.solid)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: editbgColor,
                                      style: BorderStyle.solid)),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              hintStyle: TextStyle(
                                fontFamily: montBook,
                                fontSize: 16,
                                color:
                                    onboardingBtn, // Define your hint color properly
                              ),
                              hintText: cvv,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 20),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          decoration: BoxDecoration(
                            color: btnbgColor,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(width: 1, color: btnbgColor),
                          ),
                          child: GestureDetector(
                              onTap: () async {
                                var cardNum = cardNumberController.text;
                                var validatedCard = cardNum.replaceAll(" ", "");
                                String cardType =
                                    validateCardType(validatedCard);
                                print("Card Type: ${cardType}");

                                if (nameController.text.isNotEmpty &&
                                    cardNumberController.text.isNotEmpty &&
                                    expiryController.text.isNotEmpty &&
                                    cvvController.text.isNotEmpty &&
                                    cardType.isNotEmpty) {
                                  try {
                                    var formData = {
                                      RequestString.NAME_ON_CARD:
                                          nameController.text,
                                      RequestString.CARD_NUMBER:
                                          cardNumberController.text
                                              .replaceAll(" ", ""),
                                      RequestString.EXPIRY_DATE:
                                          expiryController.text,
                                      RequestString.CVV: cvvController.text,
                                      RequestString.CARD_TYPE: cardType,
                                    };

                                    AddPaymentCardResponse data = await Provider
                                            .of<PaymentDetailsProvider>(context,
                                                listen: false)
                                        .addPaymentCard(formData);

                                    if (data.status == true &&
                                        data.message ==
                                            "Payment card saved successfully") {
                                      final paymentCardData =
                                          await carDOperationProvider
                                              .getCardList();

                                      if (paymentCardData.data != null &&
                                          paymentCardData.data!.isNotEmpty) {
                                        setState(() {
                                          if (mounted) {
                                            cardListData =
                                                paymentCardData.data!;

                                            // cartItemsData.addAll(nextPageData.cartItems!);
                                            // currentPage++;
                                          }
                                        });
                                      } else {
                                        setState(() {
                                          if (mounted) {
                                            hasMoreData = false;
                                            cardListData.clear();
                                          }
                                        });
                                      }

                                      final snackBar = SnackBar(
                                        content: Text('${data.message}'),
                                      );

                                      // Show the SnackBar
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);

                                      // Automatically hide the SnackBar after 1 second
                                      Future.delayed(
                                          Duration(milliseconds: 1000), () {
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentSnackBar();
                                      });

                                      nameController.text = "";
                                      cardNumberController.text = "";
                                      expiryController.text = "";
                                      cvvController.text = "";

                                      // Navigate to the next screen or perform other actions after login
                                    } else {
                                      // Login failed
                                      print(
                                          "Something went wrong: ${data.message}");

                                      final snackBar = SnackBar(
                                        content: Text('${data.message}'),
                                      );

                                      // Show the SnackBar
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);

                                      // Automatically hide the SnackBar after 1 second
                                      Future.delayed(
                                          Duration(milliseconds: 1000), () {
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentSnackBar();
                                      });
                                    }
                                  } catch (e) {
                                    // Display error message
                                    print("Error: $e");
                                  }
                                } else {
                                  final snackBar = SnackBar(
                                    content: const Text(
                                        'Please enter valid Payment card details..'),
                                    action: SnackBarAction(
                                      label: 'Ok',
                                      onPressed: () {
                                        // Some code to undo the change.
                                      },
                                    ),
                                  );

                                  // Find the ScaffoldMessenger in the widget tree
                                  // and use it to show a SnackBar.
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }

                                Navigator.pop(navigatorKey.currentContext!);
                              },
                              child: const CustomText(
                                text: "SAVE",
                                color: btntxtColor,
                                fontfamilly: montHeavy,
                                sizeOfFont: 20,
                              ))),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}

class CreditCardFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text =
        newValue.text.replaceAll(RegExp(r'\s'), ''); // Remove existing spaces
    var formattedText = '';

    for (var i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) {
        formattedText += ' '; // Add space every 4 characters
      }
      formattedText += text[i];
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

class ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text =
        newValue.text.replaceAll(RegExp(r'\s'), ''); // Remove existing spaces
    var formattedText = '';

    for (var i = 0; i < text.length; i++) {
      if (i == 2 && text.length > 2) {
        formattedText += '/'; // Add a slash after the second character
      }
      formattedText += text[i];
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
