import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
            fontSize: 14,
            color: Colors.black, // Make sure to define your colors properly
          ),
          decoration: InputDecoration(
            counterText: '',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
            suffixIcon: isPassword
                ? const Icon(
              Icons.arrow_downward_outlined,
              color: Colors.grey,
              size: 13,
            )
                : const SizedBox(),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            hintStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.grey, // Define your hint color properly
            ),
            hintText: hintText,
          ),
        );

  }
}
