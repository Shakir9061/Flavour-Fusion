import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_appbar.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flavour_fusion/Admin/view/home/userprofile.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body:  Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
            child: CustomAppBar(title: 'User List',weight: FontWeight.bold,)),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SizedBox(
                height: 60,
                width: 350,
                child: ListTile(
                  tileColor: Color(0xff313131),
                  leading: CircleAvatar(),
                  title: CustomText1(text: 'User', size: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserprofileAdmin(),));
                  },
                ),
              ),
            )
        ],
      )
    );
  }
}