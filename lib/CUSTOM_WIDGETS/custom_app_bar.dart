import 'package:flutter/material.dart';
import '../UTILS/app_color.dart';
import '../UTILS/app_images.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key,
      this.logoColor,
      this.index,
      this.textColor,
      this.isMenu,
      this.onTap,
      this.onTap_one,
      this.onIconTap});

  final bool? isMenu;
  final int? index;
  final Color? logoColor;
  final Color? textColor;
  final VoidCallback? onTap;
  final VoidCallback? onTap_one;
  final VoidCallback? onIconTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: bgColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Visibility(
              visible: index!=2,
              child: GestureDetector(
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
            ),if (index == 2)
              SizedBox(
                width: 17,
              ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: onIconTap ??
                      (){
                        Navigator.pushReplacementNamed(context, '/BaseHome');

                      },
                  child: Image.asset(
                    appLogo,
                    height: 56,
                    width: 60,
                  ),
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
