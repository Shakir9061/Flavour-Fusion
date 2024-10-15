import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:video_player/video_player.dart';
import 'package:flavour_fusion/Chef/model/chef_addrecipe_model.dart';

class RecipeDetailPage extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailPage({Key? key, required this.recipe}) : super(key: key);

  @override
  _RecipeDetailPageState createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  VideoPlayerController? _videoPlayerController;
  bool _isPlaying = false;
  int _currentSlideIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.recipe.videoUrl != null) {
      _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.recipe.videoUrl!))
        ..initialize().then((_) {
          setState(() {});
        });
      _videoPlayerController!.addListener(() {
        setState(() {
          _isPlaying = _videoPlayerController!.value.isPlaying;
        });
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
      appBar: AppBar(
        title: Text(widget.recipe.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
              ),
              items: [
                ...widget.recipe.imageUrls.map((url) => Image.network(url, fit: BoxFit.cover)),
                if (widget.recipe.videoUrl != null && _videoPlayerController != null)
                  _videoPlayerController!.value.isInitialized
                      ? Stack(
                          alignment: Alignment.center,
                          children: [
                            AspectRatio(
                              aspectRatio: _videoPlayerController!.value.aspectRatio,
                              child: VideoPlayer(_videoPlayerController!),
                            ),
                            IconButton(
                              icon: Icon(
                                _isPlaying ? Icons.pause : Icons.play_arrow,
                                size: 50.0,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (_isPlaying) {
                                    _videoPlayerController!.pause();
                                  } else {
                                    _videoPlayerController!.play();
                                  }
                                });
                              },
                            ),
                          ],
                        )
                      : const Center(child: CircularProgressIndicator()),
              ],
            ),
            if (_videoPlayerController != null && _videoPlayerController!.value.isInitialized)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: VideoProgressIndicator(
                  _videoPlayerController!,
                  allowScrubbing: true,
                  colors: VideoProgressColors(
                    playedColor: Theme.of(context).primaryColor,
                    bufferedColor: Theme.of(context).primaryColor.withOpacity(0.5),
                    backgroundColor: Colors.grey,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Category: ${widget.recipe.category}'),
                  const SizedBox(height: 8),
                  Text('Serves: ${widget.recipe.serve}'),
                  const SizedBox(height: 8),
                  Text('Time: ${widget.recipe.time}'),
                  const SizedBox(height: 16),
                  const Text('Ingredients:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.recipe.ingredients),
                  const SizedBox(height: 16),
                  const Text('Cooking Method:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.recipe.cookingMethod),
                  const SizedBox(height: 16),
                  const Text('Tips:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(widget.recipe.tips),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}