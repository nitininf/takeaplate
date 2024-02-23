import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:take_a_plate/CUSTOM_WIDGETS/common_button.dart';
import 'package:take_a_plate/CUSTOM_WIDGETS/common_edit_text.dart';
import 'package:take_a_plate/CUSTOM_WIDGETS/common_email_field.dart';
import 'package:take_a_plate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:take_a_plate/UTILS/app_color.dart';
import 'package:take_a_plate/UTILS/app_images.dart';
import 'package:take_a_plate/UTILS/app_strings.dart';
import 'package:take_a_plate/UTILS/fontfamily_string.dart';

import '../../MULTI-PROVIDER/DateProvider.dart';
import '../../MULTI-PROVIDER/SignUp_StepOne.dart';
import '../../UTILS/validation.dart';

List<String> genders = ['Gender'];
List<String> genderList = ['Male', 'Female', 'Other'];
TextEditingController fullNameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController phoneNumberController = TextEditingController();
TextEditingController dobController = TextEditingController();
TextEditingController genderController =
    TextEditingController(text: genders[0]);

final DateProvider dateProvider = DateProvider();

 class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        fullNameController.clear();
        emailController.clear();
        phoneNumberController.clear();
        dobController.clear();
        dateProvider.resetState();
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/Create_Login', (Route route) => false);

        // Allow the back button action
        return true;
      },
      child: Scaffold(
        extendBody: true,

        resizeToAvoidBottomInset: false, // Set this to true
        body: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(appBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              // Wrap your Column with SingleChildScrollView
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 40),
                    child: Column(
                      children: [
                        SizedBox(height: screenHeight * 0.04),
                        Image.asset(
                          appLogo,
                          height: 80,
                          width: 80,
                        ),
                        SizedBox(height: screenHeight * 0.04),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: CustomText(
                            text: createyouraccount,
                            color: hintColor,
                            fontfamilly: montHeavy,
                            sizeOfFont: 20,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.04),
                        CommonEmailField(
                          hintText: fullName,
                          isUsername: true,
                          controller: fullNameController,
                        ),
                        const SizedBox(height: 20),
                        CommonEmailField(
                          hintText: email,
                          controller: emailController,
                        ),
                        const SizedBox(height: 20),
                        CommonEmailField(
                          hintText: phoneNumber,
                          controller: phoneNumberController,
                          isPhoneNumber: true,
                          isPassword: false,
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              child: CommonEditText(
                                  hintText: dob,
                                  controller: dobController,
                                  onTap: () => _selectDate(context),
                                  isIconShow: true,
                                  isSelection: true),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                maxLength: 15,
                                controller: genderController,
                                readOnly: true,
                                style: const TextStyle(
                                  decoration: TextDecoration.none,
                                  decorationThickness: 0,
                                  fontSize: 18,
                                  fontFamily: montBook,
                                  color: Colors
                                      .white, // Make sure to define your colors properly
                                ),
                                decoration: InputDecoration(
                                  counterText: '',
                                  filled: true,
                                  fillColor: editbgColor,
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          color: editbgColor,
                                          style: BorderStyle.solid)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: const BorderSide(
                                          color: editbgColor,
                                          style: BorderStyle.solid)),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      _showGenderDropdown(context);
                                    },
                                    icon: Image.asset(down_arrow,
                                        height: 16, width: 12),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                  hintStyle: const TextStyle(
                                    fontFamily: montBook,
                                    fontSize: 20,
                                    color:
                                        readybgColor, // Define your hint color properly
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.170,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40, bottom: 20),
                    child: CommonButton(
                      btnBgColor: btnbgColor,
                      btnText: next,
                      onClick: () async {
                        var validEmail =
                            FormValidator.validateEmail(emailController.text);
                        var validPhone = FormValidator.validatePhoneNumber(
                            phoneNumberController.text);

                        // Check if any field is null or empty
                        if (fullNameController.text.isEmpty ||
                            emailController.text.isEmpty ||
                            phoneNumberController.text.isEmpty ||
                            dobController.text.isEmpty ||
                            genderController.text == genders[0]) {
                          // Show an error message or perform any action for invalid input

                          const snackBar = SnackBar(
                            content: Text('Please fill in all fields'),
                          );

                          // Show the SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          // Automatically hide the SnackBar after 1 second
                          Future.delayed(const Duration(milliseconds: 1000),
                              () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          });
                        } else if (validEmail != null) {
                          const snackBar = SnackBar(
                            content: Text('Please enter valid Email Id'),
                          );

                          // Show the SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          // Automatically hide the SnackBar after 1 second
                          Future.delayed(const Duration(milliseconds: 1000),
                              () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          });
                        } else if (validPhone != null) {
                          const snackBar = SnackBar(
                            content: Text('Please enter valid Phone Number'),
                          );

                          // Show the SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          // Automatically hide the SnackBar after 1 second
                          Future.delayed(const Duration(milliseconds: 1000),
                              () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          });
                        } else {
                          // If all fields are filled, proceed to the next screen

                          var date = dateProvider.formattedDate(
                              DateTime.parse(dobController.text));

                          var saveUserBasicDetail = Provider.of<SignUp_StepOne>(
                              context,
                              listen: false);

                          // Set user information in the provider
                          saveUserBasicDetail.saveSignUpStepOneData(
                            fullName: fullNameController.text,
                            email: emailController.text,
                            phoneNumber: phoneNumberController.text,
                            dob: date,
                            gender: genderController.text.toLowerCase(),
                          );

                          Navigator.pushNamed(context, '/UploadPhoto');
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        /*   bottomNavigationBar:  Padding(
        padding:EdgeInsets.only(left: 40,right: 40,bottom: 20) ,
        child: CommonButton(
          btnBgColor: btnbgColor,
          btnText: next,
          onClick: () {
            Navigator.pushNamed(context, '/UploadPhoto');
          },
        ),
      ),*/
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != dateProvider.selectedDate) {
      dateProvider.setSelectedDate(picked);
      dobController.text = dateProvider.formattedSelectedDate;
    }
  }

  Future<void> _showGenderDropdown(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: Column(
            children: [
              const ListTile(
                title: Text('Select Gender',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: genderList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(genderList[index]),
                      onTap: () {
                        Navigator.of(context).pop();
                        genderController.text = genderList[index];
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
