import 'package:flutter/material.dart';
import '../UTILS/app_color.dart';
import '../UTILS/app_strings.dart';
import '../UTILS/fontfaimlly_string.dart';
import '../UTILS/validation.dart';

class CommonPasswordField extends StatelessWidget {
  const CommonPasswordField(
      {super.key,
        this.controller,
        this.isPassword=false
       // this.loginViewModel
        });

  final TextEditingController? controller;
  final bool? isPassword;
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
          style: const TextStyle(fontSize: 20,fontFamily: montBook,color: headingColor),
          decoration: InputDecoration(
              filled: true,
              fillColor: editbgColor,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide.none),
              suffixIcon: (isPassword ?? false)
                  ? const Icon(
                Icons.remove_red_eye,
                color: Colors.grey,
              )
                  : const SizedBox(),
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              hintStyle:
              const TextStyle( fontSize: 20,fontFamily: montBook,color: hintColor),
              hintText: "password"));

  }
}
