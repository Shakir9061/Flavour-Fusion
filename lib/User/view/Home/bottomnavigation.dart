import 'package:flavour_fusion/User/view/Home/Shoppinglist.dart';
import 'package:flavour_fusion/User/view/Home/home.dart';
import 'package:flavour_fusion/User/view/Home/search.dart';
import 'package:flutter/material.dart';


class Bottomnavigation extends StatefulWidget {
  const Bottomnavigation({super.key});

  @override
  State<Bottomnavigation> createState() => _BottomnavigationState();
}

class _BottomnavigationState extends State<Bottomnavigation> {
  var selectedindex=0;
  List Pages=[Homeuser(),Serach1(),Shoppinglist()];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Pages.elementAt(selectedindex),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home,),label:'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search,),label:'search'),
            BottomNavigationBarItem(icon: Icon(Icons.menu,),label:'Shopping list')
      ],
      backgroundColor: Color(0xff313131),
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