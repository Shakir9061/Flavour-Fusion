import 'package:flavour_fusion/Chef/model/chef_addrecipe_model.dart';
import 'package:flavour_fusion/Chef/model/view/Recipe%20page/recipepage.dart';
import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_appbar.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Searchbytimesuser extends StatefulWidget {
  const Searchbytimesuser({Key? key}) : super(key: key);

  @override
  State<Searchbytimesuser> createState() => _SearchbyitimesuserState();
}

class _SearchbyitimesuserState extends State<Searchbytimesuser> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];

  Future<void> _searchRecipes() async {
    String searchTime = _searchController.text.trim();
    if (searchTime.isEmpty) return;

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('recipes')
          .where('time', isEqualTo: searchTime)
          .get();

      setState(() {
        _searchResults = querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      });
    } catch (e) {
      print("Error searching recipes: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error searching recipes. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: CustomAppBar(
            title: 'Search by Time',
            weight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: SizedBox(
              height: 50,
              width: 320,
              child: TextFormField(
                controller: _searchController,
                cursorColor: Colors.teal,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(color: Colors.white),
                ),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Enter cooking time (e.g., 30 mins)',
                  hintStyle: GoogleFonts.poppins(
                    textStyle: TextStyle(fontSize: 15.sp, color: Colors.white60),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _searchRecipes,
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.teal)
            ),
            child: CustomText1(text: 'Search', size: 15),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                var recipe = _searchResults[index];
                return ListTile(
                   onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeDetailPage_chef( recipe: Recipe.fromMap(recipe),
                            recipeId: recipe['id'],),));
                    },
                    leading:Image.network(recipe['imageUrls'][0],height: 50,width: 50,fit: BoxFit.cover,),
                  title: Text(
                    recipe['title'] ?? 'Untitled Recipe',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Cooking time: ${recipe['time']}',
                    style: TextStyle(color: Colors.white70),
                  ),
                  // You can add more details or onTap functionality here
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}