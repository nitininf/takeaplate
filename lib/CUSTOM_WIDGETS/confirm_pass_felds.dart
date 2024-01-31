import 'package:flutter/material.dart';
import '../UTILS/app_color.dart';
import '../UTILS/app_strings.dart';
import '../UTILS/fontfamily_string.dart';
import '../UTILS/validation.dart';
class ConfirmPasswordField extends StatefulWidget {
  const ConfirmPasswordField({
    Key? key,
    this.controller,
    this.isPassword = false,
    this.isConfirmPassword = false,
  }) : super(key: key);

  final TextEditingController? controller;
  final bool? isPassword;
  final bool? isConfirmPassword;

  @override
  _ConfirmPasswordFieldState createState() => _ConfirmPasswordFieldState();
}

class _ConfirmPasswordFieldState extends State<ConfirmPasswordField> {
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
        hintText: (widget.isConfirmPassword ?? false)
            ? 'Confirm Password'
            : 'Password',
      ),
    );
  }
}

