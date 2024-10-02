import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavour_fusion/Chef/model/chef_Register_Model.dart';
import 'package:flavour_fusion/Chef/view/Login/Login.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class chef_RegisterController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> chefRegister(
      Chef_Register_Model chefregister, BuildContext context) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: chefregister.email!, password: chefregister.password!);
      await _firestore
          .collection('ChefAuth')
          .doc(userCredential.user!.uid)
          .set({
        "name": chefregister.name,
        "email": chefregister.email,
        "password": chefregister.password,
        "gender": chefregister.gender,
        "bio":chefregister.bio,
        "uid": userCredential.user!.uid
      });

      Navigator.push(context, MaterialPageRoute(builder: (context) => ChefLogin(),));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: CustomText1(text: "Registration success", size: 18.spMin))
        );
        return;
    } catch (e) {
       print(e);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: CustomText1(text: "Error ", size: 18.spMin))
        );
        return;
    }
  }
}
