import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:takeaplate/UTILS/fontfaimlly_string.dart';
import '../UTILS/app_color.dart';
import '../UTILS/validation.dart';

class CommonEditText extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool isPassword;
  final VoidCallback? onTap; // Corrected the callback type to VoidCallback
  FocusNode? focusNode;
  CommonEditText({
    Key? key, // Added Key parameter
    this.controller,
    required this.hintText,
    this.isPassword = false, // Provide a default value for isPassword
    this.onTap,
    this.focusNode,
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
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            fontFamily: montBook,
            color: hintColor, // Make sure to define your colors properly
          ),
          decoration: InputDecoration(
            counterText: '',
            filled: true,
            fillColor: editbgColor,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide.none),

            suffixIcon: isPassword
                ? const Icon(
              Icons.arrow_downward_outlined,
              color: btnbgColor,
              size: 15,
            )
                : const SizedBox(),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            hintStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: montBook,
              fontSize: 16,
              color: hintColor, // Define your hint color properly
            ),
            hintText: hintText,
          ),
        );

  }
}
