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
  final bool isnewCard;
  final VoidCallback? onTap; // Corrected the callback type to VoidCallback
  FocusNode? focusNode;
  final String? fontfamilly;
  CommonEditText({
    Key? key, // Added Key parameter
    this.controller,
    required this.hintText,
    this.isPassword = false, // Provide a default value for isPassword
    this.isbgColor = false, // Provide a default value for isPassword
    this.isnewCard = false, // Provide a default value for isPassword
    this.onTap,
    this.focusNode,
    this.fontfamilly,
  });

  @override
  Widget build(BuildContext context) {
    final FocusNode emailFocusNode = FocusNode();
    return // Use the provided onTap callback

        TextFormField(
          onTap: onTap,
          keyboardType: isPassword ? TextInputType.name : TextInputType.datetime,
          inputFormatters:!isPassword? <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'^[+-]?[\d]+\.?[\d]*$')),
          ]: null,
          focusNode: focusNode,
          validator: FormValidator.validateEmpty,
          maxLength: 15,
          controller: controller,
          style:  TextStyle(
            fontSize: isnewCard ? 16 : 20,
            fontFamily: fontfamilly ?? montBook,
            color: isbgColor ? editbgColor :isnewCard ? onboardingBtn : readybgColor, // Make sure to define your colors properly
          ),
          decoration: InputDecoration(
            counterText: '',
            filled: true,
            fillColor: isbgColor ? hintColor  : isnewCard ? newcardbgColor  : editbgColor,
            border: !isbgColor ? OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide.none)
            : OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: graysColor,style:BorderStyle.none )),

            suffixIcon: isPassword
                ? const Icon(
              Icons.arrow_downward_outlined,
              color: btnbgColor,
              size: 15,
            )
                : const SizedBox(),
            contentPadding: isbgColor ?const EdgeInsets.symmetric(horizontal: 20, vertical: 16)  : isnewCard ?const EdgeInsets.symmetric(horizontal: 20, vertical: 10):const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            hintStyle:  TextStyle(
              fontFamily: fontfamilly ?? montBook,
              fontSize: isnewCard ? 16 : 20,
              color: isbgColor ? editbgColor :isnewCard ? onboardingBtn : readybgColor, // Define your hint color properly
            ),
            hintText: hintText,
          ),
        );

  }
}
