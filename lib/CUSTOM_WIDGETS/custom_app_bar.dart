import 'package:flutter/material.dart';
import '../UTILS/app_images.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key,
      this.logoColor,
      this.textColor,
      this.isMenu,
      this.onTap,
      this.onTap_one});
  final bool? isMenu;
  final Color? logoColor;
  final Color? textColor;
  final VoidCallback? onTap;
  final VoidCallback? onTap_one;

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
        Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        GestureDetector(
        onTap:onTap_one ?? (){
          Navigator.pop(context);
        },
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
    height: 60,
    width: 60,
    ),
    ),
    ),
    Center(
    child:  GestureDetector(
      onTap: onTap,
      child: Image.asset(
      menu_icon,
      height: 20,
      width: 20,
      fit: BoxFit.cover,
      ),
    )
    )
    ],
    )
    );
  }
}
