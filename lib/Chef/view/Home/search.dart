import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavour_fusion/Chef/model/chef_addrecipe_model.dart';
import 'package:flavour_fusion/Chef/view/Home/bottomnavigation.dart';
import 'package:flavour_fusion/Chef/view/Recipe%20page/recipepage.dart';
import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_appbar.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flavour_fusion/Chef/view/Home/searchbyingredients.dart';
import 'package:flavour_fusion/Chef/view/Home/searchbytime.dart';
import 'package:google_fonts/google_fonts.dart';

class Search_chef extends StatefulWidget {
  const Search_chef({super.key});

  @override
  State<Search_chef> createState() => _Search_chefState();
}

class _Search_chefState extends State<Search_chef> {
   final TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> _searchResults = [];
  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _searchRecipes(String query) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      if (query.isEmpty) {
        // If the query is empty, fetch all recipes
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('recipes')
            .limit(20) // Limit to 20 results for performance
            .get();

        setState(() {
          _searchResults = querySnapshot.docs;
          _isLoading = false;
        });
        return;
      }

      // Convert the query to lowercase for case-insensitive comparison
      String lowercaseQuery = query.toLowerCase();

      print("Searching for: $lowercaseQuery"); // Debug print

      // Fetch all recipes and filter in the app
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('recipes').get();

      List<DocumentSnapshot> filteredResults = querySnapshot.docs.where((doc) {
        // Assuming 'title' is the field name in your Firestore documents
        String title =
            (doc.data() as Map<String, dynamic>)['title'] as String? ?? '';
        return title.toLowerCase().contains(lowercaseQuery);
      }).toList();

      print("Query returned ${filteredResults.length} results"); // Debug print

      setState(() {
        _searchResults = filteredResults;
        _isLoading = false;
      });
    } catch (e) {
      print("Error occurred during search: $e"); // Debug print
      setState(() {
        _errorMessage = 'An error occurred while searching. Please try again.';
        _isLoading = false;
      });
    }
  }
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
                automaticallyImplyLeading: false,
                leading: IconButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Bottomnavigation_chef(),));
                }, icon: Icon(Icons.arrow_back)),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: SizedBox(
                  height: 50,
                  width: 320,
                  child: TextFormField(
                    controller: _searchController,
                    cursorColor: Colors.teal,
                    onChanged: _searchRecipes,
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
             Container(
              height: 160, // Fixed height as requested
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _errorMessage.isNotEmpty
                      ? Center(child: Text(_errorMessage))
                      : _searchResults.isEmpty
                          ? Center(child: Text('No recipes found'))
                          : Padding(
                            padding: const EdgeInsets.symmetric(horizontal:10.0),
                            child: ListView.builder(
                                itemCount: _searchResults.length,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot recipeDoc =
                                      _searchResults[index];
                                  Map<String, dynamic> data =
                                      recipeDoc.data() as Map<String, dynamic>;
                                  Recipe recipe = Recipe.fromMap(data);
                                  return ListTile(
                                    tileColor: Colors.grey[800],
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(width: 1)),
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(data['imageUrls'][0]),
                                      radius: 30,
                                    ),
                                    title: CustomText1(text:  data['title'] ?? 'No title',size: 15,),
                                    subtitle:
                                       CustomText1(text:  data['category'] ?? 'No category',size: 12,),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RecipeDetailPage_chef(
                                                    recipe: recipe),
                                          ));
                                    },
                                  );
                                },
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
   @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
