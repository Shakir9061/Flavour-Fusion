import 'package:flavour_fusion/User/controller/user_logincontroller.dart';
import 'package:flavour_fusion/User/model/user_loginmodel.dart';
import 'package:flavour_fusion/User/view/Home/bottomnavigation.dart';
import 'package:flavour_fusion/User/view/Login/Forgetpassword.dart';
import 'package:flavour_fusion/User/view/Register/register.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({super.key});

  @override
  State<LoginUser> createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroler = TextEditingController();
  final user_LoginController user_loginController=user_LoginController();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 160.h,
                  ),
                  CustomText1(
                    text: 'Login',
                    size: 36.sp,
                    weight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  CustomText1(
                    text: 'Signin to your Account',
                    size: 20.sp,
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  SizedBox(
                  
                    width: 320.w,
                    child: TextFormField(
                      controller: emailcontroller,
                       validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field cannot be empty';
                          }
                          return null;
                        },
                      cursorColor: Colors.teal,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(color: Colors.white)),
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.teal, width: 1.w),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,),borderRadius: BorderRadius.circular(10)),
                          label: CustomText1(text: 'E-mail', size: 13.dg),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: SizedBox(
                    
                      width: 320.w,
                      child: TextFormField(
                        controller: passwordcontroler,
                         validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field cannot be empty';
                          }
                          return null;
                        },
                        cursorColor: Colors.teal,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(color: Colors.white)),
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.teal, width: 1.w),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                             errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red),borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white,),borderRadius: BorderRadius.circular(10)),
                            label: CustomText1(text: 'Password', size: 13.sp),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r))),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 10.h, right: 50.w),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UserForgetPassword(),
                                    ));
                              },
                              child: CustomText1(
                                text: 'Forget Password?',
                                size: 12.sp,
                                color: Color(0xff2420F1),
                              ))),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.h),
                    child: SizedBox(
                      width: 320.w,
                      child: ElevatedButton(
                          onPressed: () {
                            if(_formkey.currentState!.validate()){
                          user_Login_Model userlogin=user_Login_Model(
                            email: emailcontroller.text,
                            password: passwordcontroler.text,
                          );
                          user_loginController.userLogin(userlogin, context);
                            emailcontroller.clear();
                            passwordcontroler.clear();
                          
                        }
                          },
                          style: ButtonStyle(
                              shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.r))),
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.teal)),
                          child: CustomText1(text: 'Login', size: 16.sp)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Text.rich(TextSpan(children: [
                      TextSpan(
                          text: "Don't have an account?",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(color: Colors.white))),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterUser(),
                                  ));
                            },
                          text: "Signup",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(color: Color(0xff2420F1))))
                    ])),
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
