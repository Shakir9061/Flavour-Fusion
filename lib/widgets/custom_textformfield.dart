import 'package:flutter/material.dart';

class CustomTextformfield extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardtype;
  final  TextStyle? style;
  final Widget? suffixIcon;

  const CustomTextformfield({super.key,  this.controller,    this.keyboardtype,  this.style, this.hintText, this.suffixIcon, });

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 60,
      width: 330,
      child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hintText,
        filled: true,
        fillColor: Color(0xff1D1B20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),)
      ),
      style: style,
      keyboardType: keyboardtype,
      ),
    );
  }
}