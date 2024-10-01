import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeleteAccount_chef extends StatelessWidget {
  const DeleteAccount_chef({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor:  Color(0xff313131),
 title: CustomText1(text: 'Delete Your Account', size: 18,color: Colors.red,weight: FontWeight.w600,),
 content: Column(
  mainAxisSize: MainAxisSize.min,
   children: [
     CustomText1(text: 'are you sure you want to delete your account.', size: 14.sp,weight: FontWeight.w500,),
      CustomText1(text: 'NB : if you delete your account you won’t be able to recover it.', size: 14.sp,weight: FontWeight.w500,),
   ],
 ),
 actions: [
  TextButton(onPressed: () {
    Navigator.pop(context);
  }, child: CustomText1(text: 'Cancel', size: 15.sp,)),
  TextButton(onPressed: () {
        Navigator.pop(context);

  }, child: CustomText1(text: 'Ok', size: 15,color: Colors.teal,)),
  
 ],
    );
  }
}