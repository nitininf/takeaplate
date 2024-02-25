import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:take_a_plate/CUSTOM_WIDGETS/common_button.dart';
import 'package:take_a_plate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:take_a_plate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:take_a_plate/SCREENS/notification/NotifcattionTurnOnScreen.dart';
import 'package:take_a_plate/UTILS/app_color.dart';
import 'package:take_a_plate/main.dart';

import '../../../MULTI-PROVIDER/CartOperationProvider.dart';
import '../../../Response_Model/AddToCartResponse.dart';
import '../../../Response_Model/CartListingResponse.dart';
import '../../../UTILS/app_images.dart';
import '../../../UTILS/fontfamily_string.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../../UTILS/request_string.dart';
import '../../../UTILS/utils.dart';

class YourCardScreen extends StatefulWidget {
  const YourCardScreen({super.key});

  @override
  _YourCardScreenState createState() => _YourCardScreenState();
}

class _YourCardScreenState extends State<YourCardScreen> {
  final CartOperationProvider cartOperationProvider = CartOperationProvider();
  int currentPage = 1;
  bool isLoading = false;
  bool hasMoreData = true;
  List<CartItems> cartItemsData = [];
  var totalPrice = 0;
  Map<String, dynamic>? paymentIntent;
  String dealIds = "";

  StringBuffer dealIdsBuffer = StringBuffer();
  StringBuffer storeIdsBuffer = StringBuffer();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  void _loadData() async {
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


              var dealIds = nextPageData.getAllDealIds();

              for (int i = 0; i < dealIds.length; i++) {

                dealIdsBuffer.write(dealIds[i]);
                if (i < dealIds.length - 1) {
                  dealIdsBuffer.write(', ');
                }

              }
              var storeIds = nextPageData.getAllStoreIds();

              for (int i = 0; i < storeIds.length; i++) {
                storeIdsBuffer.write(dealIds[i]);
                if (i < dealIds.length - 1) {
                  storeIdsBuffer.write(', ');
                }
              }



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
      } finally {
        setState(() {
          if (mounted) {
            isLoading = false;
          }
        });
      }
    }
  }

  Future<bool> _stripePayment(orderId) async {
    Map<String, dynamic> formData = {
      // "user_id": await Utility.getIntValue(RequestString.ID) ?? 0,
      "deal_id": dealIdsBuffer.toString(),
      "status": "Success",
      "total_amount": totalPrice.toString(),
      "payment_id": orderId,
      "store_id": storeIdsBuffer.toString(),
    };
    AddToCartResponse _stripePayment =
        await cartOperationProvider.stripePayment(formData);

    if (_stripePayment.status == true) {
      print("_myy stripe payment status ${_stripePayment.message}");
      return true;
    }
    return false;

  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    String dealIdResult = dealIdsBuffer.toString();
    String storeIdResult = storeIdsBuffer.toString();


    print("DealIds:  $dealIdResult \n StoreIds: $storeIdResult");
    return Stack(
      children: [
        Scaffold(
            backgroundColor: bgColor,
            body: Padding(
              padding: const EdgeInsets.only(
                  right: 35.0, left: 35, bottom: 0, top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [getView(screenHeight, context)],
              ),
            )),
        Visibility(
          visible: isLoading,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: Colors.black.withOpacity(0.1),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget getView(double screenHeight, BuildContext context) {
    CartOperationProvider cartProvider =
        Provider.of<CartOperationProvider>(context);

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 18,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: CustomText(
                text: "YOUR CART",
                color: editbgColor,
                sizeOfFont: 20,
                fontfamilly: montHeavy,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(width: 1, color: grayColor)),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  getVerticalItemList(),
                  SizedBox(height: screenHeight * 0.120),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                    decoration: BoxDecoration(
                      color: onboardingBtn.withOpacity(0.20),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(width: 0, color: grayColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(
                            text: "Total",
                            color: btntxtColor,
                            sizeOfFont: 21,
                            fontfamilly: montBold,
                          ),
                          CustomText(
                            text: "\$${totalPrice}",
                            color: offerColor,
                            sizeOfFont: 28,
                            fontfamilly: montHeavy,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Visibility(
                  visible: cartItemsData.isNotEmpty,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 30.0, right: 30, left: 30),
                    child: CommonButton(
                        btnBgColor: btnbgColor,
                        sizeOfFont: 18,
                        btnText: "GO TO CHECKOUT",
                        onClick: () async {
                          // print("Total Price: \$${totalPrice.toStringAsFixed(2)}");
                          await makePayment(totalPrice.toString());
                          //  Navigator.pushNamed(navigatorKey.currentContext!, '/OrderSummeryScreen');
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, left: 30, right: 30, bottom: 20),
                  child: CommonButton(
                      btnBgColor: onboardingBtn.withOpacity(1),
                      sizeOfFont: 18,
                      btnTextColor: offerColor.withOpacity(0.5),
                      btnText: "ADD MORE ITEMS",
                      onClick: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/BaseHome', (Route route) => false);
                      }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> makePayment(String amount) async {
    try {
      print("saddfd${amount}");
      paymentIntent = await createPaymentIntent(amount, 'USD');

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent![
                      'client_secret'], //Gotten from payment intent
                  style: ThemeMode.light,
                  merchantDisplayName: 'Ikay'))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (err) {
      throw Exception(err);
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {

        var orderId = paymentIntent?['id'];


        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 100.0,
                      ),
                      SizedBox(height: 10.0),
                      Text("Payment Successful!"),

                    ],
                  ),
                ));

        Future.delayed(const Duration(seconds: 1), () async {
          var status = await _stripePayment(orderId);
          if(status == true) {
            paymentIntent = null;
            Navigator.of(context).pushNamedAndRemoveUntil('/BaseHome', (Route route) => false);
          }
        });


      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      if (response.body.isNotEmpty) {
        print("nbgff ${response.statusCode}");
        var jsonCode = jsonDecode(response.body);

        print("Status : ${jsonCode["status"]}");

      }

      else
        print("body not gert");

      print("dfv${response.body}");
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }

  Widget getVerticalItemList() {
    if (cartItemsData.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(20.0),
        child: CustomText(
          text: 'No Item Found',
          maxLin: 1,
          color: btntxtColor,
          fontfamilly: montBold,
          sizeOfFont: 15,
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cartItemsData.length,
      itemBuilder: (context, index) {
        if (index < cartItemsData.length) {
          return getCardViews(index, cartItemsData[index]);
        } else {
          return FutureBuilder(
            future: Future.delayed(const Duration(milliseconds: 500)),
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.done
                    ? const SizedBox()
                    : const Center(child: CircularProgressIndicator()),
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
              const SizedBox(
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

                          try {
                            AddToCartResponse decrementStatus =
                                await Provider.of<CartOperationProvider>(
                                        context,
                                        listen: false)
                                    .decreaseItemQuantity(cartId);

                            if (decrementStatus.status == true &&
                                decrementStatus.message ==
                                    "Quantity decremented successfully.") {
                              _loadData();
                            } else {
                              // API call failed

                              final snackBar = SnackBar(
                                content: Text('${decrementStatus.message}'),
                              );

                              // Show the SnackBar
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);

                              // Automatically hide the SnackBar after 1 second
                              Future.delayed(const Duration(milliseconds: 1000),
                                  () {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                              });
                            }
                          } catch (e) {
                            // Display error message
                          }
                        },
                        child: Image.asset(
                          delete_icon,
                          height: 9,
                          width: 9,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      CustomText(
                        text: itemData.quantity.toString(),
                        sizeOfFont: 12,
                        color: hintColor,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: () async {
                          var cartId = itemData.cartId ?? '';

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

                              try {
                                final refreshedData =
                                    await cartOperationProvider.getCartList();

                                if (refreshedData.cartItems != null &&
                                    refreshedData.cartItems!.isNotEmpty) {
                                  setState(() {
                                    cartItemsData = refreshedData.cartItems!;
                                  });
                                }
                              } catch (error) {}

                              _loadData();
                            } else {
                              // API call failed

                              final snackBar = SnackBar(
                                content: Text('${incrementStatus.message}'),
                              );

                              // Show the SnackBar
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);

                              // Automatically hide the SnackBar after 1 second
                              Future.delayed(const Duration(milliseconds: 1000),
                                  () {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                              });
                            }
                          } catch (e) {
                            // Display error message
                          }
                        },
                        child: const Icon(
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
                text: "\$${itemData.subtotal.toString()}",
                sizeOfFont: 15,
                color: offerColor,
                fontfamilly: montHeavy,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(
            color: grayColor,
            thickness: 0,
          )
        ],
      ),
    );
  }
}
