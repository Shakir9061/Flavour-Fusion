import 'package:flavour_fusion/Chef/model/chef_addrecipe_model.dart';
import 'package:flavour_fusion/Chef/model/view/Recipe%20page/recipepage.dart';
import 'package:flavour_fusion/widgets/custom_appbar.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CategoryRecipesPage_chef extends StatelessWidget {
  final String category;
  final List<Recipe> recipes;

  const CategoryRecipesPage_chef({
    Key? key,
    required this.category,
    required this.recipes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20)
          ),
          child: CustomAppBar(
            title: '$category Recipes',
            weight: FontWeight.bold,
          ),
        ),
      ),
      body: recipes.isEmpty
          ? Center(child: Text('No recipes found for this category.', style: TextStyle(color: Colors.white)))
          : ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                Recipe recipe = recipes[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  color: Color(0xff313131),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(8),
                    leading: recipe.imageUrls.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              recipe.imageUrls[0],
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Icon(Icons.image_not_supported, color: Colors.grey, size: 60),
                    title: CustomText1(
                      text: recipe.title,
                      size: 16,
                      weight: FontWeight.bold,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText1(
                          text: 'Time: ${recipe.time}',
                          size: 12,
                        ),
                        CustomText1(
                          text: 'Serves: ${recipe.serve}',
                          size: 12,
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeDetailPage_chef(
                            recipe: recipe,
                            recipeId: recipe.id!,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}