import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavour_fusion/Admin/view/home/admin_recipedetailpage.dart';
import 'package:flavour_fusion/Chef/model/chef_addrecipe_model.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Managerecipes extends StatefulWidget {
  const Managerecipes({super.key});

  @override
  State<Managerecipes> createState() => _ManagerecipesState();
}

class _ManagerecipesState extends State<Managerecipes> {
  String _searchQuery = '';
  String _selectedCategory = 'all';
  List<String> _categories = ['all'];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('recipes').get();
    final Set<String> categories = {'all'};
    
    for (var doc in snapshot.docs) {
      categories.add(((doc.data() as Map<String, dynamic>)['category'] ?? '').toLowerCase());
    }
    
    setState(() {
      _categories = categories.toList()..sort();
    });
  }

  Future<void> _deleteRecipe(String recipeId) async {
    try {
      await FirebaseFirestore.instance.collection('recipes').doc(recipeId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Recipe deleted successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error deleting recipe: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
     appBar: AppBar(
  title: Text('Manage Recipes',
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  centerTitle: true,
  backgroundColor: Colors.black,
  automaticallyImplyLeading: false,
  leading: IconButton(onPressed: () {
    Navigator.pop(context);
  }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
),
body: Column(
        children: [
          _buildSearchAndFilter(),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('recipes').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      'No recipes found',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                var filteredDocs = snapshot.data!.docs.where((doc) {
                  Recipe recipe = Recipe.fromMap(doc);
                  bool matchesSearch = recipe.title.toLowerCase().contains(_searchQuery.toLowerCase());
                   bool matchesCategory = _selectedCategory == 'all' || 
                                      recipe.category.toLowerCase() == _selectedCategory;
                  return matchesSearch && matchesCategory;
                }).toList();

                return ListView.builder(
                  itemCount: filteredDocs.length,
                  itemBuilder: (context, index) {
                    try {
                      DocumentSnapshot document = filteredDocs[index];
                      Recipe recipe = Recipe.fromMap(document);

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        child: Card(
                          color: Colors.grey[900],
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.grey[700],
                              child: recipe.imageUrls.isNotEmpty
                                  ? ClipOval(
                                      child: Image.network(
                                        recipe.imageUrls[0],
                                        fit: BoxFit.cover,
                                        width: 50,
                                        height: 50,
                                        errorBuilder: (context, error, stackTrace) {
                                          return const Icon(
                                            Icons.restaurant,
                                            color: Colors.white,
                                          );
                                        },
                                      ),
                                    )
                                  : const Icon(
                                      Icons.restaurant,
                                      color: Colors.white,
                                    ),
                            ),
                            title: Text(
                              recipe.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                   recipe.category[0].toUpperCase() + 
                                  recipe.category.substring(1).toLowerCase(),
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Chef ID: ${recipe.chefId}',
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red[300]),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        backgroundColor: Colors.grey[900],
                                        title: Text('Delete Recipe?', 
                                          style: TextStyle(color: Colors.white)),
                                        content: Text('This action cannot be undone.',
                                          style: TextStyle(color: Colors.grey[300])),
                                        actions: [
                                          TextButton(
                                            child: Text('Cancel'),
                                            onPressed: () => Navigator.pop(context),
                                          ),
                                          TextButton(
                                            child: Text('Delete', 
                                              style: TextStyle(color: Colors.red)),
                                            onPressed: () {
                                              _deleteRecipe(recipe.id);
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.visibility, color: Colors.teal),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AdminRecipeDetailPage(
                                          recipe: recipe,
                                          recipeId: recipe.id,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AdminRecipeDetailPage(
                                    recipe: recipe,
                                    recipeId: recipe.id,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    } catch (e, stackTrace) {
                      print('Error rendering recipe: $e');
                      print('Stack trace: $stackTrace');
                      return const SizedBox.shrink();
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.grey[900],
      child: Column(
        children: [
          TextField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search recipes...',
              hintStyle: TextStyle(color: Colors.grey[400]),
              prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
              filled: true,
              fillColor: Colors.grey[800],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
          SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _categories.map((category) {
                bool isSelected = _selectedCategory == category;
                return Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text( category[0].toUpperCase() + category.substring(1)),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = selected ? category : 'All';
                      });
                    },
                    selectedColor: Colors.teal,
                    checkmarkColor: Colors.white,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[400],
                    ),
                    backgroundColor: Colors.grey[800],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}