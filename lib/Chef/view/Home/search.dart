import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_appbar.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flavour_fusion/Chef/view/Home/searchbyingredients.dart';
import 'package:flavour_fusion/Chef/view/Home/searchbytime.dart';
import 'package:google_fonts/google_fonts.dart';

class Serach_Chef extends StatefulWidget {
  const Serach_Chef({super.key});

  @override
  State<Serach_Chef> createState() => _Serach_ChefState();
}

class _Serach_ChefState extends State<Serach_Chef> {
    final List<Map<String, String>> categories = [
    {"name": "Arabian", "image": "images/arabic.jpg"},
    {"name": "Indian", "image": "images/indian.png"},
    {"name": "Italian", "image": "images/italian.jpg"},
    {"name": "Chinese", "image": "images/chinese.jpg"},
    {"name": "Mexican", "image": "images/mexican 1.png"},
    {"name": "French", "image": "images/french 1.png"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              child: CustomAppBar(
                title: 'Search',
                size: 25,
              ),
            ),
            Center(
              child: Padding(
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
                        hintText: 'Search Recipes',
                        hintStyle: GoogleFonts.poppins(
                            textStyle:
                                TextStyle(fontSize: 13, color: Colors.white60)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 70,
                    width: 120,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Searchbyingredientsuser(),));
                      },
                      child: Card(
                        color: Color(0xff313131),
                        child: Center(
                          child: CustomText1(
                              textAlign: TextAlign.center,
                              text: 'Search By Ingredients',
                              size: 12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    width: 120,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Searchbytimesuser(),));
                      },
                      child: Card(
                        color: Color(0xff313131),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: CustomText1(
                                textAlign: TextAlign.center,
                                text: 'Search By Time',
                                size: 12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 10),
              child: Row(
                children: [
                  CustomText1(
                    text: 'Categories',
                    size: 24,
                    weight: FontWeight.w600,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(
                10
              ),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                
                shrinkWrap: true,
                itemCount: categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 10, crossAxisSpacing: 10, crossAxisCount: 2,childAspectRatio: 1),
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child:Stack(
                      fit: StackFit.expand,
                      children: [
                        Opacity(
                          opacity: 0.75,
                          child: Image.asset(
                            
                            categories[index]["image"]!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 70,
                          left: 70,
                          child:CustomText1(text: categories[index]['name']!, size: 18,weight: FontWeight.bold,))
                      ],
                    )
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
