import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavour_fusion/Chef/model/view/Home/bottomnavigation.dart';
import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_appbar.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Chef_Shoppinglist extends StatefulWidget {
  const Chef_Shoppinglist({super.key});

  @override
  State<Chef_Shoppinglist> createState() => _Chef_ShoppinglistState();
}

class _Chef_ShoppinglistState extends State<Chef_Shoppinglist> {
  final TextEditingController _itemController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _addItem(String item) async {
    if (item.isNotEmpty) {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore
            .collection('shopping_lists')
            .doc(user.uid)
            .collection('items')
            .add({
          'name': item,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    }
  }

  void _showAddItemDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Item'),
          content: TextField(
            controller: _itemController,
            decoration: InputDecoration(hintText: "Enter item name"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                _addItem(_itemController.text);
                _itemController.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              child: CustomAppBar(
                title: 'Shopping List',
                weight: FontWeight.bold,
                automaticallyImplyLeading: false,
                leading: IconButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Bottomnavigation_chef(),));
                }, icon: Icon(Icons.arrow_back)),
              )),
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
            stream: _firestore
                .collection('shopping_lists')
                .doc(_auth.currentUser?.uid)
                .collection('items').orderBy('timestamp',descending: true).snapshots(),
                builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty){
                  return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_cart,
                        size: 60, color: Color.fromARGB(255, 224, 219, 219)),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomText1(
                      text: 'Shopping List is Empty',
                      size: 20,
                      weight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomText1(
                          text:
                              '  Start your shopping list by adding ingredients using the add button below.',
                          size: 12,textAlign: TextAlign.center,),
                    ),
                  ],
                ),
              );
                 }
                 return Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 10),
                   child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var item = snapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ListTile(
                          tileColor: Colors.grey[800],
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          title: Text(item['name'], style:const TextStyle(color:Colors.white)),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              item.reference.delete();
                            },
                          ),
                        ),
                      );
                    },
                                   ),
                 );
                },
          )
              
              ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: () {
            _showAddItemDialog();
          },
          child: Icon(
            Icons.add,
            size: 35,
            color: Colors.white,
          ),
          backgroundColor: Colors.teal,
        ),
      ),
    );
  }
}
