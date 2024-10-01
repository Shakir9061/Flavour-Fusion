import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_appbar.dart';
import 'package:flavour_fusion/Admin/view/home/chefrecipe.dart';
import 'package:flavour_fusion/Admin/view/home/userrecipe.dart';
import 'package:google_fonts/google_fonts.dart';

class Managerecipes extends StatefulWidget {
  const Managerecipes({super.key});

  @override
  State<Managerecipes> createState() => _ManagerecipesState();
}

class _ManagerecipesState extends State<Managerecipes> {
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
         backgroundColor: Colors.black,
        body:  Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
              child: CustomAppBar(title: 'Manage Recipes',weight: FontWeight.bold,)),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TabBar(
                  labelStyle: GoogleFonts.poppins(textStyle: TextStyle()),
                  dividerHeight: 0,
                  unselectedLabelColor: Color(0xffE0DBDB),
                 
                
                  tabs: 
                [
                  Tab(
                    text: 'User recipes',
                  ),
                    Tab(
                    text: 'Chef recipes',
                  )
                ]
                ),
              ),
              Expanded(child: TabBarView(children: [
                UserrecipeAdmin(),ChefrecipeAdmin()
              ]))
          ],
        )
      ),
    );
  }
}