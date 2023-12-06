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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0), // Set your desired radius here
            ),
            backgroundColor: btnBgColor,
            maximumSize: Size.infinite,
            minimumSize: const Size(double.maxFinite, 55)),
        onPressed: onClick,
        child: Text(btnText,
            style: const TextStyle(
                color: btntxtColor,
                fontWeight: FontWeight.w800,
                fontFamily: montMedium,
                fontSize: 16)
        )
    );
  }
}
