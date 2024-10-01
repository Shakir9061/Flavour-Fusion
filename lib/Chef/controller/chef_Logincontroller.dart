
import 'package:flavour_fusion/Chef/model/chef_Loginmodel.dart';
import 'package:flavour_fusion/Chef/view/Home/bottomnavigation.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class chef_LoginController{
 final FirebaseAuth _auth=FirebaseAuth.instance;
 Future<void>chefLogin(Chef_Login_Model cheflogin,BuildContext context) async{
 try {
   UserCredential userCredential=await _auth.signInWithEmailAndPassword(email: cheflogin.email!, password: cheflogin.password!);
   Navigator.push(context, MaterialPageRoute(builder: (context) => Bottomnavigation_chef(),));
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: CustomText1(text: 'Login Success', size: 18.spMin)));
   return;
 } catch (e) {
     print(e);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: CustomText1(text: "Error", size: 18.spMin))
        );
 }
 }
}