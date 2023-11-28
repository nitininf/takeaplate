import 'package:flutter/material.dart';

import '../UTILS/app_color.dart';
import '../UTILS/app_images.dart';
import '../UTILS/fontfaimlly_string.dart';
import 'custom_text_style.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key,
      required this.heading,
      required this.isheading,
      this.logoColor,
      this.textColor,
      this.isMenu,
      this.onTap});

  final String? heading;
  final bool isheading;
  final bool? isMenu;
  final Color? logoColor;
  final Color? textColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap:onTap ,
                child: Image.asset(
                  "images/back-arrow.png",
                  height: 24,
                  width: 24,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: CustomText(
                    text: heading!,
                    sizeOfFont: 20,
                    fontfamilly: poppinsSemiBold,
                    weight: FontWeight.w600,
                    color: jobwiishColor,
                  ),
                ),
              ),
            ],
          ),
          Center(
              child: !isheading ? Image.asset(
            appLogo,
            height: 43,
            width: 65,
            fit: BoxFit.cover,
          ) : const Text("")
          )
        ],
      ),
    );
  }
}
