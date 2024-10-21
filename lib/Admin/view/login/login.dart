import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flavour_fusion/Admin/view/home/Home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final TextEditingController emailcontroller=TextEditingController();
  final TextEditingController passwordcontroller=TextEditingController();
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _formkey = GlobalKey<FormState>();

  Future<void> adminLogin() async {
    try {
      String email = emailcontroller.text.trim();
      String password = passwordcontroller.text.trim();

      // Query the AdminAuth collection
      QuerySnapshot querySnapshot = await _firestore
          .collection('AdminAuth')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Check if the password matches
        String storedPassword = querySnapshot.docs.first['password'];
        if (password == storedPassword) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdminHome()),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: CustomText1(text: 'Login Success', size: 18.spMin)),
          );
          return;
        }
      }

      // If we reach here, authentication failed
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: CustomText1(text: "Invalid email or password", size: 18.spMin)),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: CustomText1(text: "Error: $e", size: 18.spMin)),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
       body: SafeArea(
      child: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 160),
                  child: CustomText1(text: 'Login', size: 36,weight: FontWeight.bold,color: Colors.white,)
                ),
                      CustomText1(text: 'Signin to your Account', size: 20,),    
          
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child:  SizedBox(
                  height: 50,
                  width: 320,
                  child: TextFormField(
                    controller: emailcontroller,
                     validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field cannot be empty';
                          }
                          return null;
                        },
                    cursorColor: Colors.teal,
                    style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white)),
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
                        label: CustomText1(text: 'E-mail', size: 13),
                        border: OutlineInputBorder(
                        
                            borderRadius: BorderRadius.circular(10))),
                            
                  ),
                ),
                ),
                 Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child:  SizedBox(
                  height: 50,
                  width: 320,
                  child: TextFormField(
                    controller: passwordcontroller,
                     validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field cannot be empty';
                          }
                          return null;
                        },
                    cursorColor: Colors.teal,
                    style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white)),
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
                        label: CustomText1(text: 'Password', size: 13),
                        border: OutlineInputBorder(
                        
                            borderRadius: BorderRadius.circular(10))),
                            
                  ),
                ),
                ),
               
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: SizedBox(
                    width: 300,
                    child: ElevatedButton(onPressed: () {
                      if(_formkey.currentState!.validate()){
                        adminLogin();
                      }
                    },
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      backgroundColor: WidgetStatePropertyAll(Colors.teal)),
                     child:
                     CustomText1(text: 'Login', size: 16)
                     ),
                  ),
                ),
             
             
                 
              
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }
}