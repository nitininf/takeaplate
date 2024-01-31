import 'package:flutter/material.dart';

import '../UTILS/app_color.dart';
import '../UTILS/fontfamily_string.dart';
class CommonButton extends StatelessWidget {
  const CommonButton(
      {super.key,
      required this.btnBgColor,
         this.btnTextColor,
      required this.btnText,
      required this.onClick,
      this.sizeOfFont});

  final Color btnBgColor;
  final Color? btnTextColor;
  final String btnText;
  final VoidCallback onClick;
  final double? sizeOfFont;

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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:  TextStyle(
                color: btnTextColor ?? btntxtColor,
                fontFamily: montHeavy,
                fontSize: sizeOfFont ?? 20)
        )
    );
  }
}
