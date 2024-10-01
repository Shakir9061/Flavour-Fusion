import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flavour_fusion/common/onboardingscreen/introscreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Splash1 extends StatefulWidget {
  const Splash1({super.key});

  @override
  State<Splash1> createState() => _Splash1State();
}

class _Splash1State extends State<Splash1> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 5), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Introscreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150.h,
              width: 150.w,
              child: Image(
               fit: BoxFit.fill,
                image: AssetImage('images/Splash1.png')),
            ),
           
            CustomText1(text: 'Flavour Fusion', size: 30.sp,color: Colors.black,weight: FontWeight.bold,),
            CustomText1(text: 'Elevate Your Taste Experience  ', size: 20.sp,color: Color(0xff9C6512),)
          ],
        )
      ),
    );
  }
}
