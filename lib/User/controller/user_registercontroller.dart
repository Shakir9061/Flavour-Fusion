import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavour_fusion/Chef/model/chef_Register_Model.dart';
import 'package:flavour_fusion/Chef/model/view/Login/Login.dart';
import 'package:flavour_fusion/User/model/user_registermodel.dart';
import 'package:flavour_fusion/User/view/Login/Login.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class user_RegisterController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> userRegister(
      user_Register_Model userregister, BuildContext context) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: userregister.email!, password: userregister.password!);
      await _firestore
          .collection('UserAuth')
          .doc(userCredential.user!.uid)
          .set({
        "name": userregister.name,
        "email": userregister.email,
        "password": userregister.password,
        "gender": userregister.gender,
        
        "uid": userCredential.user!.uid
      });

      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginUser(),));
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
