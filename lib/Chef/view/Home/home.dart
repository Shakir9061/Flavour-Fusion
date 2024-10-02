

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flavour_fusion/Chef/view/Home/notifications.dart';
import 'package:flavour_fusion/Chef/view/Recipe%20page/recipepage.dart';
import 'package:flavour_fusion/Chef/view/profile/chefprofile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChefHome extends StatefulWidget {
  const ChefHome({super.key});

  @override
  State<ChefHome> createState() => _ChefHomeState();
}

class _ChefHomeState extends State<ChefHome> {
    String? _profileImageUrl;
  @override
   void initState() {
    super.initState();
    _loadProfileImage();
  }
    Future<void> _loadProfileImage() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('ChefAuth')
          .doc(user.uid)
          .get();
      
      setState(() {
        _profileImageUrl = userData['profileImage'];
      });
    }
  }
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
                            builder: (context) => ChefProfile(),
                          ));
                    },
                    child: CircleAvatar(
                      radius: 23,
                      backgroundImage: _profileImageUrl != null
                          ? NetworkImage(_profileImageUrl!)
                          : null ,
                          child:  _profileImageUrl == null
                          ? Icon(Icons.person)
                          : null,
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
                              builder: (context) => Notificationchef(),
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
  final  double? width;
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RecipePage_chef(),));
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
