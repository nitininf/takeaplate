import 'package:flutter/material.dart';

import '../UTILS/app_color.dart';
import '../UTILS/app_images.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key,
      this.logoColor,
      this.textColor,
      this.isMenu,
      this.onTap});
  final bool? isMenu;
  final Color? logoColor;
  final Color? textColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
        Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        GestureDetector(
        onTap:onTap ,
        child: Image.asset(
        back_arrow,
        height: 20,
        width: 20,
    ),
    ),
    Expanded(
    child: Align(
    alignment: Alignment.center,
    child:  Image.asset(
    appLogo,
    height: 75,
    width: 75,
    ),
    ),
    ),
    Center(
    child:  Image.asset(
    menu_icon,
    height: 20,
    width: 20,
    fit: BoxFit.cover,
    )
    )
    ],
    )
    );
  }
}
