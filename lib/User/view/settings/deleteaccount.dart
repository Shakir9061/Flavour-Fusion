import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavour_fusion/Chef/model/view/Login/Login.dart';
import 'package:flavour_fusion/User/view/Login/Login.dart';
import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeleteAccount_user extends StatelessWidget {
  const DeleteAccount_user({super.key});

Future<void> deleteAccount() async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('UserAuth').doc(user.uid).delete();
      await user.delete();
    


      print('User account deleted successfully');
    } else {
      print('No user is currently signed in');
    }
  } catch (e) {
    print('Error deleting user account: $e');
  }
}
  @override
  Widget build(BuildContext context) {
        final ColorScheme=Theme.of(context).colorScheme;

    return AlertDialog(
      backgroundColor:  Theme.of(context).cardColor,
 title: CustomText1(text: 'Delete Your Account', size: 18,color: Colors.red,weight: FontWeight.w600,),
 content: Column(
  mainAxisSize: MainAxisSize.min,
   children: [
     CustomText1(text: 'are you sure you want to delete your account.', size: 14.sp,weight: FontWeight.w500,color: ColorScheme.primary,),
      CustomText1(text: 'NB : if you delete your account you won’t be able to recover it.', size: 14.sp,weight: FontWeight.w500,color: ColorScheme.primary,),
   ],
 ),
 actions: [
  TextButton(onPressed: () {
     Navigator.pop(context);
  }, child: CustomText1(text: 'Cancel', size: 15.sp,color: ColorScheme.primary,)),
  TextButton(onPressed: () {
   
      deleteAccount();
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginUser(),));

  }, child: CustomText1(text: 'Ok', size: 15,color: Colors.teal,)),
  
 ],
    );
  }
}