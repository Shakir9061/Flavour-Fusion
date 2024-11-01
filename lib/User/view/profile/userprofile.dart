import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavour_fusion/Chef/model/view/Home/bottomnavigation.dart';
import 'package:flavour_fusion/Chef/model/view/Recipe%20page/recipepage.dart';
import 'package:flavour_fusion/Chef/model/view/profile/chef_EditProfile.dart';
import 'package:flavour_fusion/Chef/model/view/profile/savedrecipes.dart';
import 'package:flavour_fusion/Chef/model/view/settings/settings.dart';
import 'package:flavour_fusion/User/view/Home/bottomnavigation.dart';
import 'package:flavour_fusion/User/view/profile/savedrecipes.dart';
import 'package:flavour_fusion/User/view/profile/usereditprofile.dart';
import 'package:flavour_fusion/User/view/settings/settings.dart';
import 'package:flavour_fusion/common/theme/themeprovider.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:provider/provider.dart';

class Userprofile extends StatefulWidget {
  const Userprofile({super.key});

  @override
  State<Userprofile> createState() => _UserprofileState();
}

class _UserprofileState extends State<Userprofile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot> _getUserStream() {
    User? user = _auth.currentUser;
    if (user != null) {
      return _firestore.collection('UserAuth').doc(user.uid).snapshots();
    }
    return Stream.empty();
  }

  List<String> title = ['Theme', 'Edit Profile', 'Saved', 'Settings', ];
  List<IconData> icons = [
    Icons.contrast,
    Icons.edit,
    Icons.bookmark,
    Icons.settings,
   
  ];
  List Pages = [null, user_editprofile(), SavedRecipeuser(), SettingsUser()];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: CustomText1(
          text: 'My Profile',
          size: 18.sp,
          color: colorScheme.onSurface,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Bottomnavigation_user(),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: colorScheme.onSurface,
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
                            color: Theme.of(context).cardColor,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 70.h, bottom: 20.h),
                            child: Column(
                              children: [
                                SizedBox(height: 50.h),
                                CustomText1(
                                  text: name,
                                  size: 15.sp,
                                  color: colorScheme.onSurface,
                                  weight: FontWeight.w600,
                                ),
                                CustomText1(
                                  text: email,
                                  size: 15.sp,
                                  color: colorScheme.onSurface,
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
                                          leading: Icon(
                                            icons[index],
                                            color: colorScheme.onSurface,
                                            size: 24.sp,
                                          ),
                                          title: CustomText1(
                                            text: title[index],
                                            size: 15.sp,
                                            color: colorScheme.onSurface,
                                          ),
                                          trailing: index == 0
                                              ? Switch(
                                                  value: themeProvider.isDarkMode,
                                                  onChanged: (val) {
                                                    themeProvider.toggleTheme();
                                                  },
                                                )
                                              : Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: colorScheme.onSurface,
                                                  size: 20.sp,
                                                ),
                                          onTap: () {
                                            if (index == 0) {
                                              themeProvider.toggleTheme();
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
                                        Divider(
                                          thickness: 0.5,
                                          color: Theme.of(context).dividerColor,
                                        ),
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
                                        backgroundColor: Theme.of(context).cardColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50),
                                          side: BorderSide(
                                            width: 0.2,
                                            color: colorScheme.onSurface,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: CustomText1(
                                        text: 'Log Out',
                                        size: 18.sp,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          child: CircleAvatar(
                            radius: 60.r,
                            backgroundColor: Theme.of(context).cardColor,
                            child: GestureDetector(
                              child: CircleAvatar(
                                radius: 50.r,
                                backgroundImage: profileImageUrl != null
                                    ? NetworkImage(profileImageUrl)
                                    : null,
                                child: profileImageUrl == null
                                    ? Icon(Icons.person_add_alt_1,
                                        size: 40.sp,
                                        color: colorScheme.onSurface)
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