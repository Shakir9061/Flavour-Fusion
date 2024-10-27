import 'package:flutter/material.dart';

class CustomTextformfield extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardtype;
  final  TextStyle? style;
  final Widget? suffixIcon;
  final TextStyle? hintStyle;
  final double? height;
  final double? width;
  final  int? maxLines;
  const CustomTextformfield({super.key,  this.controller,    this.keyboardtype,  this.style, this.hintText, this.suffixIcon, this.hintStyle, this.height, this.width, this.maxLines, });

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: height,
      width: width,
      child: TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: hintStyle,
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