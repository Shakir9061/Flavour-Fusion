import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavour_fusion/Chef/model/chef_forgetpass_model.dart';
import 'package:flavour_fusion/User/model/user_forgetmodel.dart';
import 'package:flutter/material.dart';

class User_ForgetPasswordcontroller {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> userresetpass(
      user_forgetpass_model userpassreset, BuildContext context) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('UserAuth')
          .where('email', isEqualTo: userpassreset.email)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        await _auth.sendPasswordResetEmail(email: userpassreset.email!.trim());

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password reset email sent')),
        );
        
        
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No chef account found with this email')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred')),
      );
    }
  }
}
