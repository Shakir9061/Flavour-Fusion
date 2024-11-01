import 'package:flavour_fusion/User/view/Home/Shoppinglist.dart';
import 'package:flavour_fusion/User/view/Home/home.dart';
import 'package:flavour_fusion/User/view/Home/search.dart';
import 'package:flutter/material.dart';


class Bottomnavigation_user extends StatefulWidget {
  const Bottomnavigation_user({super.key});

  @override
  State<Bottomnavigation_user> createState() => _Bottomnavigation_userState();
}

class _Bottomnavigation_userState extends State<Bottomnavigation_user> {
  var selectedindex=0;
  List Pages=[Homeuser(),search_user(),Shoppinglist_user()];
  @override
  Widget build(BuildContext context) {
    final ColorScheme=Theme.of(context).colorScheme;
    return  Scaffold(
      body:Pages.elementAt(selectedindex),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home,),label:'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search,),label:'search'),
            BottomNavigationBarItem(icon: Icon(Icons.menu,),label:'Shopping list')
      ],
      backgroundColor: Theme.of(context).cardColor,
      selectedItemColor:Colors.teal,
      unselectedItemColor:ColorScheme.primary,
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