import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_text_style.dart';
import 'package:takeaplate/UTILS/app_images.dart';
import 'package:takeaplate/UTILS/dialog_helper.dart';
import 'package:takeaplate/main.dart';

import '../../CUSTOM_WIDGETS/common_button.dart';
import '../../CUSTOM_WIDGETS/common_edit_text.dart';
import '../../CUSTOM_WIDGETS/common_email_field.dart';
import '../../MULTI-PROVIDER/DateProvider.dart';
import '../../MULTI-PROVIDER/selectImageProvider.dart';
import '../../UTILS/app_color.dart';
import '../../UTILS/app_strings.dart';
import '../../UTILS/fontfaimlly_string.dart';

List<String> genders = ['Male', 'Female', 'Other'];

TextEditingController fullNameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController phoneNumberController = TextEditingController();
TextEditingController dobController = TextEditingController();
TextEditingController genderController = TextEditingController(text: genders[0]);
TextEditingController selectedImagePathController = TextEditingController();


class EditProfileScreen extends StatelessWidget{



  @override
  Widget build(BuildContext context) {



    return  Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top:5.0,bottom: 20,left: 25,right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CustomAppBar(),

              getView(context)

            ],
          ),
        ),
      ),
    );
  }

  Widget getView(BuildContext context){
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              const CustomText(text: "EDIT PROFILE",sizeOfFont: 20,fontfamilly: montHeavy,color: btnbgColor,),
              const SizedBox(height: 10,),

              Container(
                height: 300,
                width: 300,
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
              const SizedBox(height: 15,),
              CommonEmailField(hintText: fullName,isbgColor: true,controller: fullNameController,),
              const SizedBox(height: 15,),
              CommonEmailField(hintText: email,isbgColor: true,controller: emailController,),
              const SizedBox(height: 15,),
              CommonEmailField(hintText: phoneNumber,isbgColor: true,controller: phoneNumberController,isPhoneNumber: true,),
              const SizedBox(height: 15,),
              Row(
                children: [
                  Expanded(child: CommonEditText(hintText: dob,isbgColor: true,controller: dobController,onTap: () => _selectDate(context),isSelection: true),),
                  const SizedBox(width: 10,),
                  Expanded(child: CommonEditText(hintText: gender,isSelection: true,isPassword: true,isbgColor: true,controller: genderController,
                    onTap: () {
                      _showGenderDropdown(context);
                    },)),
                ],
              ),
              SizedBox(height: 30,),
              CommonButton(btnBgColor: btnbgColor, btnText: "SAVE", onClick: (){

                print("Full Name: ${fullNameController.text} ,\n Email: ${emailController.text},\n Phone Number: ${phoneNumberController.text},\n Date Of Birth: ${dobController.text},\n Gender: ${genderController.text}");


                // Navigator.pop(navigatorKey.currentContext!);

              }),
            ],
          ),
        ),
      )
    );
  }
}

  Future<void> _selectDate(BuildContext context) async {
    print("Selecting date...");
    final DateProvider dateProvider = Provider.of<DateProvider>(context, listen: false);
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
                title: Text('Select Gender', style: TextStyle(fontWeight: FontWeight.bold)),
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
