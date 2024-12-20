import 'package:flavour_fusion/Chef/model/chef_addrecipe_model.dart';
import 'package:flavour_fusion/Chef/model/view/Recipe%20page/recipepage.dart';
import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_appbar.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Searchbyingredients_chef extends StatefulWidget {
  const Searchbyingredients_chef({super.key});

  @override
  State<Searchbyingredients_chef> createState() => _Searchbyingredients_chefState();
}

class _Searchbyingredients_chefState extends State<Searchbyingredients_chef> {
  final TextEditingController _ingredientController = TextEditingController();
  List<String> _ingredients = [];
  List<Map<String, dynamic>> _searchResults = [];
  bool _isSearching = false;

  void _addIngredient(String ingredient) {
    if (ingredient.isNotEmpty && !_ingredients.contains(ingredient)) {
      setState(() {
        _ingredients.add(ingredient.toLowerCase());
        _ingredientController.clear();
      });
    }
  }

  void _removeIngredient(String ingredient) {
    setState(() {
      _ingredients.remove(ingredient);
    });
  }

  // New function to extract matched ingredients
  String getMatchedIngredients(String allIngredients) {
    List<String> matched = [];
    String lowerIngredients = allIngredients.toLowerCase();
    
    for (String searchIngredient in _ingredients) {
      if (lowerIngredients.contains(searchIngredient)) {
        // Find the complete ingredient name that contains the search term
        List<String> ingredientsList = allIngredients.split(',');
        for (String ingredient in ingredientsList) {
          if (ingredient.trim().toLowerCase().contains(searchIngredient)) {
            matched.add(ingredient.trim());
            break;
          }
        }
      }
    }
    
    return matched.join(', ');
  }

  Future<void> _searchRecipes() async {
    setState(() {
      _isSearching = true;
      _searchResults = [];
    });

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('recipes').get();

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> recipeData = doc.data() as Map<String, dynamic>;
        String ingredients = recipeData['ingredients'].toString().toLowerCase();

        if (_ingredients.every((ingredient) => ingredients.contains(ingredient))) {
          _searchResults.add(recipeData);
        }
      }

      setState(() {
        _isSearching = false;
      });
    } catch (e) {
      print('Error searching recipes: $e');
      setState(() {
        _isSearching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme=Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(title: 'Search by Ingredients', weight: FontWeight.bold,backgroundColor: Theme.of(context).scaffoldBackgroundColor,),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _ingredientController,
                    cursorColor: Colors.teal,
                    style: GoogleFonts.poppins(textStyle: TextStyle(color: ColorScheme.primary)),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Enter an ingredient',
                      hintStyle: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 15.sp, color: ColorScheme.primary)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onFieldSubmitted: _addIngredient,
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _addIngredient(_ingredientController.text),
                  child: Icon(Icons.add,color: Colors.white,),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                ),
              ],
            ),
          ),
          Wrap(
            spacing: 8,
            children: _ingredients.map((ingredient) => Chip(
              label: Text(ingredient),
              onDeleted: () => _removeIngredient(ingredient),
            )).toList(),
          ),
          ElevatedButton(
            onPressed: _searchRecipes,
            child: CustomText1(text: 'Search Recipes', size: 16,color: Colors.white,),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
          ),
          Expanded(
            child: _isSearching
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    var recipe = _searchResults[index];
                    return ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeDetailPage_chef(
                          recipe: Recipe.fromMap(recipe),
                          recipeId: recipe['id'],
                        )));
                      },
                      leading: Image.network(
                        recipe['imageUrls'][0],
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        recipe['title'], 
                        style: TextStyle(color: ColorScheme.primary)
                      ),
                      subtitle: Text(
                        'Matched: ${getMatchedIngredients(recipe['ingredients'])}',
                        style: TextStyle(
                          color: ColorScheme.primary,
                          
                        ),
                      ),
                    );
                  },
                ),
          ),
        ],
      ),
    );
  }
}