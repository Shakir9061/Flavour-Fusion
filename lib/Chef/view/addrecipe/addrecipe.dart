import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_appbar.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChefAddRecipes extends StatefulWidget {
  const ChefAddRecipes({super.key});

  @override
  State<ChefAddRecipes> createState() => _ChefAddRecipesState();
}

class _ChefAddRecipesState extends State<ChefAddRecipes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: ClipRRect(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
          child: CustomAppBar(title: 'Add Recipe',weight: FontWeight.bold,actions: [
            IconButton(onPressed: () {
              
            }, icon: Icon(Icons.close,size: 35,color: Colors.black,)),
             IconButton(onPressed: () {
              
            }, icon: Icon(Icons.check,size: 35,color: Colors.black,)),

          ],))),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Column(
            
            children: [
             
              Container(
                height: 200.h,
                width: 360.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xff313131)),
              ),
              SizedBox(height: 20.h,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTextField('Title',width: 200),
                    Column(
                      children: [
                        _buildTextField('Category',width: 130),
                        
                      ],
                    ),
                  ],
                ),

              ),
              SizedBox(height: 10.h,),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTextField('Ingredients',width: 200,maxLines: 10,height: 110),
                      Column(
                        children: [
                          _buildTextField('Serve',width: 130),
                           SizedBox(height: 10.h,),
                            _buildTextField('Time',width: 130),
                        ],
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CustomText1(text: 'Cooking Method', size: 20),
                  ],
                ),
                
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  children: [
                    _buildTextField('',height: 120,maxLines: 10,width: 350),
                  ],
                ),
              ),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CustomText1(text: 'Tips', size: 20),
                  ],
                ),
                
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  children: [
                    _buildTextField('',height: 120,maxLines: 10,width: 350),
                  ],
                ),
              )
            
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildTextField(String label, {int maxLines=1,double height=50,double width=100} ) {
    return SizedBox(
      height: height,
      width: width,
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xff313131),
          labelText: label,
          labelStyle: GoogleFonts.poppins(textStyle: TextStyle(color: Color(0xffE0DBDB))),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        maxLines: maxLines,
      ),
    );
  }
}
