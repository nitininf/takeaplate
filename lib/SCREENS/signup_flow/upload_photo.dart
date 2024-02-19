import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:take_a_plate/CUSTOM_WIDGETS/common_button.dart';
import 'package:take_a_plate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:take_a_plate/MULTI-PROVIDER/selectImageProvider.dart';
import 'package:take_a_plate/Response_Model/UploadImageResponse.dart';
import 'package:take_a_plate/UTILS/app_color.dart';
import 'package:take_a_plate/UTILS/app_images.dart';
import 'package:take_a_plate/UTILS/app_strings.dart';
import 'package:take_a_plate/UTILS/fontfamily_string.dart';
import '../../MULTI-PROVIDER/AuthenticationProvider.dart';
import '../../MULTI-PROVIDER/SignUp_StepOne.dart';
import '../../MULTI-PROVIDER/SignUp_StepTwo.dart';
import '../../UTILS/request_string.dart';
import '../../UTILS/utils.dart';

class UploadPhoto extends StatefulWidget {
  const UploadPhoto({super.key});

  @override
  _UploadPhotoState createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhoto> {
  TextEditingController selectedImagePathController = TextEditingController();
  final SelectImageProvider selectImageProvider = SelectImageProvider();

  @override
  Widget build(BuildContext context) {
    var getUserBasicDetails = Provider.of<SignUp_StepOne>(context);

    // // Access the user's information
    // var userInformation = SignUp_StepOne();

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        // Clear the text fields when the user presses the back button
        selectedImagePathController.text = '';
        selectImageProvider.resetState();

        Navigator.of(context)
            .pushNamedAndRemoveUntil('/SignupScreen', (Route route) => false);

        // Allow the back button action
        return true;
      },
      child: Scaffold(
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
                  padding: const EdgeInsets.only(left: 40.0, right: 40),
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight * 0.04,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Center(
                              child: Image.asset(
                                appLogo,
                                // Replace with your first small image path
                                height: 80,
                                width: 80,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                var saveUserImage = Provider.of<SignUp_StepTwo>(
                                    context,
                                    listen: false);

                                // Set user information in the provider
                                saveUserImage.saveSignUpStepTwoData(
                                  fullName: getUserBasicDetails.fullName,
                                  email: getUserBasicDetails.email,
                                  phoneNumber: getUserBasicDetails.phoneNumber,
                                  dob: getUserBasicDetails.dob,
                                  gender: getUserBasicDetails.gender,
                                  user_image: '',
                                );

                                Navigator.pushNamed(
                                    context, '/SetYourPasswordScreen');
                              },
                              child: CustomText(
                                text: skip,
                                sizeOfFont: 13,
                                color: Colors.white,
                                fontfamilly: montBold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 18, top: 25),
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: CustomText(
                                  text: profilePicture,
                                  color: Color(0xffD0E2F6),
                                  fontfamilly: montHeavy,
                                  sizeOfFont: 20,
                                )),
                            Align(
                              alignment: Alignment.topLeft,
                              child: RichText(
                                text: TextSpan(
                                    text: '*',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: montLight,
                                        fontSize: 18),
                                    children: [
                                      TextSpan(
                                          text: 'Optional',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: montMedium
                                          ))
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40.0),
                        child: Container(
                          height: screenHeight * 0.350,
                          width: screenWidth * 0.760,
                          // margin: const EdgeInsets.symmetric(
                          //     horizontal: 18, vertical: 10),
                          // padding: const EdgeInsets.symmetric(
                          //     horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(

                            image: selectedImagePathController.text.isNotEmpty
                                ? DecorationImage(
                              fit: BoxFit.fill ,
                                    image: FileImage(
                                    File(selectedImagePathController.text),
                                  ))
                                : const DecorationImage(
                                    image: AssetImage(upload_photo),
                                    fit: BoxFit.fill,
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
                                    Provider.of<SelectImageProvider>(context,
                                            listen: false)
                                        .setSelectedImage(image);
                                  }
                                },
                                child: Visibility(
                                  visible:
                                      selectedImagePathController.text.isEmpty,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
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
                                      SizedBox(
                                        height: 16,
                                      ),
                                      const CustomText(
                                        text: uploadphoto,
                                        color: Colors.white,
                                        fontfamilly: montBook,
                                        sizeOfFont: 20,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(59.0),
                  child: CommonButton(
                    btnBgColor: btnbgColor,
                    btnText: next,
                    onClick: () async {
                      String selectedImagePath =
                          selectedImagePathController.text;

                      if (selectedImagePath.isNotEmpty) {
                        try {
                          var data = await Provider.of<AuthenticationProvider>(
                                  context,
                                  listen: false)
                              .uploadMultipartImage(
                                  File(selectedImagePath), "registration");

                          print(data);

                          if (data.message == "Image uploaded successfully") {
                            await Utility.getSharedPreferences();
                            await Utility.setStringValue(
                                RequestString.USER_IMAGE, data.url ?? '');

                            // Perform the navigation here

                            var saveUserImage = Provider.of<SignUp_StepTwo>(
                                context,
                                listen: false);

                            // Set user information in the provider
                            saveUserImage.saveSignUpStepTwoData(
                              fullName: getUserBasicDetails.fullName,
                              email: getUserBasicDetails.email,
                              phoneNumber: getUserBasicDetails.phoneNumber,
                              dob: getUserBasicDetails.dob,
                              gender: getUserBasicDetails.gender,
                              user_image: data.url ?? '',
                            );

                            final snackBar = SnackBar(
                              content: Text('${data.message}'),
                            );

                            // Show the SnackBar
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);

                            // Automatically hide the SnackBar after 1 second
                            Future.delayed(Duration(milliseconds: 1000), () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                            });

                            Navigator.pushNamed(
                                context, '/SetYourPasswordScreen');
                            // Print data to console
                            print(data);

                            // Navigate to the next screen or perform other actions after login
                          } else {
                            // Login failed
                            print("Something went wrong: ${data.message}");

                            final snackBar = SnackBar(
                              content: Text('${data.message}'),
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
                      } else {
                        var saveUserImage =
                            Provider.of<SignUp_StepTwo>(context, listen: false);

                        // Set user information in the provider
                        saveUserImage.saveSignUpStepTwoData(
                          fullName: getUserBasicDetails.fullName,
                          email: getUserBasicDetails.email,
                          phoneNumber: getUserBasicDetails.phoneNumber,
                          dob: getUserBasicDetails.dob,
                          gender: getUserBasicDetails.gender,
                          user_image: '',
                        );

                        Navigator.pushNamed(context, '/SetYourPasswordScreen');
                      }
                    },
                  ),
                )
              ],
            ),
          ],
        ),
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
              Navigator.pop(context, image);
            },
            child: Text("Camera"),
          ),
          TextButton(
            onPressed: () async {
              final image = await picker.getImage(source: ImageSource.gallery);
              Navigator.pop(context, image);
            },
            child: Text("Gallery"),
          ),
        ],
      ),
    );

    if (pickedFile != null) {
      // Call the crop function and return the cropped image path
      final imagePath = await _cropImage(pickedFile, context);
      if (imagePath != null) {
        // Update the selected image path
        selectedImagePathController.text = imagePath;
      }
      return imagePath;
    } else {
      // User canceled image selection
      return null;
    }
  }

  Future<String?> _cropImage(PickedFile image, BuildContext context) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );

    print("croppedFile: ${croppedFile?.path}");

    if (croppedFile != null) {
      setState(() {
        selectedImagePathController.text = croppedFile.path;
      });
      return croppedFile.path;
    } else {
      selectedImagePathController.text = "";
      return "";
    }
  }
}
