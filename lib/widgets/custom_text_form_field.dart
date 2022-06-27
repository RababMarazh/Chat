import 'dart:ui';

import 'package:flutter/material.dart';

class Custom_TextFormtField extends StatelessWidget {
  Custom_TextFormtField(
      {
      this.onChange,
      this.hintText,
      this.validator,
      this.PrefixIcon,
      this.ObscureText = false
      }
      );
  Function(String)? onChange;
  String? hintText;
  dynamic validator;
  IconData? PrefixIcon;
  bool? ObscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: ObscureText!,
      cursorColor: Colors.yellow,
      style: TextStyle(color: Colors.orange),
      validator: validator,
      onChanged: onChange,
      decoration: InputDecoration(
        prefixIcon: Icon(PrefixIcon),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.limeAccent)),
      ),
    );
  }
}
