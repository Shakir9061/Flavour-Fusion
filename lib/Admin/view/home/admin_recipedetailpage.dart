import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:video_player/video_player.dart';
import 'package:flavour_fusion/widgets/custom_appbar.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flavour_fusion/Chef/model/chef_addrecipe_model.dart';

class AdminRecipeDetailPage extends StatefulWidget {
  final Recipe recipe;
  final String recipeId;

  const AdminRecipeDetailPage({
    Key? key, 
    required this.recipe, 
    required this.recipeId
  }) : super(key: key);

  @override
  _AdminRecipeDetailPageState createState() => _AdminRecipeDetailPageState();
}

class _AdminRecipeDetailPageState extends State<AdminRecipeDetailPage> {
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
      _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.recipe.videoUrl!)
      );
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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: CustomAppBar(
            title: "Recipe Details",
            weight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMediaCarousel(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRecipeHeader(),
                  const SizedBox(height: 20),
                  _buildRecipeDetails(),
                  const SizedBox(height: 20),
                  _buildChefInfo(),
                ],
              ),
            ),
          ],
        ),
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

  Widget _buildMediaCarousel() {
    List<Widget> mediaItems = [
      ...widget.recipe.imageUrls.map((url) => Image.network(
            url,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[900],
                child: const Icon(Icons.error, color: Colors.white),
              );
            },
          )).toList(),
      if (widget.recipe.videoUrl != null) _buildVideoPlayer(),
    ];

    return CarouselSlider(
      items: mediaItems,
      options: CarouselOptions(
        height: 300,
        viewportFraction: 1.0,
        enlargeCenterPage: false,
        enableInfiniteScroll: mediaItems.length > 1,
      ),
    );
  }

  Widget _buildVideoPlayer() {
    if (_hasVideoError) {
      return Center(
        child: Text('Error loading video', style: TextStyle(color: Colors.white))
      );
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

  Widget _buildChefInfo() {
    return Card(
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chef Information',
              style: TextStyle(
                color: Colors.teal,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Chef ID: ${widget.recipe.chefId}',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}