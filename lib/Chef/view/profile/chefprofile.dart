import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flavour_fusion/widgets/custom_appbar.dart';
import 'package:flavour_fusion/Chef/view/profile/myrecipe.dart';
import 'package:flavour_fusion/Chef/view/profile/savedrecipes.dart';
import 'package:flavour_fusion/Chef/view/settings/settings.dart';
import 'package:google_fonts/google_fonts.dart';

class ChefProfile extends StatefulWidget {
  const ChefProfile({super.key});

  @override
  State<ChefProfile> createState() => _ChefProfileState();
}

class _ChefProfileState extends State<ChefProfile> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
              child: CustomAppBar(
                title: 'Profile',
                weight: FontWeight.bold,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsChef(),));
                        },
                        icon: Icon(
                          Icons.settings,
                          color: Colors.black,
                          size: 30,
                        )),
                  )
                ],
              ),
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
              padding: const EdgeInsets.only(top: 20),
              child: TabBar(
                dividerHeight: 0,
                labelStyle: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.teal,fontWeight: FontWeight.bold,fontSize: 18)),
                indicatorColor: Colors.teal,
                unselectedLabelColor: Color(0xffE0DBDB),
                tabs: [
                Tab(
                  text: 'Saved Recipes',
                ),
                 Tab(
                  text: 'My Recipes',
                )
              ]),
            ),
            Expanded(child: TabBarView(children: [ChefSavedRecipes(),MyRecipeChef()]))
           
          ],
        ),
      ),
    );
  }
}
