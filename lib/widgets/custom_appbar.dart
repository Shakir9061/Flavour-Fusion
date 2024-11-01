import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final List<Widget>? actions;
  final Widget? leading;
  final double? height;
   final FontWeight? weight;
  final double? size;
  final bool automaticallyImplyLeading;
  CustomAppBar({
    Key? key,
    required this.title,
    this.backgroundColor = Colors.teal,
    this.actions,
    this.leading,
    this.height = kToolbarHeight,
    this.size,
    this.weight,
    this.automaticallyImplyLeading = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ColorScheme=Theme.of(context).colorScheme;
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontWeight: weight,
            color: ColorScheme.primary,
            fontSize: size ?? 20.sp,
          ),
        ),
      ),
      centerTitle: true,
      backgroundColor: backgroundColor,
      actions: actions,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);
}