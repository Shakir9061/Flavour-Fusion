import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavour_fusion/Chef/model/chef_addrecipe_model.dart';
import 'package:flavour_fusion/Chef/view/Recipe%20page/recipepage.dart';
import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SavedRecipesPage_chef extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
     backgroundColor: Colors.black,
      body: userId == null
          ? Center(child: Text('Please log in to view saved recipes'))
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
                  return Center(child: Text('Error: ${favoritesSnapshot.error}'));
                }

                Map<String, dynamic> favorites = favoritesSnapshot.data?.data() as Map<String, dynamic>? ?? {};
                List<String> favoriteRecipeIds = favorites.keys.where((key) => favorites[key] == true).toList();

                if (favoriteRecipeIds.isEmpty) {
                  return Center(child: CustomText1( text:  'No saved recipes yet',size: 15,color: Colors.white,));
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
                      return Center(child: Text('Error: ${recipesSnapshot.error}'));
                    }

                    List<Recipe> savedRecipes = recipesSnapshot.data!.docs
                        .map((doc) => Recipe.fromMap(doc.data() as Map<String, dynamic>))
                        .toList();

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.85, // Adjusted for larger image and title
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,),
                        itemCount: savedRecipes.length,
                        itemBuilder: (context, index) {
                          Recipe recipe = savedRecipes[index];
                          return  GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RecipeDetailPage_chef(recipe: recipe),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: recipe.imageUrls.isNotEmpty
                                        ? Image.network(
                                            recipe.imageUrls[0],
                                            fit: BoxFit.fill,
                                            
                                          )
                                        : Container(
                                            color: Colors.grey[800],
                                            child: Icon(Icons.food_bank, size: 60, color: Colors.white),
                                          ),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  recipe.title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
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