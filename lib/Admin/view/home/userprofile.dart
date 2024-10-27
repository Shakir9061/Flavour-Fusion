import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserprofileAdmin extends StatefulWidget {
  final String? userId;
  const UserprofileAdmin({Key? key, this.userId}) : super(key: key);

  @override
  State<UserprofileAdmin> createState() => _UserprofileAdminState();
}

class _UserprofileAdminState extends State<UserprofileAdmin> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _deleteUser(String userId) async {
    try {
      await _auth.currentUser?.delete();
      await _firestore.collection('UserAuth').doc(userId).delete();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User deleted successfully')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete user: $e')),
      );
    }
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: CustomText1(
              text: label,
              size: 16,
              color: Colors.white70,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: CustomText1(
              text: value,
              size: 16,
              color: Colors.white,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: CustomText1(
          text: 'User Profile',
          size: 18,
          weight: FontWeight.w600,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _firestore.collection('UserAuth').doc(widget.userId).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('User not found'));
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>;

          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 32),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(userData['profileImage'] ?? ''),
                  backgroundColor: Colors.grey[800],
                ),
                SizedBox(height: 24),
                Container(
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.teal.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.teal.withOpacity(0.1),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.person_outline, color: Colors.teal),
                            SizedBox(width: 8),
                            CustomText1(
                              text: 'User Information',
                              size: 18,
                              weight: FontWeight.w600,
                              color: Colors.teal,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _buildInfoRow('Name', userData['name'] ?? 'N/A'),
                            _buildInfoRow('Gender', userData['gender'] ?? 'N/A'),
                            _buildInfoRow('Email', userData['email'] ?? 'N/A'),
                            _buildInfoRow('User ID', widget.userId ?? 'N/A'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[700],
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.grey[900],
                              title: CustomText1(
                                text: "Confirm Delete",
                                size: 20,
                                color: Colors.white,
                              ),
                              content: CustomText1(
                                text: "Are you sure you want to delete this user? This action cannot be undone.",
                                size: 16,
                                color: Colors.white70,
                              ),
                              actions: [
                                TextButton(
                                  child: CustomText1(
                                    text: "Cancel",
                                    size: 16,
                                    color: Colors.teal,
                                  ),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                                TextButton(
                                  child: CustomText1(
                                    text: "Delete",
                                    size: 16,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    _deleteUser(widget.userId!);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: CustomText1(
                        text: 'Delete User Account',
                        size: 16,
                        weight: FontWeight.w600,
                      ),
                    ),
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