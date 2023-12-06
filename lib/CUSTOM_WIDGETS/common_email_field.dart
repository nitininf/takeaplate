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
        this.maxLine,
      this.isbgColor=false});

  final TextEditingController? controller;
  final int? maxLine;
  final bool? isPassword;
  final String hintText;
  final bool isbgColor;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
        validator: FormValidator.validateEmail,
        keyboardType: TextInputType.text,
        obscureText: isPassword ?? false,
        maxLines: maxLine ?? 1,
        controller: controller,
        style:  TextStyle(fontWeight: FontWeight.w500, fontSize: 14,fontFamily: montBook,color:isbgColor ? btntxtColor:  headingColor
        ),


        decoration: InputDecoration(
            filled: true,
            fillColor: isbgColor ? hintColor : editbgColor,

            border: !isbgColor ? OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide.none)
                : OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: grayColor,width: 0)),

            suffixIcon: (isPassword ?? false)
                ? const Icon(
              Icons.remove_red_eye,
              color: Colors.grey,
            )
                : const SizedBox(),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            hintStyle:
             TextStyle(fontWeight: FontWeight.w400, fontSize: 16,fontFamily: montitalic,color: isbgColor ? btntxtColor : hintColor),
            hintText: hintText));

  }
}
