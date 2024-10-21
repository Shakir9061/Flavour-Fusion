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
        await FirebaseFirestore.instance
            .collection('recipes')
            .doc(user.uid)
            .collection('recipes_list')
            .doc(recipeId)
            .delete();
               await FirebaseFirestore.instance
            .collection('recipes')
            .doc(recipeId)
            .delete();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Recipe deleted successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete recipe')),
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

  const RecipeDetailPage_chef({Key? key, required this.recipe,required  this. recipeId}) : super(key: key);

  @override
  _RecipeDetailPage_chefState createState() => _RecipeDetailPage_chefState();
}

class _RecipeDetailPage_chefState extends State<RecipeDetailPage_chef> {
  VideoPlayerController? _videoPlayerController;
  bool _isVideoInitialized = false;
  bool _hasVideoError = false;

  @override
  void initState() {
    super.initState();
    if (widget.recipe.videoUrl != null) {
      _initializeVideoPlayer();
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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: CustomAppBar(
              title: widget.recipe.title,
              weight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          children: [
              _buildMediaCarousel(),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TabBar(
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
              ),
            Expanded(child: TabBarView(children: [_buildRecipeDetails(),ReviewTab_chef(recipeId: widget.recipeId!,)]))
          ],
        )
      ),
    );
  }

  Widget _buildMediaCarousel() {
    List<Widget> mediaItems = [
      ...widget.recipe.imageUrls.map((url) => Image.network(url, fit: BoxFit.cover)).toList(),
      if (widget.recipe.videoUrl != null)
        _buildVideoPlayer(),
    ];

    return CarouselSlider(
      items: mediaItems,
      options: CarouselOptions(
        height: 300,
        
        viewportFraction: 1.0,
        enlargeCenterPage: false,
      ),
    );
  }

  Widget _buildVideoPlayer() {
    if (_hasVideoError) {
      return Center(child: Text('Error loading video', style: TextStyle(color: Colors.white)));
    }
    if (!_isVideoInitialized) {
      return Center(child: CircularProgressIndicator());
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: _videoPlayerController!.value.aspectRatio,
          child: VideoPlayer(_videoPlayerController!),
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
    );
  }

  Widget _buildRecipeDetails() {
    return Padding(
      padding: const EdgeInsets.only(left: 30,top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText1(text: 'Category: ${widget.recipe.category}', size: 18),
          SizedBox(height: 10),
          CustomText1(text: 'Ingredients:', size: 18),
          Text(widget.recipe.ingredients, style: TextStyle(color: Colors.white)),
          SizedBox(height: 10),
          CustomText1(text: 'Serve: ${widget.recipe.serve}', size: 18),
          CustomText1(text: 'Time: ${widget.recipe.time}', size: 18),
          SizedBox(height: 10),
          CustomText1(text: 'Cooking Method:', size: 18),
          Text(widget.recipe.cookingMethod, style: TextStyle(color: Colors.white)),
          SizedBox(height: 10),
          CustomText1(text: 'Tips:', size: 18),
          Text(widget.recipe.tips, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
 
}