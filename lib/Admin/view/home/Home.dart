import 'package:flavour_fusion/Admin/view/home/AddNotification_Admin.dart';
import 'package:flavour_fusion/Admin/view/home/cheflist.dart';
import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_appbar.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flavour_fusion/Admin/view/home/Reports.dart';
import 'package:flavour_fusion/Admin/view/home/managerecipes.dart';
import 'package:flavour_fusion/Admin/view/home/userlist.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  List<String> text=['User List','Chef List','Manage Recipes','Reports'];
  var pages=[UserList(),cheflist(),Managerecipes(),Reports()];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
         ClipRRect(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
            child: CustomAppBar(title: 'Home',
            automaticallyImplyLeading: false,
            actions: [Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>AddnotificationAdmin() ,));
                },
                icon: Icon(Icons.notifications,size: 35,color: Color.fromARGB(255, 236, 178, 4),)),
            )],
            weight: FontWeight.bold,)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: ListView.builder(
                itemCount: 4,
                  shrinkWrap: true,    
                itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 30.0,left: 20,right: 20),
                  child: SizedBox(
                    height: 60,
                 
                    child: ListTile(
                      
                      title:CustomText1(text: text[index], size: 18) ,
                      tileColor: Color(0xff313131),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      
                      onTap: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context) => pages[index],));
                      },
                    ),
                  ),
                );
              },),
            ),
          )
        ],
      ),
    );
  }
}