import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_appbar.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flavour_fusion/Chef/view/Home/Shoppinglist.dart';
import 'package:flavour_fusion/Chef/view/Recipe%20page/ingredients.dart';
import 'package:flavour_fusion/Chef/view/Recipe%20page/method.dart';
import 'package:flavour_fusion/Chef/view/Recipe%20page/review.dart';
import 'package:flavour_fusion/Chef/view/Recipe%20page/tips.dart';
import 'package:google_fonts/google_fonts.dart';

class RecipePage_chef extends StatefulWidget {
  const RecipePage_chef({super.key});

  @override
  State<RecipePage_chef> createState() => _RecipePage_chefState();
}

class _RecipePage_chefState extends State<RecipePage_chef> {
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.black,
       body: SafeArea(
         child: Column(
           children: [
             Padding(
               padding: const EdgeInsets.only(left: 10,right: 10),
               child: Image(
                 
                 
                 image: AssetImage('images/arabic.jpg')),
             ),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
               child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   CustomText1(text: 'Korean Fried Chicken', size: 20,color: Colors.white,),
                  IconButton(
                    tooltip: 'shopping list',
                    onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Chef_Shoppinglist(),));
                  }, icon: Icon(Icons.shopping_cart,color: Colors.teal,size: 35,))
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
                       tabAlignment: TabAlignment.start,
                       isScrollable: true,
                       dividerHeight: 0,
                       unselectedLabelColor: Colors.white,
                       indicatorColor: Colors.teal,
                      labelPadding: EdgeInsets.symmetric(horizontal: 30),
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
                       ),
                        Tab(
                         text: 'Review',
                       ),
                      ]),
                    ),
                   Expanded(child: TabBarView(children: [
                     Ingredientstab_chef(),MethodTab_chef(),TipsTab_chef(),ReviewTab_chef()
                   ]))
           ],
         ),
       ),
      ),
    );
  }
}