import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:takeaplate/UTILS/fontfaimlly_string.dart';
import '../UTILS/app_color.dart';
import '../UTILS/validation.dart';

class CommonEditText extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool isPassword;
  final bool isbgColor;
  final VoidCallback? onTap; // Corrected the callback type to VoidCallback
  FocusNode? focusNode;
  final String? fontfamilly;
  CommonEditText({
    Key? key, // Added Key parameter
    this.controller,
    required this.hintText,
    this.isPassword = false, // Provide a default value for isPassword
    this.isbgColor = false, // Provide a default value for isPassword
    this.onTap,
    this.focusNode,
    this.fontfamilly,
  });

  @override
  Widget build(BuildContext context) {
    return // Use the provided onTap callback

        TextFormField(
          onTap: onTap,
          keyboardType: isPassword ? null : TextInputType.numberWithOptions(decimal: true),
          inputFormatters:!isPassword? <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'^[+-]?[\d]+\.?[\d]*$')),
          ]: null,
          focusNode: focusNode,
          validator: FormValidator.validateEmpty,
          maxLength: 15,
          controller: controller,
          style:  TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            fontFamily: fontfamilly ?? montitalic,
            color: isbgColor ? editbgColor : hintColor, // Make sure to define your colors properly
          ),
          decoration: InputDecoration(
            counterText: '',
            filled: true,
            fillColor: isbgColor ? hintColor : editbgColor,
            border: !isbgColor ? OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide.none)
            : OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: blackColor)),

            suffixIcon: isPassword
                ? const Icon(
              Icons.arrow_downward_outlined,
              color: btnbgColor,
              size: 15,
            )
                : const SizedBox(),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            hintStyle:  TextStyle(
              fontWeight: FontWeight.w400,
              fontFamily: fontfamilly ?? montitalic,
              fontSize: 16,
              color: isbgColor ? editbgColor : hintColor, // Define your hint color properly
            ),
            hintText: hintText,
          ),
        );

  }
}
