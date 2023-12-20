import 'package:flutter/material.dart';
import '../UTILS/app_color.dart';
import '../UTILS/app_strings.dart';
import '../UTILS/fontfaimlly_string.dart';
import '../UTILS/validation.dart';

class CommonPasswordField extends StatefulWidget {
  const CommonPasswordField({
    Key? key,
    this.controller,
    this.isPassword = false,
  }) : super(key: key);

  final TextEditingController? controller;
  final bool? isPassword;

  @override
  _CommonPasswordFieldState createState() => _CommonPasswordFieldState();
}

class _CommonPasswordFieldState extends State<CommonPasswordField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: FormValidator.validatePassword,
      keyboardType: TextInputType.text,
      obscureText: !_isPasswordVisible,
      maxLines: 1,
      controller: widget.controller,
      style: const TextStyle(
        fontSize: 20,
        fontFamily: montBook,
        color: hintColor,
        decoration: TextDecoration.none,
        decorationThickness: 0,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: editbgColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        suffixIcon: (widget.isPassword ?? false)
            ? IconButton(
          icon: Icon(
            _isPasswordVisible
                ? Icons.visibility
                : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        )
            : const SizedBox(),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        hintStyle: const TextStyle(
          fontSize: 20,
          fontFamily: montBook,
          color: hintColor,
        ),
        hintText: "password",
      ),
    );
  }
}
