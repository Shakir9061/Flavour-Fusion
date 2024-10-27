import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flavour_fusion/Chef/model/view/Home/Shoppinglist.dart';
import 'package:flavour_fusion/Chef/model/view/Home/home.dart';
import 'package:flavour_fusion/Chef/model/view/Home/search.dart';

class Bottomnavigation_chef extends StatefulWidget {
  const Bottomnavigation_chef({super.key});

  @override
  State<Bottomnavigation_chef> createState() => _Bottomnavigation_chefState();
}

class _Bottomnavigation_chefState extends State<Bottomnavigation_chef> {
  var selectedindex=0;
  List Pages=[ChefHome(),Search_chef(),Chef_Shoppinglist()];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Pages.elementAt(selectedindex),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home,),label:'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search,),label:'search'),
            BottomNavigationBarItem(icon: Icon(Icons.menu,),label:'Shopping list')
      ],
      backgroundColor: Color(0xff1D1B20),
      selectedItemColor:Colors.teal,
      unselectedItemColor:Colors.white ,
      currentIndex: selectedindex,
      type: BottomNavigationBarType.fixed,
      
      onTap: (value) {
        setState(() {
          selectedindex=value;
        });
      },
      ),
    );
  
  }
}