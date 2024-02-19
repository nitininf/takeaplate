import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:take_a_plate/CUSTOM_WIDGETS/common_button.dart';
import 'package:take_a_plate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:take_a_plate/MULTI-PROVIDER/common_counter.dart';
import 'package:take_a_plate/UTILS/dialog_helper.dart';
import 'package:take_a_plate/UTILS/fontfamily_string.dart';
import 'package:take_a_plate/main.dart';

import '../CUSTOM_WIDGETS/custom_text_style.dart';
import '../MULTI-PROVIDER/CartOperationProvider.dart';
import '../MULTI-PROVIDER/PaymentDetailsProvider.dart';
import '../Response_Model/AddPaymentCardResponse.dart';
import '../Response_Model/CardDeleteResponse.dart';
import '../Response_Model/CardListResponse.dart';
import '../Response_Model/CartListingResponse.dart';
import '../UTILS/app_color.dart';
import '../UTILS/app_images.dart';
import '../UTILS/app_strings.dart';
import '../UTILS/request_string.dart';

final PaymentDetailsProvider carDOperationProvider = PaymentDetailsProvider();
TextEditingController nameController = TextEditingController();
TextEditingController cardNumberController = TextEditingController();
TextEditingController expiryController = TextEditingController();
TextEditingController cvvController = TextEditingController();

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  int currentPage = 1;
  bool isLoading = false;
  bool hasMoreData = true;
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
    if (!isLoading && hasMoreData) {
      try {
        setState(() {
          isLoading = true;
        });

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 25.0, right: 25, top: 0, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getView(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CommonButton(
                  btnText: "ADD NEW",
                  btnBgColor: btnbgColor,
                  btnTextColor: btntxtColor,
                  onClick: () {
                    // Navigator.pushNamed(context, '/RestrorentProfileScreen');
                    addCardDialog(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getView() {
    return Consumer<CommonCounter>(builder: (context, commonProvider, child) {
      return Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const CustomAppBar(),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomText(
                text: "PAYMENT METHOD",
                color: editbgColor,
                sizeOfFont: 20,
                fontfamilly: montHeavy,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: editprofilbgColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1, color: Colors.white),
                ),
                child: GestureDetector(
                    onTap: () {
                      if (commonProvider.isSaved) {
                        commonProvider.updateView("SAVE");
                      } else {
                        commonProvider.updateView("EDIT");
                      }
                    },
                    child: CustomText(
                      text: commonProvider.btnName,
                      sizeOfFont: 10,
                      fontfamilly: montBold,
                      color: editprofileColor,
                    )),
              )
            ],
          ),
          const SizedBox(
            height: 17,
          ),
          Container(
            margin: EdgeInsets.all(10),
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

                      child: getMasterCard(hintColor, index,
                          cardListData[index], commonProvider),
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
          ),
        ],
      );
    });
  }

  Widget getMasterCard(Color colorbg, int index, CardData cardListData,
      CommonCounter commonProvider) {
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
          getUpdatedView(cardListData.id ?? 0, commonProvider)
        ],
      ),
    );
  }

  Widget getUpdatedView(int i, CommonCounter commonCounter) {
    return !commonCounter.isSaved
        ? GestureDetector(
            onTap: () {
              selectedCardIndex = i;
              showCommonPopup(navigatorKey.currentContext!,
                  title: "ARE YOU SURE YOU WANT TO DELETE THIS CARD?",
                  isDelete: true);
            },
            child: Padding(
              padding: EdgeInsets.all(7.0),
              child: Image.asset(
                cross,
                width: 12,
                height: 12,
              ),
            ),
          )
        : const Text("");
  }

  Future<void> showCommonPopup(BuildContext context,
      {String? title, bool? isDelete}) async {
    double screenHeight = MediaQuery.of(context).size.height;

    showDialog(
      context: context,
      useSafeArea: false,
      useRootNavigator: false,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog.fullscreen(
          /*  shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),*/
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Container(
                color: dailogColor.withOpacity(0.75),
                height: double.infinity,
                width: double.infinity,
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: screenHeight * 0.16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 0.0, right: 0.0, top: 30.0, bottom: 10),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 40),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                          color: onboardingbgColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(width: 1, color: hintColor)),
                      child: Column(children: [
                        SizedBox(
                          height: screenHeight * 0.03,
                        ),
                        Image.asset(
                          appLogo,
                          height: 100,
                          width: 100,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: CustomText(
                            text: title ?? "",
                            sizeOfFont: 17,
                            color: hintColor,
                            fontfamilly: montBold,
                            isAlign: true,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.05,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15, top: 6, bottom: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: CommonButton(
                                    btnBgColor: onboardingBtn,
                                    btnText: "YES",
                                    onClick: () async {
                                      print(selectedCardIndex);

                                      try {
                                        CardDeleteResponse data = await Provider
                                                .of<PaymentDetailsProvider>(
                                                    context,
                                                    listen: false)
                                            .deletePaymentCard(
                                                selectedCardIndex);

                                        if (data.status == true &&
                                            data.message ==
                                                "Card deleted successfully.") {
                                          final paymentCardData =
                                              await carDOperationProvider
                                                  .getCardList();

                                          if (paymentCardData.data != null &&
                                              paymentCardData
                                                  .data!.isNotEmpty) {
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
                                            content: const Text(
                                                'Card deleted successfully..'),
                                          );

// Show the SnackBar
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);

// Automatically hide the SnackBar after 1 second
                                          Future.delayed(
                                              Duration(milliseconds: 500), () {
                                            ScaffoldMessenger.of(context)
                                                .hideCurrentSnackBar();
                                          });

                                          Navigator.pop(context);

                                          // Navigate to the next screen or perform other actions after login
                                        } else {
                                          // Login failed
                                          print(
                                              "Something went wrong: ${data.message}");
                                        }
                                      } catch (e) {
                                        // Display error message
                                        print("Error: $e");
                                      }
                                    }),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: CommonButton(
                                    btnBgColor: onboardingBtn,
                                    btnText: "NO",
                                    onClick: () {
                                      Navigator.pop(context);
                                    }),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ]),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> addCardDialog(BuildContext context) async {
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
