import 'package:flavour_fusion/User/view/Home/notifications.dart';
import 'package:flavour_fusion/User/view/Recipe%20page/recipepage.dart';
import 'package:flavour_fusion/User/view/profile/userprofile.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class Homeuser extends StatefulWidget {
  const Homeuser({super.key});

  @override
  State<Homeuser> createState() => _HomeuserState();
}

class _HomeuserState extends State<Homeuser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size(0, 80),
        child: ClipRRect(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
          child: AppBar(
            backgroundColor: Colors.teal,
            automaticallyImplyLeading: false,
            centerTitle: true,
            toolbarHeight: 80,
            title: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Userprofile(),
                          ));
                    },
                    child: CircleAvatar(
                      radius: 23,
                    ),
                  ),
                  SizedBox(
                      height: 45.h,
                      width: 250.w,
                      child: TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: 'Search',
                            hintStyle: TextStyle(),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r))),
                      )),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationUser(),
                            ));
                      },
                      icon: Icon(
                        Icons.notifications,
                        size: 35.w,
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             SectionTitle('Recommended Recipes'),
              RecommendedRecipe(200,200),
              
              SectionTitle('Popular recipes'),
              RecommendedRecipe(150, 150),
              SectionTitle('Chef Recipes'),
              RecommendedRecipe(150, 150)
            ],
          ),
        ),
      ),
    );
  }
}

class RecommendedRecipe extends StatelessWidget {
  
  final double? height;
  final double? width;
   RecommendedRecipe(this.height,this.width);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        height: height!.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RecipePage(),));
                  },
                  child: Container(
                    width: width!.w,
                    
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: CustomText1(
        text: title,
        size: 19.spMin,
        weight: FontWeight.bold,
      ),
    );
  }
}
