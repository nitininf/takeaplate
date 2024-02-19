import 'package:flutter/material.dart';
import 'package:take_a_plate/UTILS/app_images.dart';
import '../UTILS/app_color.dart';
import '../UTILS/fontfamily_string.dart';
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
        style: const TextStyle( fontSize: 14,fontFamily: montMedium,color: btntxtColor,
          decoration: TextDecoration.none,
          decorationThickness: 0,),


        decoration: InputDecoration(
            filled: true,
            fillColor:   hintColor ,
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18),borderSide: BorderSide(color:editbgColor,style:BorderStyle.solid )),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18),borderSide: BorderSide(color:editbgColor,style:BorderStyle.solid )),

            suffixIcon: (isPassword ?? false)
                ? IconButton(onPressed:onTap, icon: Image.asset(arrow_back,height: 16,width: 12,))
                : const SizedBox(),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            hintStyle:
            const TextStyle( fontSize: 17,fontFamily: montRegular,color: editbgColor),
            hintText: hintText));

  }
}
