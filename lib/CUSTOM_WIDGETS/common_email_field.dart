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
        style:  TextStyle(fontSize: 20,fontFamily: montBook,color:isbgColor ? btntxtColor:  readybgColor,
          decoration: TextDecoration.none,
        ),


        decoration: InputDecoration(
            filled: true,
            fillColor: isbgColor ? hintColor : editbgColor,
            labelStyle: TextStyle(decoration: TextDecoration.none),
            enabledBorder: !isbgColor ? OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide.none)
                : OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: editbgColor,width: 1)),
            focusedBorder: !isbgColor ? OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide.none)
                : OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: editbgColor,width: 1)),

            suffixIcon: (isPassword ?? false)
                ? const Icon(
              Icons.remove_red_eye,
              color: Colors.grey,
            )
                : const SizedBox(),
            contentPadding:
            isbgColor? const EdgeInsets.symmetric(horizontal: 20, vertical: 16):const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            hintStyle:
             TextStyle(fontSize: 20,fontFamily: montBook,color: isbgColor ? btntxtColor : readybgColor),
            hintText: hintText));

  }
}
