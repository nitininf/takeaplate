import 'dart:ffi';

import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {super.key,
      this.color,
      this.sizeOfFont,
      this.weight,
      this.maxLin,
      this.fontfamilly,
      required this.text,
      this.isAlign=false}
        );

  final String text;
  final FontWeight? weight;
  final double? sizeOfFont;
  final Color? color;
  final int? maxLin;
  final String? fontfamilly;
  final bool? isAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign:  isAlign! ? TextAlign.center : null,
      maxLines: maxLin ?? 100,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontWeight: weight ?? FontWeight.w500,
          fontSize: sizeOfFont ?? 14,
          fontFamily: fontfamilly,
          color: color ?? Colors.black87),
    );
  }
}
