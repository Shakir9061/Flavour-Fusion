import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavour_fusion/Chef/model/chef_addrecipe_model.dart';
import 'package:flavour_fusion/Chef/model/view/Home/bottomnavigation.dart';
import 'package:flavour_fusion/Chef/model/view/Home/categoryPage.dart';
import 'package:flavour_fusion/Chef/model/view/Recipe%20page/recipepage.dart';
import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_appbar.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flavour_fusion/Chef/model/view/Home/searchbyingredients.dart';
import 'package:flavour_fusion/Chef/model/view/Home/searchbytime.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class Search_chef extends StatefulWidget {
  const Search_chef({Key? key}) : super(key: key);

  @override
  State<Search_chef> createState() => _Search_chefState();
}

class _Search_chefState extends State<Search_chef> {
  final TextEditingController _searchController = TextEditingController();

  Future<List<DocumentSnapshot>> _getRecipeSuggestions(String query) async {
    if (query.isEmpty) {
      return [];
    }

    try {
      String lowercaseQuery = query.toLowerCase();

      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('recipes').get();

      List<DocumentSnapshot> filteredResults = querySnapshot.docs.where((doc) {
        String title =
            (doc.data() as Map<String, dynamic>)['title'] as String? ?? '';
        return title.toLowerCase().contains(lowercaseQuery);
      }).toList();

      return filteredResults;
    } catch (e) {
      print("Error occurred during search: $e");
      return [];
    }
  }
Future<void> _showRecipesByCategory(String category) async {
  try {
    String lowercaseCategory = category.toLowerCase().trim();
    print("Searching for category: $lowercaseCategory"); // Debug print

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('recipes')
        .where('category', isGreaterThanOrEqualTo: lowercaseCategory)
.where('category', isLessThanOrEqualTo: lowercaseCategory + '\uf8ff')
        .get();

    print("Number of recipes found: ${querySnapshot.docs.length}"); // Debug print

    List<Recipe> recipes = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return Recipe.fromMap({...data, 'id': doc.id});
    }).toList();

    if (recipes.isEmpty) {
      print("No recipes found for category: $lowercaseCategory"); // Debug print
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No recipes found for $category.')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryRecipesPage_chef(
          category: category,
          recipes: recipes,
        ),
      ),
    );
  } catch (e) {
    print("Error fetching recipes by category: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to load recipes for $category. Please try again.')),
    );
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
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: CustomText1(text: 'Search', size: 20, weight: FontWeight.w500),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
           
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  height: 50,
                  width: 320,
                  child: TypeAheadField(
                 
           textFieldConfiguration: TextFieldConfiguration(
      controller: _searchController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xff1D1B20),
        hintText: 'Search recipes...',
        hintStyle: TextStyle(
          color: Colors.white54,
          fontSize: 16,
        ),
        prefixIcon: Icon(Icons.search, color: Colors.white),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
         enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.white54, // Border color when not focused
        width: 1,
      ),
    ),
    
    // Border when the text field is focused
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.teal, // Border color when focused
        width: 1,
      ),
    ),
      ),
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    ),
         
                    suggestionsCallback: (pattern) async {
                      return await _getRecipeSuggestions(pattern);
                    },
                    itemBuilder: (context, DocumentSnapshot suggestion) {
                      Map<String, dynamic> data =
                          suggestion.data() as Map<String, dynamic>;
                      return ListTile(
                       
                        tileColor: Colors.black,
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(data['imageUrls'][0]),
                        ),
                        title: CustomText1(
                          text: data['title'] ?? 'No title',
                          size: 15,
                        ),
                        subtitle: CustomText1(
                          text: data['category'] ?? 'No category',
                          size: 12,
                        ),
                      );
                    },
                    onSuggestionSelected: (DocumentSnapshot suggestion) {
                      Map<String, dynamic> data =
                          suggestion.data() as Map<String, dynamic>;
                      Recipe recipe = Recipe.fromMap(data);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeDetailPage_chef(
                            recipe: recipe,
                            recipeId: suggestion.id,
                          ),
                        ),
                      );
                    },
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Searchbyingredients_chef()));
                      },
                      child: Card(
                        color:Color(0xff1D1B20),
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Searchbytimesuser()));
                      },
                      child: Card(
                        color: Color(0xff1D1B20),
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
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    crossAxisCount: 2,
                    childAspectRatio: 1),
                itemBuilder: (context, index) {
                  return GestureDetector(
                     onTap: () => _showRecipesByCategory(categories[index]['name']!),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
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
                            child: CustomText1(
                              text: categories[index]['name']!,
                              size: 18,
                              weight: FontWeight.bold,
                            ),
                          )
                        ],
                      )
                    ),
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