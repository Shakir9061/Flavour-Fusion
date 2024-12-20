import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flavour_fusion/widgets/custom_textformfield.dart';
import 'package:image_picker/image_picker.dart';

class user_editprofile extends StatefulWidget {
  const user_editprofile({Key? key}) : super(key: key);

  @override
  State<user_editprofile> createState() => _user_editprofileState();
}

class _user_editprofileState extends State<user_editprofile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _nameController = TextEditingController();
  
  String? _selectedGender;
  final List<String> _genders = ['Male', 'Female'];

  Future<void> _pickAndUploadImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      User? user = _auth.currentUser;
      if (user != null) {
        try {
          final ref = _storage.ref().child('profile_images/${user.uid}.jpg');
          await ref.putFile(File(pickedFile.path));

          String downloadUrl = await ref.getDownloadURL();

          await _firestore.collection('UserAuth').doc(user.uid).update({
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

  
  Stream<DocumentSnapshot> _getUserStream() {
    User? user = _auth.currentUser;
    if (user != null) {
      return _firestore.collection('UserAuth').doc(user.uid).snapshots();
    }
    return Stream.empty();
  }

  Future<void> _updateUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
       
        await _firestore.collection('UserAuth').doc(user.uid).update({
          'name': _nameController.text,
          
          'gender': _selectedGender,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
        final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        title: CustomText1(text: 'Edit Profile', size: 20, weight: FontWeight.w500,color: colorScheme.primary,),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: colorScheme.primary),
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
          _nameController.text = userData['name'] ?? 'No name found';
        
          _selectedGender = userData['gender'] ?? _genders[0];
          String? profileImageUrl = userData['profileImage'];

          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 35),
                GestureDetector(
                  onTap: _pickAndUploadImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: profileImageUrl != null
                        ? NetworkImage(profileImageUrl)
                        : null,
                    child: profileImageUrl == null
                        ? Icon(Icons.person_add_alt_1, size: 40)
                        : null,
                  ),
                ),
                SizedBox(height: 25),
                CustomTextformfield(
                  width: 330,
                  controller: _nameController,
                  style: TextStyle(color: colorScheme.primary),
                  
                  
                ),
                SizedBox(height: 20),
                Container(
                  width: 330,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color:  Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(10),
                                       border: Border.all(color: Colors.white,width: 0.2),

                   
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedGender,
                      isExpanded: true,
                      dropdownColor: Theme.of(context).cardColor,
                      style: TextStyle(color: colorScheme.primary),
                      items: _genders.map((String gender) {
                        return DropdownMenuItem<String>(
                          value: gender,
                          child: Text(gender),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedGender = newValue;
                        });
                      },
                    ),
                  ),
                ),
               
                SizedBox(height: 30),
                SizedBox(
                  width: 330,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _updateUserData,
                    child: CustomText1(text: 'Submit', size: 18),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}