
import 'package:flavour_fusion/User/view/Login/Login.dart';
import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flavour_fusion/Admin/view/login/login.dart';
import 'package:flavour_fusion/Chef/view/Login/Login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 40.h,
            ),
            CustomText1(
              text: 'Welcome !',
              size: 36.sp,
              weight: FontWeight.bold,
              color: Colors.white,
            ),
            SizedBox(
              height: 5.h,
            ),
            CustomText1(
              text: 'choose your role ',
              size: 16.sp,
            ),
            SizedBox(
              height: 40.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 160.h,
                  width: 150.w,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginUser(),
                          ));
                    },
                    child: Card(
                      color: Colors.white,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15.h,
                          ),
                          Image(image: AssetImage('images/userimg.png')),
                          SizedBox(
                            height: 10.h,
                          ),
                          CustomText1(
                            text: 'User',
                            size: 16.sp,
                            color: Colors.black,
                            weight: FontWeight.w600,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 160.h,
                  width: 150.w,
                  child: InkWell(
                    onTap: () {
                       Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChefLogin(),
                          ));
                    },
                    child: Card(
                      color: Colors.white,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15.h,
                          ),
                          Image(image: AssetImage('images/chef.png')),
                          SizedBox(
                            height: 10.h,
                          ),
                          CustomText1(
                            text: 'Chef',
                            size: 16.sp,
                            color: Colors.black,
                            weight: FontWeight.w600,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
             SizedBox(
              height: 30.h,
            ),
            CustomText1(
              text: 'For Admin Only',
              size: 20.sp,
              color: Colors.white,
              weight: FontWeight.bold,
            ),
            Padding(
              padding:  EdgeInsets.only(top: 20.h),
              child: SizedBox(
                height: 160.h,
                width: 150.w,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminLogin(),
                        ));
                  },
                  child: Card(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(top: 15.h),
                          child: Image(image: AssetImage('images/admin.png')),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(top: 10.h),
                          child: CustomText1(
                            text: 'Admin',
                            size: 16.sp,
                            color: Colors.black,
                            weight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
