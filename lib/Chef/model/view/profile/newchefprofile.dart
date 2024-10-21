import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flavour_fusion/Chef/model/view/Home/bottomnavigation.dart';
import 'package:flavour_fusion/Chef/model/view/Recipe%20page/recipepage.dart';
import 'package:flavour_fusion/Chef/model/view/profile/chef_EditProfile.dart';
import 'package:flavour_fusion/Chef/model/view/profile/savedrecipes.dart';
import 'package:flavour_fusion/Chef/model/view/settings/settings.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class chef_profilePage extends StatefulWidget {
  const chef_profilePage({super.key});

  @override
  State<chef_profilePage> createState() => _chef_profilePageState();
}

class _chef_profilePageState extends State<chef_profilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  
  Stream<DocumentSnapshot> _getUserStream() {
    User? user = _auth.currentUser;
    if (user != null) {
      return _firestore.collection('ChefAuth').doc(user.uid).snapshots();
    }
    return Stream.empty();
  }

  List<String> title = ['Theme','Edit Profile', 'Saved', 'Settings','My Recipes'];
  List<Widget> icons = [
    Icon(Icons.contrast, color: Colors.white, size: 24.sp),
    Icon(Icons.edit, color: Colors.white, size: 24.sp),
    Icon(Icons.bookmark, color: Colors.white, size: 24.sp),
    Icon(Icons.settings, color: Colors.white, size: 24.sp),
    Icon(Icons.dining_sharp, color: Colors.white, size: 24.sp)
  ];
  bool status = false;
  bool themeSwitch = false;
  List Pages=[null, Chef_editprofile(), SavedRecipesPage_chef(), SettingsChef(), ChefViewRecipes()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: CustomText1(text: 'My Profile', size: 18.sp),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Bottomnavigation_chef(),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24.sp,
          ),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _getUserStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('No user data found'));
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>;
          String name = userData['name'] ?? 'No name found';
          String email = userData['email'] ?? 'No email found';
          String? profileImageUrl = userData['profileImage'];
          
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          width: 1.sw,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.r),
                            color: Color(0xff1D1B20),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 70.h, bottom: 20.h),
                            child: Column(
                              children: [
                                SizedBox(height: 50.h),
                                CustomText1(
                                  text: name,
                                  size: 15.sp,
                                  weight: FontWeight.w600,
                                ),
                                CustomText1(
                                  text: email,
                                  size: 15.sp,
                                  weight: FontWeight.w400,
                                ),
                                SizedBox(height: 30.h),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: title.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        ListTile(
                                          leading: icons[index],
                                          title: CustomText1(text: title[index], size: 15.sp),
                                          trailing: index == 0
                                              ? Switch(
                                                  value: themeSwitch,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      themeSwitch = val;
                                                    });
                                                  },
                                                )
                                              : Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20.sp),
                                          onTap: () {
                                            if (index == 0) {
                                              setState(() {
                                                themeSwitch = !themeSwitch;
                                              });
                                            } else if (Pages[index] != null) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => Pages[index]!,
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                        Divider(thickness: 0.5),
                                      ],
                                    );
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10.h),
                                  child: SizedBox(
                                    width: 300.w,
                                    height: 50.h,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xff1D1B20),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50),
                                          side: BorderSide(width: 0.2,color: Colors.white)
                                        )
                                      ),
                                      onPressed: () {},
                                      child: CustomText1(text: 'Log Out', size: 18.sp,color: Colors.red,),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          child: CircleAvatar(
                            radius: 60.r,
                            backgroundColor: Color(0xff1D1B20),
                            child: GestureDetector(
                              child: CircleAvatar(
                                radius: 50.r,
                                backgroundImage: profileImageUrl != null
                                    ? NetworkImage(profileImageUrl)
                                    : null,
                                child: profileImageUrl == null
                                    ? Icon(Icons.person_add_alt_1, size: 40.sp)
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}