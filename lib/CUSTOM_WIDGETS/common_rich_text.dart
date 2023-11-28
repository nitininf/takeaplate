import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../UTILS/app_color.dart';
import '../UTILS/fontfaimlly_string.dart';

class CommonRichText extends StatelessWidget {
  const CommonRichText({
    super.key,
    required this.text,
    required this.colorChangeText,
  });

  final String? text;
  final String? colorChangeText;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text!,
          style: const TextStyle(
              fontSize: 14,
              fontFamily: poppinsMedium,
              fontWeight: FontWeight.w500,
              color: accentColor),
        ),
        Text(
          colorChangeText!,
          style: const TextStyle(
              fontSize: 14,
              fontFamily: poppinsMedium,
              fontWeight: FontWeight.w500,
              color: secondaryColor),
        )
      ],
    );
  }
}
