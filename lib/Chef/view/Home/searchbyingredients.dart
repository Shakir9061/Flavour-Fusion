import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_appbar.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Searchbyingredientsuser extends StatefulWidget {
  const Searchbyingredientsuser({super.key});

  @override
  State<Searchbyingredientsuser> createState() => _SearchbyingredientsuserState();
}

class _SearchbyingredientsuserState extends State<Searchbyingredientsuser> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: ClipRRect(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
          child: CustomAppBar(title: 'Search',weight: FontWeight.bold,))),
          body: Center(
            child: Column(
            
              children: [
                 Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: SizedBox(
                    height: 50,
                    width: 320,
                    child: TextFormField(
                      cursorColor: Colors.teal,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(color: Colors.white)),
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Search Ingredients',
                          hintStyle: GoogleFonts.poppins(
                              textStyle:
                                  TextStyle(fontSize: 15.sp, color: Colors.white60)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: ElevatedButton(onPressed: () {
                        
                      }, child: CustomText1(text: 'Search', size: 16),
                      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.teal)),
                      ),
                    ),
                  ),
                ),
                
              ],
            ),
          ),
    );
  }
}