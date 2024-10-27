import 'dart:io';
import 'package:flavour_fusion/Chef/model/view/Recipe%20page/review.dart';
import 'package:flavour_fusion/Chef/model/view/addrecipe/addrecipe.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:video_player/video_player.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flavour_fusion/widgets/custom_appbar.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flavour_fusion/Chef/model/chef_addrecipe_model.dart';
import 'package:dots_indicator/dots_indicator.dart';


class ChefViewRecipes extends StatefulWidget {
  const ChefViewRecipes({Key? key}) : super(key: key);

  @override
  _ChefViewRecipesState createState() => _ChefViewRecipesState();
}

class _ChefViewRecipesState extends State<ChefViewRecipes> {
  late Stream<QuerySnapshot> _recipesStream;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _recipesStream = FirebaseFirestore.instance
          .collection('recipes')
          .doc(user.uid)
          .collection('recipes_list')
          .orderBy('timestamp', descending: true)
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: CustomText1(text: 'My Recipes', size: 20, weight: FontWeight.w500),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _recipesStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No recipes found'));
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var doc = snapshot.data!.docs[index];
                var recipeData = doc.data() as Map<String, dynamic>;
                Recipe recipe = Recipe.fromMap(recipeData);
                return RecipeCard(
                  recipe: recipe,
                  recipeId: doc.id,
                  onDelete: () => _deleteRecipe(doc.id),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ChefAddRecipes()));
          },
          child: Icon(Icons.add, size: 35, color: Colors.white),
          backgroundColor: Colors.teal,
        ),
      ),
    );
  }

void _deleteRecipe(String recipeId) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    try {
      // Create a batch to perform multiple delete operations
      WriteBatch batch = FirebaseFirestore.instance.batch();

      // Reference to the recipe in chef's personal list
      DocumentReference chefRecipeRef = FirebaseFirestore.instance
          .collection('recipes')
          .doc(user.uid)
          .collection('recipes_list')
          .doc(recipeId);

      // Reference to the recipe in main recipes collection
      DocumentReference mainRecipeRef = FirebaseFirestore.instance
          .collection('recipes')
          .doc(recipeId);

      // Add delete operations to batch
      batch.delete(chefRecipeRef);
      batch.delete(mainRecipeRef);

      // Commit the batch
      await batch.commit();

      // Delete associated reviews if they exist
      // QuerySnapshot reviewsSnapshot = await FirebaseFirestore.instance
      //     .collection('recipes')
      //     .doc(recipeId)
      //     .collection('reviews')
      //     .get();

      // if (reviewsSnapshot.docs.isNotEmpty) {
      //   WriteBatch reviewsBatch = FirebaseFirestore.instance.batch();
      //   for (var doc in reviewsSnapshot.docs) {
      //     reviewsBatch.delete(doc.reference);
      //   }
      //   await reviewsBatch.commit();
      // }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Recipe deleted successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print('Error deleting recipe: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete recipe'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
}

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final String recipeId;
  final VoidCallback onDelete;

  const RecipeCard({
    Key? key,
    required this.recipe,
    required this.recipeId,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        tileColor: Color(0xff1D1B20),
        title: CustomText1(text: recipe.title, size: 14),
        subtitle: CustomText1(text: recipe.category, size: 12),
        leading: recipe.imageUrls.isNotEmpty
            ? Image.network(recipe.imageUrls[0], width: 50, height: 50, fit: BoxFit.cover)
            : Icon(Icons.image, color: Colors.white, size: 50),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.white),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Color(0xff1D1B20),
                  title: CustomText1(text:  "Delete Recipe",size: 16,weight: FontWeight.w600,),
                  content: CustomText1(text:  "Are you sure you want to delete this recipe?",size: 13,),
                  actions: <Widget>[
                    TextButton(
                      child: Text("Cancel"),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    TextButton(
                      child: Text("Delete"),
                      onPressed: () {
                        Navigator.of(context).pop();
                        onDelete();
                      },
                    ),
                  ],
                );
              },
            );
          },
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
  }
}

class RecipeDetailPage_chef extends StatefulWidget {
  final Recipe recipe;
  final String recipeId;

  const RecipeDetailPage_chef({Key? key, required this.recipe, required this.recipeId}) : super(key: key);

  @override
  _RecipeDetailPage_chefState createState() => _RecipeDetailPage_chefState();
}

class _RecipeDetailPage_chefState extends State<RecipeDetailPage_chef> {
  VideoPlayerController? _videoPlayerController;
  bool _isVideoInitialized = false;
  bool _hasVideoError = false;
   int _currentCarouselIndex = 0; 
     Map<String, dynamic>? _chefData;
  bool _isLoadingChef = true;

  @override
  void initState() {
    super.initState();
    if (widget.recipe.videoUrl != null) {
      _initializeVideoPlayer();
    }
    _loadChefData();
  }
 Future<void> _loadChefData() async {
    try {
      setState(() => _isLoadingChef = true);
      
      final chefDoc = await FirebaseFirestore.instance
          .collection('ChefAuth')
          .doc(widget.recipe.chefId)
          .get();

      if (chefDoc.exists) {
        setState(() {
          _chefData = chefDoc.data();
          _isLoadingChef = false;
        });
      } else {
        setState(() {
          _chefData = null;
          _isLoadingChef = false;
        });
      }
    } catch (e) {
      print('Error loading chef data: $e');
      setState(() => _isLoadingChef = false);
    }
  }
  Future<void> _initializeVideoPlayer() async {
    try {
      _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.recipe.videoUrl!));
      await _videoPlayerController!.initialize();
      setState(() {
        _isVideoInitialized = true;
      });
    } catch (e) {
      print('Error initializing video player: $e');
      setState(() {
        _hasVideoError = true;
      });
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: CustomText1(text: 'Recipe Details', size: 20, weight: FontWeight.w500),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
        body: Column(
          children: [
            _buildMediaCarousel(),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: _buildRecipeHeader(),
              ),
            ),
            TabBar(
              dividerHeight: 0,
              labelStyle: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              indicatorColor: Colors.teal,
              unselectedLabelColor: Color(0xffE0DBDB),
              tabs: [
                Tab(text: 'Recipe Details'),
                Tab(text: 'Reviews'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: _buildRecipeDetails(),
                    ),
                  ),
                  ReviewTab_chef(recipeId: widget.recipeId),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaCarousel() {
   List<Widget> mediaItems = [
      ...widget.recipe.imageUrls.map((url) => Container(
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              url,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 300,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[900],
                  child: const Icon(Icons.error, color: Colors.white),
                );
              },
            ),
          )).toList(),
      if (widget.recipe.videoUrl != null) _buildVideoPlayer(),
    ];


    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width ,
          child: CarouselSlider(
            items: mediaItems,
            options: CarouselOptions(
              height: 300,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              enableInfiniteScroll: mediaItems.length > 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentCarouselIndex = index;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 8),
        DotsIndicator(
          dotsCount: mediaItems.length,
          position: _currentCarouselIndex,
          decorator: DotsDecorator(
            size: const Size.square(8.0),
            activeSize: const Size.square(8.0),
            color: Colors.grey.withOpacity(0.3), // Inactive color
            activeColor: Colors.teal, // Active color
            spacing: const EdgeInsets.symmetric(horizontal: 4.0),
          ),
        ),
      ],
    );
  }

  Widget _buildVideoPlayer() {
    if (_hasVideoError) {
      return Center(child: Text('Error loading video', style: TextStyle(color: Colors.white)));
    }
    if (!_isVideoInitialized) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: _videoPlayerController!.value.aspectRatio,
            child:Container(
              width: double.infinity,
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _videoPlayerController!.value.size.width,
                  height: _videoPlayerController!.value.size.height,
                  child: VideoPlayer(_videoPlayerController!),
                ),
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                _videoPlayerController!.value.isPlaying
                    ? _videoPlayerController!.pause()
                    : _videoPlayerController!.play();
              });
            },
            child: Icon(
              _videoPlayerController!.value.isPlaying ? Icons.pause : Icons.play_arrow,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.recipe.title,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Added on: ${widget.recipe.timestamp.toLocal().toString().split(' ')[0]}',
          style: TextStyle(color: Colors.grey[400]),
        ),
      ],
    );
  }

  Widget _buildRecipeDetails() {
    return Card(
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Category', widget.recipe.category),
            _buildDetailRow('Serves', widget.recipe.serve),
            _buildDetailRow('Preparation Time', widget.recipe.time),
            const SizedBox(height: 16),
            _buildDetailSection('Ingredients', widget.recipe.ingredients),
            const SizedBox(height: 16),
            _buildDetailSection('Cooking Method', widget.recipe.cookingMethod),
            const SizedBox(height: 16),
            _buildDetailSection('Tips', widget.recipe.tips),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              color: Colors.teal,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection(String label, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}