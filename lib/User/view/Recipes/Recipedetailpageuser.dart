
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flavour_fusion/Chef/model/chef_addrecipe_model.dart';
import 'package:flavour_fusion/User/view/Recipes/Reviewuser.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class RecipeDetailPage_user extends StatefulWidget {
  final Recipe recipe;
  final String recipeId;

  const RecipeDetailPage_user({Key? key, required this.recipe, required this.recipeId}) : super(key: key);

  @override
  _RecipeDetailPage_userState createState() => _RecipeDetailPage_userState();
}

class _RecipeDetailPage_userState extends State<RecipeDetailPage_user> {
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
    // _loadChefData();
  }
//  Future<void> _loadChefData() async {
//     try {
//       setState(() => _isLoadingChef = true);
      
//       final chefDoc = await FirebaseFirestore.instance
//           .collection('UserAuth')
//           .doc(widget.recipe.chefId)
//           .get();

//       if (chefDoc.exists) {
//         setState(() {
//           _chefData = chefDoc.data();
//           _isLoadingChef = false;
//         });
//       } else {
//         setState(() {
//           _chefData = null;
//           _isLoadingChef = false;
//         });
//       }
//     } catch (e) {
//       print('Error loading chef data: $e');
//       setState(() => _isLoadingChef = false);
//     }
//   }
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
    final ColorScheme=Theme.of(context).colorScheme;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
        backgroundColor:Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        title: CustomText1(text: 'Recipe Details', size: 20, weight: FontWeight.w500,color: ColorScheme.primary,),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: ColorScheme.primary),
        ),
      ),
        body: Column(
          children: [
            _buildMediaCarousel(),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: _buildRecipeHeader(context),
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
              unselectedLabelColor: ColorScheme.primary,
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
                      child: _buildRecipeDetails(context),
                    ),
                  ),
                  ReviewTab_user(recipeId: widget.recipeId),
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
                  color: Theme.of(context).cardColor,
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

  Widget _buildRecipeHeader(BuildContext context) {
    final ColorScheme=Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.recipe.title,
          style: GoogleFonts.poppins(
            color:ColorScheme.primary ,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Added on: ${widget.recipe.timestamp.toLocal().toString().split(' ')[0]}',
          style: TextStyle(color: Colors.grey[700]),
        ),
      ],
    );
  }

  Widget _buildRecipeDetails(BuildContext context) {
   
    return Card(
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Category', widget.recipe.category,context),
            _buildDetailRow('Serves', widget.recipe.serve,context),
            _buildDetailRow('Preparation Time', widget.recipe.time,context),
            const SizedBox(height: 16),
            _buildDetailSection('Ingredients', widget.recipe.ingredients,context),
            const SizedBox(height: 16),
            _buildDetailSection('Cooking Method', widget.recipe.cookingMethod,context),
            const SizedBox(height: 16),
            _buildDetailSection('Tips', widget.recipe.tips,context),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value,BuildContext context) {
        final ColorScheme=Theme.of(context).colorScheme;

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
              style: TextStyle(color: ColorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection(String label, String content,BuildContext context) {
    final ColorScheme=Theme.of(context).colorScheme;
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
          style: TextStyle(color: ColorScheme.primary),
        ),
      ],
    );
  }
}