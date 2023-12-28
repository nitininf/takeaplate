import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/Response_Model/EditProfileResponse.dart';
import 'package:takeaplate/UTILS/app_images.dart';
import 'package:takeaplate/UTILS/dialog_helper.dart';
import 'package:takeaplate/main.dart';

import '../../CUSTOM_WIDGETS/common_button.dart';
import '../../CUSTOM_WIDGETS/common_edit_text.dart';
import '../../CUSTOM_WIDGETS/common_email_field.dart';
import '../../MULTI-PROVIDER/AuthenticationProvider.dart';
import '../../MULTI-PROVIDER/DateProvider.dart';
import '../../MULTI-PROVIDER/SharedPrefsUtils.dart';
import '../../MULTI-PROVIDER/selectImageProvider.dart';
import '../../UTILS/app_color.dart';
import '../../UTILS/app_strings.dart';
import '../../UTILS/fontfaimlly_string.dart';
import '../../UTILS/request_string.dart';
import '../../UTILS/utils.dart';

List<String> genders = ['Male', 'Female', 'Other'];

TextEditingController fullNameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController phoneNumberController = TextEditingController();
TextEditingController dobController = TextEditingController();
TextEditingController genderController =
TextEditingController(text: genders[0]);
TextEditingController selectedImagePathController = TextEditingController();
TextEditingController receivedImageUrl = TextEditingController();
bool isInitialized = false; // Add a flag to check if the controllers are already initialized
bool isDateSelected = false; // Add a flag to check if the date is already selected



class EditProfileScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {


    if (isInitialized == false) {
      Future.delayed(Duration.zero, () async {
        Map<String, String> data =
        await SharedPrefsUtils.getDefaultValuesFromPrefs();
        fullNameController.text = data["fullName"]!;
        emailController.text = data["email"]!;
        phoneNumberController.text = data["phoneNumber"]!;
        dobController.text = data["dob"]!;
        genderController.text = data["gender"]!.toUpperCase();
        selectedImagePathController.text = data["selectedImagePath"]!.toUpperCase();
        isInitialized = true; // Set the flag to true after initializing controllers
      });
    }
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding:
          const EdgeInsets.only(top: 5.0, bottom: 20, left: 25, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomAppBar(),
              getView(context)

            ],
          ),
        ),
      ),
    );
  }

  Widget getView(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const CustomText(
                  text: "EDIT PROFILE",
                  sizeOfFont: 20,
                  fontfamilly: montHeavy,
                  color: btnbgColor,
                ),
                const SizedBox(
                  height: 10,
                ),


                Container(
                  height: 300,
                  width: 300,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    image: selectedImagePathController.text.isNotEmpty
                        ? DecorationImage(
                      image: FileImage(File(selectedImagePathController.text)),
                      fit: BoxFit.cover,
                    )
                        : Provider.of<SelectImageProvider>(context).selectedImage.isNotEmpty
                        ? DecorationImage(
                      image: FileImage(File(Provider.of<SelectImageProvider>(context).selectedImage)),
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
                            Provider.of<SelectImageProvider>(
                              context,
                              listen: false,
                            ).setSelectedImage(image);

                            try {
                              var data = await Provider.of<AuthenticationProvider>(
                                context,
                                listen: false,
                              ).uploadMultipartImage(
                                File(selectedImagePathController.text),
                                "profile",
                              );

                              print(data);

                              if (data.message == "Image uploaded successfully") {
                                receivedImageUrl.text = data.url ?? '';

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
                                  width: 146,
                                  height: 79,
                                  fit: BoxFit.contain,
                                );
                              },
                            ),
                            SizedBox(height: 16),
                            CustomText(
                              text: "Change Photo",
                              sizeOfFont: 20,
                              fontfamilly: montBook,
                              color: hintColor,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),


                /*  Align(
                  alignment: Alignment.center,
                  child: Image.asset(profile_img,height: 300,fit: BoxFit.contain,)),*/
                const SizedBox(
                  height: 15,
                ),
                CommonEmailField(
                  hintText: fullName,
                  isbgColor: true,
                  controller: fullNameController,
                  isNotClickable: false,
                ),
                const SizedBox(
                  height: 15,
                ),
                CommonEmailField(
                  hintText: email,
                  isbgColor: true,
                  controller: emailController,
                  isNotClickable: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                CommonEmailField(
                  hintText: phoneNumber,
                  isbgColor: true,
                  controller: phoneNumberController,
                  isNotClickable: true,
                  isPhoneNumber: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CommonEditText(
                          hintText: dob,
                          isbgColor: true,
                          isIconShow: true,
                          controller: dobController,
                          onTap: () => _selectDate(context),
                          isSelection: true),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: CommonEditText(
                          hintText: gender,
                          isSelection: true,
                          isIconShow: true,
                          isPassword: true,
                          isbgColor: true,
                          controller: genderController,
                          onTap: () {
                            _showGenderDropdown(context);
                          },
                        )),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                CommonButton(
                    btnBgColor: btnbgColor,
                    btnText: "SAVE",
                    onClick: () async {
                      print(
                          "\nFull Name: ${fullNameController
                              .text} ,\n Email: ${emailController
                              .text},\n Phone Number: ${phoneNumberController
                              .text},\n Date Of Birth: ${dobController
                              .text},\n Gender: ${genderController
                              .text}\nImage: ${receivedImageUrl.text}");

                      if (fullNameController.text.isNotEmpty &&
                          emailController.text.isNotEmpty &&
                          phoneNumberController.text.isNotEmpty &&
                          dobController.text.isNotEmpty &&
                          genderController.text.isNotEmpty &&
                          receivedImageUrl.text.isNotEmpty) {
                        // Check password length
                        final DateProvider dateProvider =
                        Provider.of<DateProvider>(context, listen: false);

                        var date = dateProvider
                            .formattedDate(DateTime.parse(dobController.text));

                        try {
                          var formData = {
                            RequestString.NAME: fullNameController.text,
                            RequestString.EMAIL: emailController.text,
                            RequestString.PHONE_NO: phoneNumberController.text,
                            RequestString.DOB: date,
                            RequestString.GENDER:
                            genderController.text.toLowerCase(),
                            RequestString.USER_IMAGE: receivedImageUrl.text ??
                                '',
                          };

                          formData.forEach((key, value) {
                            print('Request: $key: $value');
                          });

                          EditProfileResponse data =
                          await Provider.of<AuthenticationProvider>(context,
                              listen: false)
                              .editProfile(formData);

                          if (data.status == true &&
                              data.message == "Profile updamted successfully") {
                            // Registration successful

                            int? id = data.data?.id;

                            String? userName = data.data?.name;
                            String? dataOfBirth = data.data?.dOB;
                            String? userImage = data.data?.userImage;
                            String? gender = data.data?.gender;
                            String? userPhoto = selectedImagePathController.text;

                            // Save user data to SharedPreferences

                            await Utility.getSharedPreferences();

                            await Utility.setIntValue(RequestString.ID, id!);

                            await Utility.setStringValue(
                                RequestString.NAME, userName!);
                            await Utility.setStringValue(
                                RequestString.DOB, dataOfBirth!);
                            await Utility.setStringValue(
                                RequestString.USER_IMAGE, userImage!);
                            await Utility.setStringValue(
                                RequestString.GENDER, gender!);
                            await Utility.setStringValue(
                                RequestString.USER_IMAGE, userPhoto!);

                            print(data);
                            Navigator.pushNamed(
                                context, '/NotificationTurnOnScreen');
                          } else {
                            // Registration failed
                            print(
                                "Edit Profile Process failed: ${data.message}");

                            final snackBar = SnackBar(
                              content: Text('${data.message}'),
                            );

// Show the SnackBar
                            ScaffoldMessenger.of(context).showSnackBar(
                                snackBar);

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
                        // Show an error message or handle empty fields
                        final snackBar = SnackBar(
                          content: const Text('Please fill in all the fields.'),
                          action: SnackBarAction(
                            label: 'Ok',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }

                      // Navigator.pop(navigatorKey.currentContext!);
                    }),
              ],
            ),
          ),
        ));
  }


  Future<void> _selectDate(BuildContext context) async {
    if (!isDateSelected) {
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
        isDateSelected = true; // Set the flag to true after selecting the date
      }
    }
  }

  Future<void> _showGenderDropdown(BuildContext context) async {
    if (!isDateSelected) {
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
      selectedImagePathController.text = croppedFile.path;
      return croppedFile.path;
    } else {
      selectedImagePathController.text = "";
      return "";
    }
  }

}
