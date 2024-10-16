import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flavour_fusion/Chef/view/Recipe%20page/recipepage.dart';
import 'package:flavour_fusion/Chef/view/profile/recipelistpage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flavour_fusion/widgets/custom_appbar.dart';
import 'package:flavour_fusion/Chef/view/profile/savedrecipes.dart';
import 'package:flavour_fusion/Chef/view/settings/settings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ChefProfile extends StatefulWidget {
  const ChefProfile({super.key});

  @override
  State<ChefProfile> createState() => _ChefProfileState();
}

class _ChefProfileState extends State<ChefProfile> {
  final _namecontroller = TextEditingController();
  final _biocontroller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  bool _isEditingName = false;
  bool _isEditingBio = false;

  Stream<DocumentSnapshot> _getUserStream() {
    User? user = _auth.currentUser;
    if (user != null) {
      return _firestore.collection('ChefAuth').doc(user.uid).snapshots();
    }
    return Stream.empty();
  }

  Future<void> _updateUserName() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        await _firestore.collection('ChefAuth').doc(user.uid).update({
          'name': _namecontroller.text,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Name updated successfully')),
        );
        setState(() {
          _isEditingName = false;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update name: $e')),
        );
      }
    }
  }

  Future<void> _updateUserBio() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        await _firestore.collection('ChefAuth').doc(user.uid).update({
          'bio': _biocontroller.text,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bio updated successfully')),
        );
        setState(() {
          _isEditingBio = false;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update bio: $e')),
        );
      }
    }
  }

  Future<void> _pickAndUploadImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      User? user = _auth.currentUser;
      if (user != null) {
        try {
          final ref = _storage.ref().child('profile_images/${user.uid}.jpg');
          await ref.putFile(File(pickedFile.path));

          String downloadUrl = await ref.getDownloadURL();

          await _firestore.collection('ChefAuth').doc(user.uid).update({
            'profileImage': downloadUrl,
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profile image updated successfully')),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to upload image: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
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
            _namecontroller.text = userData['name'] ?? 'No name found';
            _biocontroller.text = userData['bio'] ?? '';
            String? profileImageUrl = userData['profileImage'];

            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: CustomAppBar(
                    title: 'Profile',
                    weight: FontWeight.bold,
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SettingsChef(),
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.settings,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: _pickAndUploadImage,
                  child: CircleAvatar(
                    backgroundImage: profileImageUrl != null
                        ? NetworkImage(profileImageUrl)
                        : null,
                    radius: 50,
                    child: profileImageUrl == null
                        ? Icon(Icons.person_add_alt_1, size: 40)
                        : null,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: 350,
                  child: TextFormField(
                    controller: _namecontroller,
                    readOnly: !_isEditingName,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(color: Colors.white),
                    ),
                    cursorColor: Colors.teal,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      hintStyle: GoogleFonts.poppins(
                        textStyle: TextStyle(color: Color(0xffE0DBDB)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            if (_isEditingName) {
                              _updateUserName();
                            } else {
                              _isEditingName = true;
                            }
                          });
                        },
                        icon: Icon(
                          _isEditingName ? Icons.check : Icons.edit,
                          color: Color(0xffE0DBDB),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 350,
                  child: TextFormField(
                    controller: _biocontroller,
                    readOnly: !_isEditingBio,
                    minLines: 1,
                    maxLines: 5,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(color: Colors.white),
                    ),
                    cursorColor: Colors.teal,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      hintStyle: GoogleFonts.poppins(
                        textStyle: TextStyle(color: Color(0xffE0DBDB)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            if (_isEditingBio) {
                              _updateUserBio();
                            } else {
                              _isEditingBio = true;
                            }
                          });
                        },
                        icon: Icon(
                          _isEditingBio ? Icons.check : Icons.edit,
                          color: Color(0xffE0DBDB),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: TabBar(
                    dividerHeight: 0,
                    labelStyle: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    indicatorColor: Colors.teal,
                    unselectedLabelColor: Color(0xffE0DBDB),
                    tabs: [
                      Tab(text: 'Saved Recipes'),
                      Tab(text: 'My Recipes'),
                    
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [SavedRecipesPage_chef(),  ChefViewRecipes(),],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}