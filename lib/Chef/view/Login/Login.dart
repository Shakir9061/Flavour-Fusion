import 'package:flavour_fusion/Chef/controller/chef_Logincontroller.dart';
import 'package:flavour_fusion/Chef/controller/chef_googleauthcontroller.dart';
import 'package:flavour_fusion/Chef/model/chef_Loginmodel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flavour_fusion/Chef/view/Home/bottomnavigation.dart';
import 'package:flavour_fusion/Chef/view/Home/home.dart';
import 'package:flavour_fusion/Chef/view/Login/Forgetpassword.dart';
import 'package:flavour_fusion/main/Register/register.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChefLogin extends StatefulWidget {
  const ChefLogin({super.key});

  @override
  State<ChefLogin> createState() => _ChefLoginState();
}

class _ChefLoginState extends State<ChefLogin> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroler = TextEditingController();
  final chef_LoginController _chef_loginController = chef_LoginController();
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
                        contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.teal, width: 1.w),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
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
                           contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.teal, width: 1.w),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
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
                          padding: EdgeInsets.only(top: 5.h, right: 50.w),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChefForgetPassword(),
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
                          Chef_Login_Model cheflogin=Chef_Login_Model(
                            email: emailcontroller.text,
                            password: passwordcontroler.text,
                          );
                          _chef_loginController.chefLogin(cheflogin, context);
                            emailcontroller.clear();
                            passwordcontroler.clear();
                          
                        }
                          },
                          style: ButtonStyle(
                              shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r))),
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
                                    builder: (context) => RegisterChef(),
                                  ));
                            },
                          text: "Signup",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(color: Color(0xff2420F1))))
                    ])),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 60.h),
                    child: Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          child: CustomText1(text: 'or', size: 12.sp),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 60.h),
                      child: SizedBox(
                          width: 300.w,
                          child: ListTile(
                            onTap: () {
                            // Chef_googleauthcontroller().handleGoogleSignIn(context);
                            },
                            minTileHeight: 50.h,
                            leading: Image.asset('images/google 2.png'),
                            title: Center(
                                child: CustomText1(
                              text: 'Login with Google',
                              size: 15.sp,
                            )),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 0.5.w, color: Colors.white),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
