import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChefSavedRecipes extends StatefulWidget {
  const ChefSavedRecipes({super.key});

  @override
  State<ChefSavedRecipes> createState() => _ChefSavedRecipesState();
}

class _ChefSavedRecipesState extends State<ChefSavedRecipes> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                 SizedBox(
                      height: 20,
                    ),
                     SizedBox(
                      height: 50,
                      width: 350,
                      child: TextFormField(
                        style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white,fontSize: 15)),
                        cursorColor: Colors.teal,
                        decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search,color: Color.fromARGB(255, 143, 135, 135),),
                          hintText: 'Search Saved Recipes',
                          
                                           contentPadding: EdgeInsets.symmetric(horizontal: 15),
                
                          hintStyle: GoogleFonts.poppins(textStyle: TextStyle(color: Color.fromARGB(255, 143, 135, 135))),
                         focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.teal),borderRadius:BorderRadius.circular(10) ),
                         
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:  8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 140,
                            width: 100,
                            child: Card(
                              color: Colors.black,
                              child: Column(
                                children: [
                                  Image.asset('images/saved.png',fit: BoxFit.fill,),
                                  CustomText1(text: 'Easy Chicken Curry', size: 12,weight: FontWeight.w500,)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}