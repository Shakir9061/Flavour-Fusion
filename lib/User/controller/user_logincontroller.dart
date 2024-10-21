import 'package:flavour_fusion/Chef/model/chef_Loginmodel.dart';
import 'package:flavour_fusion/Chef/model/view/Home/bottomnavigation.dart';
import 'package:flavour_fusion/User/model/user_loginmodel.dart';
import 'package:flavour_fusion/User/view/Home/bottomnavigation.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class user_LoginController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> userLogin(user_Login_Model userlogin, BuildContext context) async {
    try {
    
      QuerySnapshot userSnapshot = await _firestore
          .collection('UserAuth')
          .where('email', isEqualTo: userlogin.email)
          .get();

      if (userSnapshot.docs.isEmpty) {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'No chef found with this email.',
        );
      }

      // If the email exists in ChefAuth, proceed with Firebase Authentication
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: userlogin.email!,
        password: userlogin.password!,
      );

     
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Bottomnavigation_user()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: CustomText1(text: 'Login Success', size: 18.spMin)),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user account found with this email.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password.';
          break;
        default:
          errorMessage = 'An error occurred. Please try again.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: CustomText1(text: errorMessage, size: 18.spMin)),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: CustomText1(text: "An unexpected error occurred", size: 18.spMin)),
      );
    }
  }
}