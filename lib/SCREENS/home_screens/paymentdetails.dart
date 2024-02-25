import 'dart:convert';

import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:take_a_plate/CUSTOM_WIDGETS/common_button.dart';
import 'package:take_a_plate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:http/http.dart' as http;

import 'package:take_a_plate/SCREENS/notification/NotifcattionTurnOnScreen.dart';
import 'package:take_a_plate/UTILS/app_color.dart';
import 'package:take_a_plate/UTILS/app_images.dart';
import 'package:take_a_plate/UTILS/app_strings.dart';
import 'package:take_a_plate/UTILS/fontfamily_string.dart';
import '../../CUSTOM_WIDGETS/custom_app_bar.dart';
import '../../CUSTOM_WIDGETS/custom_search_field.dart';
import '../../MULTI-PROVIDER/CartOperationProvider.dart';
import '../../MULTI-PROVIDER/FavoriteOperationProvider.dart';
import '../../MULTI-PROVIDER/PaymentDetailsProvider.dart';
import '../../Response_Model/AddPaymentCardResponse.dart';
import '../../Response_Model/AddToCartResponse.dart';
import '../../Response_Model/FavAddedResponse.dart';
import '../../Response_Model/FavDeleteResponse.dart';
import '../../Response_Model/RestaurantDealResponse.dart';
import '../../UTILS/request_string.dart';
import '../../UTILS/utils.dart';

class PaymentDetailsScreen extends StatefulWidget {
  const PaymentDetailsScreen({super.key});

  @override
  _PaymentDetailsScreenState createState() => _PaymentDetailsScreenState();
}

TextEditingController nameController = TextEditingController();
TextEditingController cardNumberController = TextEditingController();
TextEditingController expiryController = TextEditingController();
TextEditingController cvvController = TextEditingController();

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
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
  Map<String, dynamic>? paymentIntent;
  String dealIds = "";

  StringBuffer dealIdsBuffer = StringBuffer();
  StringBuffer storeIdsBuffer = StringBuffer();
  var totalPrice = "";
  final CartOperationProvider cartOperationProvider = CartOperationProvider();

  Future<bool> _stripePayment(orderId, StringBuffer dealIdsBuffer, StringBuffer storeIdsBuffer) async {
    Map<String, dynamic> formData = {
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
    final DealData data =
        ModalRoute.of(context)!.settings.arguments as DealData;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(bottom: 25.0, left: 25, right: 25, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 4.0, right: 8),
                child: CustomAppBar(),
              ),
              const SizedBox(height: 23),
              const CustomSearchField(hintText: "Search"),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      getLastMinuteDealsData(data, context),
                      buildSection(total, "\$ ${data.price ?? "NA"}"),
                    //  paymentDetails(),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 30.0, right: 30, bottom: 20),
                        child: CommonButton(
                            btnBgColor: btnbgColor,
                            btnText: orderAndPay,
                            onClick: () async {
                              dealIdsBuffer.write(data.id);
                              storeIdsBuffer.write(data.storeId);
                              totalPrice = data.price!;
                              await makePayment(totalPrice , dealIdsBuffer,storeIdsBuffer);
                              

                              //Navigator.pushNamed(context, '/BaseHome');
                            }),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> makePayment(String amount, StringBuffer dealIdsBuffer, StringBuffer storeIdsBuffer) async {
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
      displayPaymentSheet(dealIdsBuffer,storeIdsBuffer);
    } catch (err) {
      throw Exception(err);
    }
  }

  displayPaymentSheet(StringBuffer dealIdsBuffer, StringBuffer storeIdsBuffer) async {
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
          var status = await _stripePayment(orderId,dealIdsBuffer,storeIdsBuffer);
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

  Widget buildSection(String title, String viewAllText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 0,
            color: editbgColor.withOpacity(0.25),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
                text: title,
                color: viewallColor,
                fontfamilly: montBold,
                sizeOfFont: 21),
            CustomText(
              text: viewAllText,
              color: dolorColor,
              sizeOfFont: 26,
              fontfamilly: montHeavy,
            ),
          ],
        ),
      ),
    );
  }

  Widget paymentDetails() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              width: 0,
              color: editbgColor.withOpacity(0.25),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: paymentDetail,
                color: viewallColor,
                fontfamilly: montBold,
                sizeOfFont: 19,
              ),
              const SizedBox(
                height: 25,
              ),
              // CommonEditText(hintText: cardName,isbgColor: true,),
              Container(
                  height: 49,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: editbgColor.withOpacity(0.25),
                      width: 1.0, // Adjust the width as needed
                    ),
                  ),
                  child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: nameController,
                      style: const TextStyle(
                          fontSize: 16,
                          fontFamily: montBook,
                          color: cardTextColor),
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          // Hide the border by default
                          hintStyle: TextStyle(
                              fontSize: 16,
                              fontFamily: montBook,
                              color: cardTextColor),
                          hintText: cardName))),
              const SizedBox(
                height: 10,
              ),
              // CommonEditText(hintText: cardNum,isbgColor: true,),
              Container(
                  height: 49,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: editbgColor.withOpacity(0.25),
                      width: 1.0, // Adjust the width as needed
                    ),
                  ),
                  child: TextFormField(
                      controller: cardNumberController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(16),
                        // Limit to 19 characters
                        CreditCardFormatter(),
                      ],
                      style: const TextStyle(
                          fontSize: 16,
                          fontFamily: montBook,
                          color: cardTextColor),
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              fontSize: 16,
                              fontFamily: montBook,
                              color: cardTextColor),
                          hintText: cardNum))),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                        height: 49,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: editbgColor.withOpacity(0.25),
                            width: 1.0, // Adjust the width as needed
                          ),
                        ),
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                              // Limit to 4 characters (MMYY)
                              ExpiryDateFormatter(context:context),
                            ],
                            controller: expiryController,
                            style: const TextStyle(
                                fontSize: 16,
                                fontFamily: montBook,
                                color: cardTextColor),
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontFamily: montBook,
                                    color: cardTextColor),
                                hintText: expiry))),
                  ), // CommonEditText(hintText: expiry,isbgColor: true,)),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                        height: 49,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: editbgColor.withOpacity(0.25),
                            width: 1.0, // Adjust the width as needed
                          ),
                        ),
                        child: TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(3),
                              // Limit to 4 characters (MMYY)
                            ],
                            controller: cvvController,
                            style: const TextStyle(
                                fontSize: 16,
                                fontFamily: montBook,
                                color: cardTextColor),
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontFamily: montBook,
                                    color: cardTextColor),
                                hintText: cvv))),
                  ), // CommonEditText(hintText: cvv,isbgColor: true,)),
                ],
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () async {
                    var cardNum = cardNumberController.text;
                    var validatedCard = cardNum.replaceAll(" ", "");
                    String cardType = validateCardType(validatedCard);


if(nameController.text.isNotEmpty && cardNumberController.text.isNotEmpty && expiryController.text.isNotEmpty && cvvController.text.isNotEmpty && cardType.isNotEmpty){

  try {
    var formData = {
      RequestString.NAME_ON_CARD: nameController.text,
      RequestString.CARD_NUMBER: cardNumberController.text.replaceAll(" ", ""),
      RequestString.EXPIRY_DATE: expiryController.text,
      RequestString.CVV: cvvController.text,
      RequestString.CARD_TYPE: cardType,

    };

    AddPaymentCardResponse data = await Provider.of<PaymentDetailsProvider>(context, listen: false)
        .addPaymentCard(formData);

    if (data.status == true && data.message == "Payment card saved successfully") {

      final snackBar = SnackBar(
        content:  Text('${data.message}'),

      );

      // Show the SnackBar
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      // Automatically hide the SnackBar after 1 second
      Future.delayed(const Duration(milliseconds: 1000), () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      });

      nameController.text = "";
      cardNumberController.text = "";
      expiryController.text = "";
      cvvController.text = "";

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


}else{

  final snackBar = SnackBar(
    content: const Text('Please enter valid Payment card details..'),
    action: SnackBarAction(
      label: 'Ok',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  // Find the ScaffoldMessenger in the widget tree
  // and use it to show a SnackBar.
  ScaffoldMessenger.of(context).showSnackBar(snackBar);

}








                  },
                  child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 20),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      decoration: BoxDecoration(
                        color: onboardingBtn,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(width: 1, color: Colors.white),
                      ),
                      child: const CustomText(
                        text: "SAVE",
                        color: btntxtColor,
                        fontfamilly: montHeavy,
                        sizeOfFont: 18,
                      )),
                ),
              ),
            ],
          )),
    );
  }

  Widget getLastMinuteDealsData(DealData lastMinuteDeal, BuildContext context) {
    var currentDay = DateTime.now().weekday;
    var startTiming = '';
    var endTiming = '';

    if (currentDay == 1) {
      startTiming = lastMinuteDeal.store?.openingHour?.monday?.start ?? '';
      endTiming = lastMinuteDeal.store?.openingHour?.monday?.end ?? '';
    } else if (currentDay == 2) {
      startTiming = lastMinuteDeal.store?.openingHour?.tuesday?.start ?? '';
      endTiming = lastMinuteDeal.store?.openingHour?.tuesday?.end ?? '';
    } else if (currentDay == 3) {
      startTiming = lastMinuteDeal.store?.openingHour?.wednesday?.start ?? '';
      endTiming = lastMinuteDeal.store?.openingHour?.wednesday?.end ?? '';
    } else if (currentDay == 4) {
      startTiming = lastMinuteDeal.store?.openingHour?.thursday?.start ?? '';
      endTiming = lastMinuteDeal.store?.openingHour?.thursday?.end ?? '';
    } else if (currentDay == 5) {
      startTiming = lastMinuteDeal.store?.openingHour?.friday?.start ?? '';
      endTiming = lastMinuteDeal.store?.openingHour?.friday?.end ?? '';
    } else if (currentDay == 6) {
      startTiming = lastMinuteDeal.store?.openingHour?.saturday?.start ?? '';
      endTiming = lastMinuteDeal.store?.openingHour?.saturday?.end ?? '';
    } else if (currentDay == 7) {
      startTiming = lastMinuteDeal.store?.openingHour?.sunday?.start ?? '';
      endTiming = lastMinuteDeal.store?.openingHour?.sunday?.end ?? '';
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 0,
          color: editbgColor.withOpacity(0.25),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: lastMinuteDeal.name ?? '',
                color: btntxtColor,
                fontfamilly: montBold,
                sizeOfFont: 18,
              ),
              CustomText(
                text: lastMinuteDeal.store?.name ?? '',
                color: btntxtColor,
                fontfamilly: montRegular,
                sizeOfFont: 13,
              ),
              CustomText(
                  text: '$startTiming - $endTiming',
                  color: graysColor,
                  sizeOfFont: 12,
                  fontfamilly: montRegular),
              const SizedBox(
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
                    size: 20,
                    initialRating:
                        double.parse(lastMinuteDeal.averageRating ?? '0'),
                    maxRating: 5,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                   CustomText(
                      text: '${lastMinuteDeal.store?.distanceKm} Km',
                      color: graysColor,
                      sizeOfFont: 12,
                      fontfamilly: montSemiBold),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              CustomText(
                text: '\$ ${lastMinuteDeal.price ?? "NA"}',
                color: dolorColor,
                sizeOfFont: 24,
                fontfamilly: montHeavy,
              ),
            ],
          ),
          const SizedBox(
            width: 18,
          ),
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
                    child: lastMinuteDeal.profileImage != null &&
                            !(lastMinuteDeal.profileImage)!
                                .contains("SocketException")
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.network(
                              lastMinuteDeal.profileImage!,
                              fit: BoxFit.cover,
                              height: 100,
                              width: 100,
                            ))
                        : Image.asset(
                            food_image,
                            height: 100,
                            width: 100,
                          ),
                  ),
                ),
                Positioned(
                  right: -4,
                  child: GestureDetector(
                    onTap: () async {
                      int? dealId = lastMinuteDeal.id;


                      try {
                        if (lastMinuteDeal.favourite == false) {
                          // Only hit the API if data.favourite is true
                          var formData = {
                            'favourite': 1,
                          };

                          FavAddedResponse favData =
                              await Provider.of<FavoriteOperationProvider>(
                                      context,
                                      listen: false)
                                  .AddToFavoriteDeal(dealId ?? 0, formData);

                          if (favData.status == true &&
                              favData.message ==
                                  "Deal Added in favourite successfully.") {
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

                            setState(() {
                              lastMinuteDeal.favourite = true;
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
                        } else if (lastMinuteDeal.favourite == true) {
                          // If data.favourite is false, print its value
                          FavDeleteResponse delData = await Provider.of<
                                      FavoriteOperationProvider>(context,
                                  listen: false)
                              .RemoveFromFavoriteDeal(lastMinuteDeal.id ?? 0);

                          if (delData.status == true &&
                              delData.message ==
                                  "Favourite Deal deleted successfully.") {
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

                            setState(() {
                              lastMinuteDeal.favourite = false;
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
                      lastMinuteDeal.favourite == true
                          ? save_icon_red
                          : save_icon,
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

  final BuildContext context;

  ExpiryDateFormatter({required this.context});

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


    // Validate month here
    if (formattedText.length > 2) {
      final monthString = formattedText.substring(0, 2);
      final month = int.tryParse(monthString);
      if (month == null || month > 12) {
        // Show alert dialog for invalid month
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Invalid Month'),
              content: const Text('Please enter a valid month (01-12)'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return oldValue; // Revert to old value
      }
    }

    if (formattedText.length > 2) {
      final yearString = formattedText.substring(3, 5);
      final month = int.tryParse(yearString);
      if (month == null || month <= 23) {
        // Show alert dialog for invalid month
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Invalid Year'),
              content: const Text('Please enter a Valid Year'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return oldValue; // Revert to old value
      }
    }


    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
