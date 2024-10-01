import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flavour_fusion/common/welcomescreen/welcome.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Introscreen extends StatefulWidget {
  const Introscreen({super.key});

  @override
  State<Introscreen> createState() => _IntroscreenState();
}

class _IntroscreenState extends State<Introscreen> {
  PageController Controller = PageController();
  bool OnLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(
          onPageChanged: (index) {
            setState(() {
              OnLastPage = (index == 1);
            });
          },
          controller: Controller,
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 130.h,
                  ),
                  Image.asset('images/welcome1.png'),
                  SizedBox(
                    height: 5.h,
                  ),
                  CustomText1(
                    text: 'Discover Mouthwatering Recipes',
                    size: 24.sp,
                    textAlign: TextAlign.center,
                    weight: FontWeight.bold,
                  
                  ),
                  Padding(
                    padding:
                         EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
                    child: CustomText1(
                      textAlign: TextAlign.center,
                      text:
                          ' Explore a vast collection of delectable recipes from around the world.',
                      size: 16.sp,
                      
                    ),
                  ),
                ],
              ),
              color: Colors.black,
            ),
            Container(
              color: Colors.black,
              child: Column(
                children: [
                  SizedBox(
                    height: 130.h,
                  ),
                  Image.asset(
                    'images/welcome2.png',
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomText1(
                    text: 'Smart Grocery Lists',
                    textAlign: TextAlign.center,
                    size: 24.sp,
                    weight: FontWeight.bold,
                  ),
                  Padding(
                    padding:
                         EdgeInsets.only(top: 20.h, left: 10.w, right: 10.w),
                    child: CustomText1(
                      text:
                          'Add ingredients from your chosen recipes to your shopping list.',
                      size: 16.sp,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
            alignment: Alignment(0, 0.60),
            child: SmoothPageIndicator(
              controller: Controller, count: 2,
              // onDotClicked: (index) {
              //   setState(() {

              //     Controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
              //     Controller.previousPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn );
              //   });
              // },
            )),
        Align(
            alignment: Alignment(-1, 0.85),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // if(!OnLastPage)
                Padding(
                  padding:  EdgeInsets.only(left: 20.w),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        Controller.jumpToPage(1);
                      });
                    },
                    child: CustomText1(
                      text: 'Skip',
                      size: 16.sp,
                      color: Color(0xff9C6512),
                    ),
                  ),
                ),
                OnLastPage
                    ? Padding(
                        padding:  EdgeInsets.only(right: 20.w),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomePage(),));
                          },
                          child: Container(
                            height: 45.h,
                            width: 150.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: Color(0xff313131)),
                            child: Center(
                              child: CustomText1(
                                text: 'Get Started',
                                size: 16.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding:  EdgeInsets.only(right: 20.w),
                        child: IconButton(
                            onPressed: () {
                              Controller.nextPage(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeIn);
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xffE0DBDB),
                            )),
                      )
              ],
            )),
      ]),
    );
  }
}
