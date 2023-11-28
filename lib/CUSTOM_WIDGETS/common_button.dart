import 'package:flutter/material.dart';

import '../UTILS/app_color.dart';
import '../UTILS/fontfaimlly_string.dart';
class CommonButton extends StatelessWidget {
  const CommonButton(
      {super.key,
      required this.btnBgColor,
         this.btnTextColor,
      required this.btnText,
      required this.onClick});

  final Color btnBgColor;
  final Color? btnTextColor;
  final String btnText;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: secondaryColor,
            maximumSize: Size.infinite,
            minimumSize: Size(double.maxFinite, 40)),
        onPressed: onClick,
        child: Text(btnText,
            style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
                fontFamily: poppinsMedium,
                fontSize: 18)
        )
    );
  }
}
