import 'package:flutter/material.dart';

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
      Container(
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        color: searchcolor.withOpacity(0.4),
         ),

       child: Padding(
         padding: const EdgeInsets.all(8.0),
         child: TextFormField(
             keyboardType: TextInputType.text,
             textAlign: TextAlign.center,
             style: const TextStyle(
                 fontWeight: FontWeight.w400, fontSize: 13),
            decoration: InputDecoration(
            border: InputBorder.none,
                 prefixIcon: const Icon(Icons.search,color: hintColor,),
                 contentPadding:  const EdgeInsets.symmetric(horizontal: 30,vertical: 0),
                 hintStyle:  TextStyle(
                   color: hintColor.withOpacity(0.4),
                    fontSize: 13, fontWeight: FontWeight.w400),
                hintText: hintText)),
       )
    );
  }
}
