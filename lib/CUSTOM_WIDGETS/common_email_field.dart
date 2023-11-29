import 'package:flutter/material.dart';
import '../UTILS/app_color.dart';
import '../UTILS/fontfaimlly_string.dart';
import '../UTILS/validation.dart';

class CommonEmailField extends StatelessWidget {
  CommonEmailField(
      {super.key,
        this.controller,
        required this.hintText,
        this.isPassword,
        this.maxLine,});

  final TextEditingController? controller;
  final int? maxLine;
  final bool? isPassword;
  final String hintText;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: FormValidator.validateEmail,
        keyboardType: TextInputType.text,
        obscureText: isPassword ?? false,
        maxLines: maxLine ?? 1,
        controller: controller,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14,fontFamily: montMedium,color: headingColor
        ),


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
            const TextStyle(fontWeight: FontWeight.w500, fontSize: 14,fontFamily: montMedium,color: hintColor),
            hintText: hintText));

  }
}
