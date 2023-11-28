import 'package:flutter/material.dart';

class CustomSelector extends StatelessWidget {
  final String text;
  final bool isPassword;
  final VoidCallback? onTap; // Corrected the callback type to VoidCallback
  final Color bgColor; // Corrected the callback type to VoidCallback

  CustomSelector({
    Key? key, // Added Key parameter
    required this.text,
    required this.bgColor,
    this.isPassword = true, // Provide a default value for isPassword
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return
      Container(
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(width: 0.7, color: bgColor),
          borderRadius: BorderRadius.circular(16),
        ),
        child: GestureDetector(
          onTap: onTap, // Use the provided onTap callback
          child:

            Padding(
              padding: const EdgeInsets.all(7),
              child: Text(text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 10,
                color: Colors.white, // Define your hint color properly
              ),
              ),
            )
          ),

      );
  }
}
