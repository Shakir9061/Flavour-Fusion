import 'package:flavour_fusion/Chef/model/chef_Loginmodel.dart';
import 'package:flavour_fusion/Chef/model/view/Home/bottomnavigation.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Chef_LoginController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> chefLogin(Chef_Login_Model chefLogin, BuildContext context) async {
    try {
      // First, check if the email exists in the ChefAuth collection
      QuerySnapshot chefSnapshot = await _firestore
          .collection('ChefAuth')
          .where('email', isEqualTo: chefLogin.email)
          .get();

      if (chefSnapshot.docs.isEmpty) {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'No chef found with this email.',
        );
      }

      // If the email exists in ChefAuth, proceed with Firebase Authentication
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: chefLogin.email!,
        password: chefLogin.password!,
      );

      // If authentication is successful, navigate to the chef's home screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Bottomnavigation_chef()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: CustomText1(text: 'Login Success', size: 18.spMin)),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No chef account found with this email.';
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