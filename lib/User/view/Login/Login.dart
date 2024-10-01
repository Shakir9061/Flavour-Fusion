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
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    backgroundColor: Colors.black, 
    body: SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
           
            children: [
              SizedBox(
                height: 160.h,
              ),
              CustomText1(text: 'Login', size: 36.sp,weight: FontWeight.bold,color: Colors.white,),
                    CustomText1(text: 'Signin to your Account', size: 20.sp,),    
         SizedBox(
                height: 60.h,
              ),
              SizedBox(
              height: 50.h,
              width: 320.w,
              child: TextFormField(cursorColor: Colors.teal,
                style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white)),
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal, width: 1.w),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                    label: CustomText1(text: 'E-mail', size: 13.dg),
                    border: OutlineInputBorder(
                    
                        borderRadius: BorderRadius.circular(10.r))),
                        
              ),
                            ),
               Padding(
                padding:  EdgeInsets.only(top: 20.h),
                child:  SizedBox(
                height: 50.h,
                width: 320.w,
                child: TextFormField(cursorColor: Colors.teal,
                  style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white)),
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal, width: 1.w),
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
                    padding:  EdgeInsets.only(top: 10.h,right: 50.w),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPassword(),));
                      },
                      child: CustomText1(text: 'Forget Password?', size: 12.sp,color: Color(0xff2420F1),))
                  ),
                ],
              ),
              Padding(
                padding:  EdgeInsets.only(top: 30.h),
                child: SizedBox(
                  width: 320.w,
                  child: ElevatedButton(onPressed: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => Bottomnavigation(),));
                  },
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r))),
                    backgroundColor: WidgetStatePropertyAll(Colors.teal)),
                   child:
                   CustomText1(text: 'Login', size: 16.sp)
                   ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(top: 10.h),
                child: Text.rich(TextSpan(
                  children: [
                    TextSpan(
                      text: "Don't have an account?",
                      style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white))
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                      ..onTap=(){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterUser(),));
                      },
                      
                      text: "Signup",
                      style: GoogleFonts.poppins(textStyle: TextStyle(color: Color(0xff2420F1)))
                    )
                  ]
                )),
              ),
              Padding(
                padding:  EdgeInsets.only(left: 20.w,right: 20.w,top: 60.h),
                child: Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 5.w),
                      child: CustomText1(text: 'or', size: 12.sp),
                    ),
                     Expanded(child: Divider()),
                  ],
                ),
              ),
                Padding(
                padding:  EdgeInsets.only(top: 60.h),
                child: SizedBox(
                 
                  width: 300.w,
                  child: ListTile(
                    minTileHeight: 50.h,
                    leading: Image.asset('images/google 2.png'),
                    title: Center(child: CustomText1(text: 'Login with Google', size: 15.sp,)),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.5.w,color: Colors.white),
                      borderRadius: BorderRadius.circular(10.r),),
                  ))
              ),
            
               
            
            ],
          ),
        ),
      ),
    ),
    );
  }
}