import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:takeaplate/UTILS/app_images.dart';
import 'package:takeaplate/UTILS/fontfaimlly_string.dart';
import '../UTILS/app_color.dart';
import '../UTILS/validation.dart';

class CommonEditText extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool isPassword;
  final bool isSelection;
  final bool isbgColor;
  final bool isnewCard;
  final bool isIconShow;
  final VoidCallback? onTap; // Corrected the callback type to VoidCallback
  FocusNode? focusNode;
  final String? fontfamilly;
  CommonEditText({
    Key? key, // Added Key parameter
    this.controller,
    required this.hintText,
    this.isPassword = false, // Provide a default value for isPassword
    this.isSelection = false, // Provide a default value for isPassword
    this.isbgColor = false, // Provide a default value for isPassword
    this.isnewCard = false, // Provide a default value for isPassword
    this.isIconShow = false, // Provide a default value for isPassword
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
         readOnly: isSelection,

         // keyboardType: isPassword ? TextInputType.name : TextInputType.datetime,
         /* inputFormatters:!isPassword? <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'^[+-]?[\d]+\.?[\d]*$')),
          ]: null,*/
         // focusNode: focusNode,
          validator: FormValidator.validateEmpty,
          maxLength: 15,
          controller: controller,
          // focusNode: focusNode,
          autofocus: !isSelection, // Set autofocus based on isCalender value
          style:  TextStyle(
            decoration: TextDecoration.none,
            decorationThickness: 0,
            fontSize: isnewCard ? 16 : 18,
            fontFamily: fontfamilly ?? montBook,
            color: isbgColor ? editbgColor :isnewCard ? onboardingBtn : readybgColor, // Make sure to define your colors properly
          ),
          decoration: InputDecoration(
            counterText: '',
            filled: true,
            fillColor: isbgColor ? hintColor  : isnewCard ? newcardbgColor  : editbgColor,
            focusedBorder: !isbgColor ? OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide.none)
            : OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color:editbgColor,style:BorderStyle.solid )),

            enabledBorder: !isbgColor ? OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide.none)
                : OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color:editbgColor,style:BorderStyle.solid )),

            suffixIcon: isIconShow
                ? (isPassword
                ? IconButton(
              onPressed: () {},
              icon: Image.asset(down_arrow, height: 16, width: 12),
            )
                : null) // Conditionally set suffixIcon to null if isIconShow is true and isPassword is false
                : const SizedBox(),
            contentPadding: isbgColor ?const EdgeInsets.symmetric(horizontal: 20, vertical: 16)  : isnewCard ?const EdgeInsets.symmetric(horizontal: 20, vertical: 10):const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            hintStyle:  TextStyle(
              fontFamily: fontfamilly ?? montBook,
              fontSize: isnewCard ? 16 : 18,
              color: isbgColor ? editbgColor :isnewCard ? onboardingBtn : readybgColor, // Define your hint color properly
            ),
            hintText: hintText,
          ),
        );

  }
}
