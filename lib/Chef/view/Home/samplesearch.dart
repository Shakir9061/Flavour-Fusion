import 'package:flavour_fusion/Chef/model/chef_addrecipe_model.dart';
import 'package:flavour_fusion/Chef/view/Home/bottomnavigation.dart';
import 'package:flavour_fusion/Chef/view/Recipe%20page/recipepage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeSearchPage_chef extends StatefulWidget {
  @override
  _RecipeSearchPage_chefState createState() => _RecipeSearchPage_chefState();
}

class _RecipeSearchPage_chefState extends State<RecipeSearchPage_chef> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Recipes'),
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Bottomnavigation_chef(),));
        }, icon: Icon(Icons.arrow_back)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search recipes',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: _searchRecipes,
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _errorMessage.isNotEmpty
                    ? Center(child: Text(_errorMessage))
                    : _searchResults.isEmpty
                        ? Center(child: Text('No recipes found'))
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ListView.builder(
                              itemCount: _searchResults.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot recipeDoc =
                                    _searchResults[index];
                                Map<String, dynamic> data =
                                    recipeDoc.data() as Map<String, dynamic>;
                                    Recipe recipe = Recipe.fromMap(data);
                                return Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(width: 1)),
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(data['imageUrls'][0]),
                                      radius: 30,
                                    ),
                                    title: Text(data['title'] ?? 'No title'),
                                    subtitle:
                                        Text(data['category'] ?? 'No category'),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RecipeDetailPage_chef(
                                                    recipe: recipe),
                                          ));
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
