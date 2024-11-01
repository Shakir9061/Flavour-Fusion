import 'package:flavour_fusion/Chef/model/chef_addrecipe_model.dart';
import 'package:flavour_fusion/Chef/model/view/Recipe%20page/recipepage.dart';
import 'package:flavour_fusion/User/view/Recipes/Recipedetailpageuser.dart';
import 'package:flavour_fusion/widgets/custom_appbar.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CategoryRecipesPage_user extends StatelessWidget {
  final String category;
  final List<Recipe> recipes;

  const CategoryRecipesPage_user({
    Key? key,
    required this.category,
    required this.recipes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ColorScheme=Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(
        
        backgroundColor:Theme.of(context).scaffoldBackgroundColor ,
        title: '$category Recipes',
        weight: FontWeight.bold,
      ),
      body: recipes.isEmpty
          ? Center(child: Text('No recipes found for this category.', style: TextStyle(color: ColorScheme.primary)))
          : ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                Recipe recipe = recipes[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  color: Theme.of(context).cardColor,
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
                        : Icon(Icons.image_not_supported, color:  ColorScheme.primary, size: 60),
                    title: CustomText1(
                      text: recipe.title,
                      size: 16,
                      weight: FontWeight.bold,
                       color:  ColorScheme.primary
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText1(
                          text: 'Time: ${recipe.time}',
                          size: 12,
                           color:  ColorScheme.primary
                        ),
                        CustomText1(
                          text: 'Serves: ${recipe.serve}',
                          size: 12,
                           color:  ColorScheme.primary
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeDetailPage_user(
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