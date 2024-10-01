import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flavour_fusion/Chef/view/addrecipe/addrecipe.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MyRecipeChef extends StatefulWidget {
  const MyRecipeChef({super.key});

  @override
  State<MyRecipeChef> createState() => _MyRecipeChefState();
}

class _MyRecipeChefState extends State<MyRecipeChef> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                    height: 20.h,
                  ),
                   SizedBox(
                    height: 50.h,
                    width: 350.w,
                    child: TextFormField(
                      style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white,fontSize: 15.sp)),
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
                height: 100,
              ),
                 
                  
                 
                 
                  
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FloatingActionButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>ChefAddRecipes() ,));
        },child: Icon(Icons.add,size: 35,color: Colors.white,),
        backgroundColor: Colors.teal,
        ),
      ),
    );
  }
}