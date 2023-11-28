import 'dart:html';

import 'package:flutter/material.dart';
import '../UTILS/app_color.dart';
import '../UTILS/app_strings.dart';
import '../UTILS/fontfaimlly_string.dart';
import '../UTILS/validation.dart';

class CommonPasswordField extends StatelessWidget {
  const CommonPasswordField(
      {super.key,
        this.controller,
       // this.loginViewModel
        });

  final TextEditingController? controller;
  //final LoginViewModel? loginViewModel;

  @override
  Widget build(BuildContext context) {
    return
      TextFormField(
          validator: FormValidator.validatePassword,
          keyboardType: TextInputType.text,
         // obscureText: !loginViewModel!.isPasswordVisible,
          maxLines: 1,
          controller: controller,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14,fontFamily: poppinsMedium,color: headingColor),
          decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              suffixIcon: (true)
                  ?
              GestureDetector(
                onTap: (){
                 // loginViewModel!.showHidePass(controller!.text);

                },
                child: const Icon(
                  Icons.visibility,
                  color: Colors.grey,
                ),
              ) : GestureDetector(
                onTap: (){
                //  loginViewModel!.showHidePass(controller!.text);

                },
                child: const Icon(
                  Icons.visibility_off,
                  color: Colors.grey,
                ),
              ),
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              hintStyle:
              const TextStyle(fontWeight: FontWeight.w500, fontSize: 14,fontFamily: poppinsMedium,color: hintColor),
              hintText: password));

  }
}
