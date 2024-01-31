import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_button.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_edit_text.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/common_email_field.dart';
import 'package:takeaplate/CUSTOM_WIDGETS/custom_app_bar.dart';
import 'package:takeaplate/MULTI-PROVIDER/ContactUsProvider.dart';
import 'package:takeaplate/Response_Model/ContactUsResponse.dart';
import 'package:takeaplate/main.dart';

import '../../CUSTOM_WIDGETS/custom_text_style.dart';
import '../../UTILS/app_color.dart';
import '../../UTILS/app_strings.dart';
import '../../UTILS/fontfamily_string.dart';
import '../../UTILS/request_string.dart';
import '../../UTILS/validation.dart';

TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController commentsController = TextEditingController();

class ContactUsSetting extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0,bottom: 20,right: 29,left: 29),
          child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 const CustomAppBar(),
                getView(context)
        
              ]
          ),
        ),
      ),

    );



  }

  Widget getView(BuildContext context)
  {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            const CustomText(text: "CONTACT US",sizeOfFont: 20,fontfamilly: montHeavy,color: editbgColor,),
            const SizedBox(height: 20,),
            // CommonEditText(hintText: name,isbgColor: true,),
            Container(
                height: 49,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: editbgColor.withOpacity(0.25),
                    width: 1.0, // Adjust the width as needed
                  ),
                ),
                child: TextFormField(

                    keyboardType: TextInputType.text,
                      controller: nameController,
                    style:  const TextStyle( fontSize: 20,fontFamily: montBook,color:editbgColor
                    ),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 20,fontFamily: montBook,color: editbgColor),
                        hintText: "Name")
                )
            ),
            const SizedBox(height: 20,),
            Container(
                height: 49,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: editbgColor.withOpacity(0.25),
                    width: 1.0, // Adjust the width as needed
                  ),
                ),
                child: TextFormField(
                    validator: FormValidator.validateEmail,
                    keyboardType: TextInputType.text,
                    controller: emailController,

                    style:  const TextStyle( fontSize: 20,fontFamily: montBook,color:editbgColor
                    ),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(fontSize: 20,fontFamily: montBook,color: editbgColor),
                        hintText: "Email")
                )
            ),
            // CommonEmailField(hintText: email,isbgColor: true,),
            const SizedBox(height:  20,),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: editbgColor.withOpacity(0.25),
                    width: 1.0, // Adjust the width as needed
                  ),
                ),
                child: TextFormField(
                    validator: FormValidator.validateEmail,
                    keyboardType: TextInputType.text,
                    maxLines: 15,
                      controller: commentsController,
                    style:  const TextStyle(fontWeight: FontWeight.w500, fontSize: 14,fontFamily: montBook,color:btntxtColor
                    ),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle( fontSize: 20,fontFamily: montBook,color: editbgColor),
                        hintText: "Comments")
                )
            ),

            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(top: 8.0,left: 27,right: 27),
              child: CommonButton(btnBgColor: btnbgColor, btnText: submit, onClick: () async {
                var validEmail = FormValidator.validateEmail(emailController.text);

                if (nameController.text.isEmpty && emailController.text.isEmpty&& commentsController.text.isEmpty) {




                  // Show an error message or handle empty fields
                  final snackBar = SnackBar(
                    content: const Text('Please enter all required parameters...'),
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
                else if (validEmail != null) {
                  final snackBar = SnackBar(
                    content: Text('Please enter valid Email Id'),
                  );

                  // Show the SnackBar
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);

                  // Automatically hide the SnackBar after 1 second
                  Future.delayed(Duration(milliseconds: 1000), () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  });
                }
                else {
                  try {
                    var formData = {
                      RequestString.NAME: nameController.text,
                      RequestString.EMAIL: emailController.text,
                      RequestString.COMMENTS: commentsController.text,

                    };

                    ContactUsResponse data = await Provider.of<ContactUsProvider>(context, listen: false)
                        .contactUsForm(formData);

                    if (data.status == true && data.message == "Contact form submitted successfully") {


                      final snackBar = SnackBar(
                        content:  Text('${data.message}'),

                      );

// Show the SnackBar
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

// Automatically hide the SnackBar after 1 second
                      Future.delayed(Duration(milliseconds: 1000), () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      });

                      nameController.text='';
                      emailController.text='';
                      commentsController.text='';
                      Navigator.of(context).pushNamedAndRemoveUntil('/BaseHome', (Route route) => false);


                      // Print data to console
                      print(data);

                      // Navigate to the next screen or perform other actions after login
                    }

                    else {
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

                // Navigator.pushNamed(navigatorKey.currentContext!, '/YourOrderScreen');


              }),
            )
          ],
        ),
      ),
    );
  }

}