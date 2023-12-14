import 'package:flutter/material.dart';
import '../UTILS/app_color.dart';
import '../UTILS/fontfaimlly_string.dart';
import '../UTILS/validation.dart';

class CommonTextField extends StatelessWidget {
  CommonTextField(
      {super.key,
      this.controller,
      required this.hintText,
      this.isPassword=true,
      this.maxLine,
      this.onTap});

  final TextEditingController? controller;
  final int? maxLine;
  final bool? isPassword;
  final String hintText;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    // Define your custom BorderSide
    BorderSide customBorderSide = BorderSide(color:editbgColor, width: 0.0); // Adjust the width as needed

    return
      TextFormField(
        keyboardType: TextInputType.text,
        obscureText: isPassword ?? false,
        maxLines: maxLine ?? 1,
        controller: controller,
        readOnly: true,
        onTap: onTap,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14,fontFamily: montMedium,color: btntxtColor),


        decoration: InputDecoration(
            filled: true,
            fillColor:   hintColor ,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18),borderSide: customBorderSide),
            suffixIcon: (isPassword ?? false)
                ? const Icon(
              Icons.arrow_forward,
              color: btnbgColor,
              size: 20,
            )
                : const SizedBox(),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            hintStyle:
            const TextStyle( fontSize: 17,fontFamily: montRegular,color: editbgColor),
            hintText: hintText));

  }
}
