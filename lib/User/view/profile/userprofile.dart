import 'package:flavour_fusion/User/view/profile/savedrecipes.dart';
import 'package:flavour_fusion/User/view/settings/settings.dart';
import 'package:flavour_fusion/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:google_fonts/google_fonts.dart';

class Userprofile extends StatefulWidget {
  const Userprofile({super.key});

  @override
  State<Userprofile> createState() => _UserprofileState();
}

class _UserprofileState extends State<Userprofile> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            CustomAppBar(
              title: 'Profile',
              weight: FontWeight.bold,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsUser(),));
                      },
                      icon: Icon(
                        Icons.settings,
                        color: Colors.black,
                        size: 30,
                      )),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            CircleAvatar(
              radius: 50,
              child: Text('M',style: TextStyle(fontSize: 30),),
              
            ),
             SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              width: 350,
              child: TextFormField(
                style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white)),
                cursorColor: Colors.teal,
                decoration: InputDecoration(
                
                  hintText: 'User',
                                   contentPadding: EdgeInsets.symmetric(horizontal: 15),
        
                  hintStyle: GoogleFonts.poppins(textStyle: TextStyle(color: Color(0xffE0DBDB))),
                 focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.teal),borderRadius:BorderRadius.circular(10) ),
                  suffixIcon: IconButton(onPressed: () {
                    
                  }, icon: Icon(Icons.edit,color: Color(0xffE0DBDB))),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
              ),
            ),
             SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 50,
              width: 350,
              child: TextFormField(
                style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white)),
                cursorColor: Colors.teal,
                decoration: InputDecoration(
                
                  hintText: 'Bio',
                                   contentPadding: EdgeInsets.symmetric(horizontal: 15),
        
                  hintStyle: GoogleFonts.poppins(textStyle: TextStyle(color: Color(0xffE0DBDB))),
                 focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.teal),borderRadius:BorderRadius.circular(10) ),
                  suffixIcon: IconButton(onPressed: () {
                    
                  }, icon: Icon(Icons.edit,color: Color(0xffE0DBDB))),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20,left: 20),
              child: Row(
                children: [
                  TabBar(
                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                    dividerHeight: 0,
                    labelStyle: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.teal,fontWeight: FontWeight.bold,fontSize: 18)),
                    indicatorColor: Colors.teal,
                    unselectedLabelColor: Color(0xffE0DBDB),
                    tabs: [
                    Tab(
                      text: 'Saved Recipes',
                    ),
                    
                  ]),
                ],
              ),
            ),
            Expanded(child: TabBarView(children: [SavedRecipesuser()]))
           
          ],
        ),
      ),
    );
  }
}
