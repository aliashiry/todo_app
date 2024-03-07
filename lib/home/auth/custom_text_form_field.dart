import 'package:flutter/material.dart';
import 'package:todo_app/theme/my_theme.dart';

typedef myValidator = String? Function(String?);

class CustomTextFormField extends StatelessWidget {
  String lableText;
  TextInputType keyboardType;
  TextEditingController controller;
  myValidator validator;
  bool obscureText;

  Widget? suffixIcon;

  CustomTextFormField(
      {required this.lableText,
      required this.controller,
      required this.validator,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          suffix: suffixIcon,
          labelText: lableText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: MyTheme.primaryColor,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: MyTheme.primaryColor,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: MyTheme.redColor,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: MyTheme.redColor,
              width: 1,
            ),
          ),
        ),
        keyboardType: keyboardType,
        controller: controller,
        validator: validator,
        obscureText: obscureText,
      ),
    );
  }
}
