import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_appbar.dart';
import 'package:flavour_fusion/Admin/view/home/cheflist.dart';
import 'package:flavour_fusion/Admin/view/home/chefrequest.dart';

class ChefTabBar extends StatefulWidget {
  const ChefTabBar({super.key});

  @override
  State<ChefTabBar> createState() => _ChefTabBarState();
}

class _ChefTabBarState extends State<ChefTabBar> {
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
              child: CustomAppBar(title: 'Chef List',weight: FontWeight.bold,)),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(color:  Color(0xff313131),borderRadius: BorderRadius.circular(10)),
                  
                  child: TabBar(
                    dividerHeight: 0,
                    indicator:BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(10)
                    ) ,
                       labelColor: Colors.white,
                unselectedLabelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.tab,
                    
                    tabs: [
                    Tab(
                      text: 'List',
                    ),
                    Tab(
                      text:'Requests' ,
                    )
                  ]),
                ),
              ),
              Expanded(child: TabBarView(children: [cheflist(),ChefRequest()]))
          ],
        )
      ),
    );
  }
}