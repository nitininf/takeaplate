import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../UTILS/app_color.dart';
import '../UTILS/fontfamily_string.dart';
import '../UTILS/validation.dart';

class CommonEmailField extends StatelessWidget {
  const CommonEmailField({
    Key? key,
    this.controller,
    required this.hintText,
    this.isPassword,
    this.maxLine,
    this.isbgColor = false,
    this.isPhoneNumber = false,
    this.isNotClickable = false,
    this.isUsername = false,
  }) : super(key: key);

  final TextEditingController? controller;
  final int? maxLine;
  final bool? isPassword;
  final String hintText;
  final bool isbgColor;
  final bool isPhoneNumber;
  final bool isNotClickable;
  final bool isUsername;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (isUsername) {
          // Validate only alphabets for the username field
          return FormValidator.validateAlphabets(value);
        } else {
          // Validate email or phone number based on the configuration
          return isPhoneNumber
              ? FormValidator.validatePhoneNumber(value)
              : FormValidator.validateEmail(value);
        }
      },
      keyboardType: isPhoneNumber
          ? TextInputType.phone
          : (isPassword ?? false)
          ? TextInputType.visiblePassword
          : TextInputType.text,
      inputFormatters: isPhoneNumber
          ? [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
        LengthLimitingTextInputFormatter(13),
      ]
          : isUsername
          ? [
        FilteringTextInputFormatter.allow(RegExp(r'[a-z A-Z]')),
      ]
          : [],
      readOnly: isNotClickable,
      obscureText: isPassword ?? false,
      maxLines: maxLine ?? 1,
      controller: controller,
      style: TextStyle(
        fontSize: 20,
        fontFamily: montBook,
        color: isbgColor ? btntxtColor : hintColor,
        // color: isbgColor ? btntxtColor : readybgColor,

        decoration: TextDecoration.none,
        decorationThickness: 0,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: isbgColor ? hintColor : editbgColor,
        labelStyle: TextStyle(decoration: TextDecoration.none),
        enabledBorder: !isbgColor
            ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none)
            : OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: editbgColor, width: 1)),
        focusedBorder: !isbgColor
            ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none)
            : OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: editbgColor, width: 1)),
        // suffixIcon: (isPassword ?? false)
        //     ? const Icon(
        //   Icons.remove_red_eye,
        //   color: Colors.grey,
        // )
        //     : const SizedBox(),
        contentPadding: isbgColor
            ? const EdgeInsets.symmetric(horizontal: 20, vertical: 16)
            : const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: TextStyle(
          fontSize: 18,
          fontFamily: montBook,
          color: isbgColor ? btntxtColor : readybgColor,
        ),
        hintText: hintText,
      ),
    );
  }
}

