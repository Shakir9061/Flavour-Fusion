import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_appbar.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:google_fonts/google_fonts.dart';

class UserRecipeDetailsAdmin extends StatefulWidget {
  const UserRecipeDetailsAdmin({super.key});

  @override
  State<UserRecipeDetailsAdmin> createState() => _UserRecipeDetailsAdminState();
}

class _UserRecipeDetailsAdminState extends State<UserRecipeDetailsAdmin> {
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.black,
       appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: Colors.white,size: 25,)),
       ),
       body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Image(
                
                
                image: AssetImage('images/arabic.jpg')),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,top: 30),
              child: Row(
                children: [
                  CustomText1(text: 'Korean Fried Chicken', size: 20,color: Colors.white,),
                 
                ],
              ),
            ),
             Padding(
                     padding: const EdgeInsets.only(left: 10,top: 10),
                     child: Row(
                       children: [
                         CustomText1(text: 'Serve', size: 18,),
                         SizedBox(
                          width: 15,
                         ),
                         CustomText1(text: ':', size: 18),
                             SizedBox(
                          width: 15,
                         ),
                          CustomText1(text: '4', size: 18,),
                   
                       ],
                     ),
                   ), 
                   Padding(
                     padding: const EdgeInsets.only(left: 10,top: 10),
                     child: Row(
                       children: [
                         CustomText1(text: 'Time', size: 18,),
                         SizedBox(
                          width: 20,
                         ),
                         CustomText1(text: ':', size: 18),
                             SizedBox(
                          width: 15,
                         ),
                          CustomText1(text: '1 Hour', size: 18,),
                   
                       ],
                     ),
                   ), 
                   Padding(
                     padding: const EdgeInsets.only(top: 20),
                     child: TabBar(
                      
                      dividerHeight: 0,
                      unselectedLabelColor: Colors.white,
                      indicatorColor: Colors.teal,
                      labelColor: Colors.teal,
                      labelStyle: GoogleFonts.poppins(textStyle: TextStyle(fontSize:20 )),
                      tabs: [
                      Tab(
                        text: 'Ingredients',
                      ),
                       Tab(
                        text: 'Method',
                      ),
                       Tab(
                        text: 'Tips',
                      )
                     ]),
                   ),
                  
          ],
        ),
       ),
      ),
    );
  }
}