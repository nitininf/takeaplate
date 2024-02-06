import 'package:flutter/material.dart';
import '../UTILS/app_color.dart';
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
        color: bgColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: onTap_one ??
                  () {
                    Navigator.pop(context);
                  },
              child: Image.asset(
                back_arrow,
                height: 27,
                width: 17,
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  appLogo,
                  height: 56,
                  width: 60,
                ),
              ),
            ),
            Center(
                child: onTap_one == null
                    ? Text("")
                    : GestureDetector(
                        onTap: onTap,
                        child: Image.asset(
                          menu_icon,
                          height: 23,
                          width: 34,
                          fit: BoxFit.contain,
                        )))
          ],
        ));
  }
}
