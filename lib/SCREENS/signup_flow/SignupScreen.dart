import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_button.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_edit_text.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_email_field.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/app_images.dart';
import 'package:takeaplate/UTILS/app_strings.dart';
import 'package:takeaplate/UTILS/fontfaimlly_string.dart';

import '../../MULTI-PROVIDER/DateProvider.dart';
import '../../MULTI-PROVIDER/SignUp_StepOne.dart';

List<String> genders = ['Male', 'Female', 'Other'];

class SignUpScreen extends StatelessWidget {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController genderController =
      TextEditingController(text: genders[0]);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: true, // Set this to true
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
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: CommonEditText(
                                hintText: dob,
                                controller: dobController,
                                onTap: () => _selectDate(context),
                                isSelection: true),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CommonEditText(
                              hintText: gender,
                              isPassword: true,
                              isSelection: true,
                              controller: genderController,
                              onTap: () {
                                _showGenderDropdown(context);
                              },
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
                  padding: EdgeInsets.only(left: 40, right: 40, bottom: 20),
                  child: CommonButton(
                    btnBgColor: btnbgColor,
                    btnText: next,
                    onClick: () {
                      // Check if any field is null or empty
                      if (fullNameController.text.isEmpty ||
                          emailController.text.isEmpty ||
                          phoneNumberController.text.isEmpty ||
                          dobController.text.isEmpty ||
                          genderController.text.isEmpty) {
                        // Show an error message or perform any action for invalid input
                        print("Please fill in all fields");

                        final snackBar = SnackBar(
                          content: Text('Please fill in all fields'),
                        );

// Show the SnackBar
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

// Automatically hide the SnackBar after 1 second
                        Future.delayed(Duration(milliseconds: 1000), () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        });
                      } else {
                        // If all fields are filled, proceed to the next screen
                        print(
                            "Full Name: ${fullNameController.text} ,\n Email: ${emailController.text},\n Phone Number: ${phoneNumberController.text},\n Date Of Birth: ${dobController.text},\n Gender: ${genderController.text}");

                        var saveUserBasicDetail =
                            Provider.of<SignUp_StepOne>(context, listen: false);

                        // Set user information in the provider
                        saveUserBasicDetail.saveSignUpStepOneData(
                          fullName: fullNameController.text,
                          email: emailController.text,
                          phoneNumber: phoneNumberController.text,
                          dob: dobController.text,
                          gender: genderController.text,
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
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    print("Selecting date...");
    final DateProvider dateProvider =
        Provider.of<DateProvider>(context, listen: false);
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
              ListTile(
                title: Text('Select Gender',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: genders.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(genders[index]),
                      onTap: () {
                        Navigator.of(context).pop();
                        genderController.text = genders[index];
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
