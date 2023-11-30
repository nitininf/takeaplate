import 'package:flutter/material.dart';
import 'package:takeaplate/UTILS/fontfaimlly_string.dart';

import '../UTILS/app_color.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    super.key,
    this.controller,
    required this.hintText,
  });

  final TextEditingController? controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return
      TextFormField(
          keyboardType: TextInputType.text,
          textAlign: TextAlign.start,
          style: const TextStyle(
              fontWeight: FontWeight.w400, fontSize: 14,
              fontFamily: montBold),
          decoration: InputDecoration(
              filled: true,
              fillColor: editbgColor,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide.none),
              suffixIcon:const Padding(
                padding:  EdgeInsets.only(right: 20.0,top: 10,bottom: 10),
                child:  Icon(Icons.search,color: hintColor),
              ),
              contentPadding:  const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
              hintStyle:  const TextStyle(
                  color: hintColor,
                  fontFamily: montBold,
                  fontSize: 14, fontWeight: FontWeight.w400),
              hintText: hintText));
  }
}
