import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class CustomAlertdialog extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final List<Widget>? actions;
  final ShapeBorder? shape;
  final Color backgroundColor;
  final AlignmentGeometry? alignment;

  const CustomAlertdialog(
      {super.key,
      this.title,
      this.content,
      this.actions,
      this.shape,
      this.backgroundColor=const Color(0xff313131),
      this.alignment});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:title,
      content: content,
      actions: actions,
      shape: shape,
      backgroundColor: backgroundColor,
    );
  }
}
