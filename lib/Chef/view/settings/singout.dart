import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignOut_chef extends StatelessWidget {
  const SignOut_chef({super.key});

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      backgroundColor:  Color(0xff313131),
 title: CustomText1(text: 'Sign Out', size: 18,weight: FontWeight.w600,),
 content: CustomText1(text: 'Are you sure,you want to sign out ?', size: 14.sp,weight: FontWeight.w500,),
 actions: [
  TextButton(onPressed: () {
    Navigator.pop(context);
  }, child: CustomText1(text: 'Cancel', size: 15,weight: FontWeight.w500,)),
  TextButton(onPressed: () {
        Navigator.pop(context);

  }, child: CustomText1(text: 'Ok', size: 15,color: Colors.teal,)),
  
 ],
    );
  }
}