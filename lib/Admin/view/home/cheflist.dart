import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flavour_fusion/Admin/view/home/chefprofile.dart';

class cheflist extends StatefulWidget {
  const cheflist({super.key});

  @override
  State<cheflist> createState() => _cheflistState();
}

class _cheflistState extends State<cheflist> {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
       appBar: AppBar(
        backgroundColor: Colors.black,
        title: CustomText1(
          text: 'Chefs List',
          size: 18,
          weight: FontWeight.w600,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body:    StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('ChefAuth').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No Chef found'));
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var userData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: ListTile(
                    tileColor: Color(0xff1D1B20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(userData['profileImage'] ?? ''),
                      radius: 25,
                    ),
                    title: CustomText1(
                      text: userData['name'] ?? 'Unknown User',
                      size: 16,
                      weight: FontWeight.w500,
                    ),
                    subtitle: CustomText1(
                      text: userData['email'] ?? 'No email',
                      size: 14,
                      color: Colors.grey,
                    ),
                    trailing: IconButton(onPressed: () {
                       Navigator.push(
                         context,
                        MaterialPageRoute(
                           builder: (context) => ChefprofileAdmin(userId: snapshot.data!.docs[index].id),
                         ),
                       );
                    }, icon: Icon(Icons.arrow_forward_ios,color: Colors.white70,)),
                  
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}