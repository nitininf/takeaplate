
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_button.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_edit_text.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/MULTI-PROVIDER/selectImageProvider.dart';
import 'package:takeaplate/Response_Model/RegisterResponse.dart';
import 'package:takeaplate/Response_Model/UploadImageResponse.dart';
import 'package:takeaplate/UTILS/app_color.dart';
import 'package:takeaplate/UTILS/app_images.dart';
import 'package:takeaplate/UTILS/app_strings.dart';
import 'package:takeaplate/UTILS/fontfaimlly_string.dart';

import '../../MULTI-PROVIDER/AuthenticationProvider.dart';
import '../../MULTI-PROVIDER/SignUp_StepOne.dart';
import '../../MULTI-PROVIDER/SignUp_StepTwo.dart';
import '../../UTILS/request_string.dart';

class UploadPhoto extends StatelessWidget {

  TextEditingController selectedImagePathController = TextEditingController();



  @override
  Widget build(BuildContext context) {

    var getUserBasicDetails = Provider.of<SignUp_StepOne>(context);

    // // Access the user's information
    // var userInformation = SignUp_StepOne();




    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(

      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            appBackground,
            fit: BoxFit.cover,
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40.0,right: 40),
                child: Column(
                  children: [
                    SizedBox(height: screenHeight*0.04,),
                    Image.asset(
                      appLogo, // Replace with your first small image path
                      height: 80,
                      width: 80,
                    ),
                    SizedBox(height: screenHeight*0.03,),
                    const Padding(
                      padding: EdgeInsets.only(left: 18,top: 25),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: CustomText(text: profilePicture,color: Colors.white,fontfamilly: montHeavy,sizeOfFont: 20,)),
                    ),
                    SizedBox(height: screenHeight*0.04,),

                    Container(
                      height: screenHeight*0.350,
                      width: screenWidth*0.760,
                      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        image: selectedImagePathController.text.isNotEmpty
                            ? DecorationImage(
                          image: FileImage(File(selectedImagePathController.text)),
                          fit: BoxFit.cover,
                        )
                            : const DecorationImage(
                          image: AssetImage(edit_photo),
                          fit: BoxFit.contain,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {

                              final image = await _getImage(context);
                              if (image != null) {
                                // Update the selected image in the provider or state
                                Provider.of<SelectImageProvider>(context, listen: false).setSelectedImage(image);
                              }

                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Display the selected image or a default one
                                // You can use a provider to manage the selected image state
                                Consumer<SelectImageProvider>(
                                  builder: (context, provider, child) {
                                    return Image.asset(
                                      appLogo,
                                      height: 42,
                                      width: 40,
                                      fit: BoxFit.contain,
                                    );
                                  },
                                ),
                                SizedBox(height: 16,),
                                const CustomText(
                                  text: uploadphoto,
                                  color: Colors.white,
                                  fontfamilly: montBook,
                                  sizeOfFont: 20,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),


              Padding(
                padding: const EdgeInsets.all(59.0),
                child: CommonButton(btnBgColor: btnbgColor, btnText: next, onClick: () async {
                  String selectedImagePath = selectedImagePathController.text;

                  if (selectedImagePath.isNotEmpty) {
                    try {


                      UploadImageResponse data = await Provider.of<AuthenticationProvider>(context, listen: false)
                          .uploadMultipartImage(File(selectedImagePath),"registration");

                      if (data.status == true && data.message == "Image uploaded successfully") {



                        // Perform the navigation here

                        var saveUserImage = Provider.of<SignUp_StepTwo>(context, listen: false);

                        // Set user information in the provider
                        saveUserImage.saveSignUpStepTwoData(
                          fullName: getUserBasicDetails.fullName,
                          email: getUserBasicDetails.email,
                          phoneNumber: getUserBasicDetails.phoneNumber,
                          dob: getUserBasicDetails.dob,
                          gender: getUserBasicDetails.gender,
                          user_image: data.url ?? '',

                        );


                        Navigator.pushNamed(context, '/SetYourPasswordScreen');
                        // Print data to console
                        print(data);

                        // Navigate to the next screen or perform other actions after login
                      } else {
                        // Login failed
                        print("Something went wrong: ${data.message}");

                        final snackBar = SnackBar(
                          content:  Text('${data.message}'),

                        );

// Show the SnackBar
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

// Automatically hide the SnackBar after 1 second
                        Future.delayed(Duration(milliseconds: 1000), () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        });

                      }
                    } catch (e) {
                      // Display error message
                      print("Error: $e");
                    }
                  }

                  else {
                    // Show an error message or handle empty fields
                    final snackBar = SnackBar(
                      content: const Text('Please select or capture different image..'),
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




                                },),
              )

            ],
          ),
        ],
      ),

    );
  }

  Future<String?> _getImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await showDialog<PickedFile?>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Select Image Source"),
        actions: [
          TextButton(
            onPressed: () async {
              final image = await picker.getImage(source: ImageSource.camera);
              Navigator.pop(context, image != null ? image : null);
            },
            child: Text("Camera"),
          ),
          TextButton(
            onPressed: () async {
              final image = await picker.getImage(source: ImageSource.gallery);
              Navigator.pop(context, image != null ? image : null);
            },
            child: Text("Gallery"),
          ),
        ],
      ),
    );


    selectedImagePathController.text = pickedFile!.path;


    return pickedFile != null ? pickedFile.path : null;
  }

}
