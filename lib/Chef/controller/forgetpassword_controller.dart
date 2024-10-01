import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavour_fusion/Chef/model/chef_forgetpass_model.dart';
import 'package:flutter/material.dart';

class Chef_ForgetPasswordcontroller {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> chefresetpass(
      chef_forgetpass_model chefpassreset, BuildContext context) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('ChefAuth')
          .where('email', isEqualTo: chefpassreset.email)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        await _auth.sendPasswordResetEmail(email: chefpassreset.email!.trim());

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
