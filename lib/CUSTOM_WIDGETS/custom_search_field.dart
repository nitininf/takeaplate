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
  final String? hintText;

  @override
  Widget build(BuildContext context) {
   // final FocusNode _focusNode = FocusNode();
    return
      TextFormField(
          keyboardType: TextInputType.text,
         controller: controller,
          textAlign: TextAlign.start,
       //   focusNode: _focusNode,
          style: const TextStyle(
              fontSize: 18,
              color: hintColor,
              fontFamily: montBook),
          decoration: InputDecoration(
              filled: true,
              fillColor: editbgColor,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide.none),
              suffixIcon:const Padding(
                padding:  EdgeInsets.only(right: 20.0,top: 10,bottom: 10),
                child:  Icon(Icons.search,color: hintColor,size: 25,),
              ),
              contentPadding:  const EdgeInsets.symmetric(horizontal: 30,vertical: 13),
              hintStyle:  const TextStyle(
                  color: hintColor,
                  fontFamily: montBook,
                  fontSize: 18),
              hintText: hintText ?? "Gold Coast, Australia"));
  }
}
