import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavour_fusion/Chef/model/chef_addrecipe_model.dart';
import 'package:flavour_fusion/Chef/model/view/Recipe%20page/recipepage.dart';
import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter/widgets.dart';

class SavedRecipesPage_chef extends StatelessWidget {
  Future<void> _removeFromSaved(String userId, String recipeId) async {
    await FirebaseFirestore.instance
        .collection('userFavorites')
        .doc(userId)
        .update({recipeId: false});
  }

  @override
  Widget build(BuildContext context) {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: CustomText1(text: 'Saved Recipes', size: 20, weight: FontWeight.w500),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: userId == null
          ? Center(child: CustomText1(text: 'Please log in to view saved recipes', size: 15, color: Colors.white))
          : StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('userFavorites')
                  .doc(userId)
                  .snapshots(),
              builder: (context, favoritesSnapshot) {
                if (favoritesSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (favoritesSnapshot.hasError) {
                  return Center(child: CustomText1(text: 'Error: ${favoritesSnapshot.error}', size: 15, color: Colors.white));
                }

                if (!favoritesSnapshot.hasData || favoritesSnapshot.data == null) {
                  return Center(child: CustomText1(text: 'No data available', size: 15, color: Colors.white));
                }

                Map<String, dynamic> favorites = favoritesSnapshot.data!.data() as Map<String, dynamic>? ?? {};
                List<String> favoriteRecipeIds = favorites.keys.where((key) => favorites[key] == true).toList();

                if (favoriteRecipeIds.isEmpty) {
                  return Center(child: CustomText1(text: 'No saved recipes yet', size: 15, color: Colors.white));
                }

                return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('recipes')
                      .where(FieldPath.documentId, whereIn: favoriteRecipeIds)
                      .snapshots(),
                  builder: (context, recipesSnapshot) {
                    if (recipesSnapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (recipesSnapshot.hasError) {
                      return Center(child: CustomText1(text: 'Error: ${recipesSnapshot.error}', size: 15, color: Colors.white));
                    }

                    if (!recipesSnapshot.hasData || recipesSnapshot.data == null) {
                      return Center(child: CustomText1(text: 'No recipes available', size: 15, color: Colors.white));
                    }

                    List<Recipe> savedRecipes = recipesSnapshot.data!.docs
                        .map((doc) => Recipe.fromMap(doc.data() as Map<String, dynamic>))
                        .toList();

                    return Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: ListView.builder(
                        itemCount: savedRecipes.length,
                        itemBuilder: (context, index) {
                          Recipe recipe = savedRecipes[index];
                          String recipeId = recipesSnapshot.data!.docs[index].id;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                            child: ListTile(
                              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10) ),
                              tileColor: Color(0xff1D1B20),
                              title: Text(
                                recipe.title,
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                recipe.category,
                                style: TextStyle(color: Colors.white70),
                              ),
                              leading: recipe.imageUrls.isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        recipe.imageUrls[0],
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            width: 50,
                                            height: 50,
                                            color: Colors.grey[800],
                                            child: Icon(Icons.error, size: 30, color: Colors.white),
                                          );
                                        },
                                      ),
                                    )
                                  : Container(
                                      width: 50,
                                      height: 50,
                                      color: Colors.grey[800],
                                      child: Icon(Icons.food_bank, size: 30, color: Colors.white),
                                    ),
                              trailing: IconButton(
                                icon: Icon(Icons.delete, color: Colors.white),
                                onPressed: () => _removeFromSaved(userId!, recipeId),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RecipeDetailPage_chef(recipe: recipe, recipeId: recipeId),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}