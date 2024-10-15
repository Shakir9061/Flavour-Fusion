import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flavour_fusion/Chef/model/chef_addrecipe_model.dart';
import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_appbar.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class ChefAddRecipes extends StatefulWidget {
  const ChefAddRecipes({super.key});

  @override
  State<ChefAddRecipes> createState() => _ChefAddRecipesState();
}

class _ChefAddRecipesState extends State<ChefAddRecipes> {
   final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _categoryController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _serveController = TextEditingController();
  final _timeController = TextEditingController();
  final _cookingMethodController = TextEditingController();
  final _tipsController = TextEditingController();
  
  List<File> _images = [];
  File? _video;
  VideoPlayerController? _videoPlayerController;
  bool _isVideoInitialized = false;
  String _videoErrorMessage = '';

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  Future<void> _pickVideo() async {
    final pickedFile = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _video = File(pickedFile.path);
        _isVideoInitialized = false;
        _videoErrorMessage = '';
      });
      _initializeVideoPlayer();
    }
  }

  void _initializeVideoPlayer() {
    if (_video == null) return;
    
    _videoPlayerController = VideoPlayerController.file(_video!)
      ..initialize().then((_) {
        setState(() {
          _isVideoInitialized = true;
        });
        _videoPlayerController!.play();
      }).catchError((error) {
        setState(() {
          _videoErrorMessage = 'Error initializing video: $error';
        });
        print(_videoErrorMessage);
      });

    _videoPlayerController!.addListener(() {
      setState(() {}); // Trigger rebuild when video state changes
    });
  }

  Future<List<String>> _uploadImages() async {
    List<String> imageUrls = [];
    for (var image in _images) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = FirebaseStorage.instance.ref().child('recipe_images/$fileName');
      await ref.putFile(image);
      String downloadUrl = await ref.getDownloadURL();
      imageUrls.add(downloadUrl);
    }
    return imageUrls;
  }

  Future<String?> _uploadVideo() async {
    if (_video == null) return null;
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance.ref().child('recipe_videos/$fileName');
    await ref.putFile(_video!);
    return await ref.getDownloadURL();
  }

  Future<void> _saveRecipe() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Show loading indicator
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Center(child: CircularProgressIndicator());
          },
        );
         final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw 'User not authenticated';
      }
      String userId = user.uid;


        List<String> imageUrls = await _uploadImages();
        String? videoUrl = await _uploadVideo();

        Recipe newRecipe = Recipe(
          chefId: userId,
          title: _titleController.text,
          category: _categoryController.text,
          ingredients: _ingredientsController.text,
          serve: _serveController.text,
          time: _timeController.text,
          cookingMethod: _cookingMethodController.text,
          tips: _tipsController.text,
          imageUrls: imageUrls,
          videoUrl: videoUrl,
          timestamp: DateTime.now(),
        );
            DocumentReference mainDocRef = await FirebaseFirestore.instance
          .collection('recipes')
          .add(newRecipe.toMap());
           await mainDocRef.update({'id': mainDocRef.id});

        DocumentReference docRef= await FirebaseFirestore.instance.collection('recipes').doc(userId).collection('recipes_list').add(newRecipe.toMap());
  
        // Update the Firestore document to include the id field
        await docRef.update({'id': docRef.id});
        // Hide loading indicator
        Navigator.of(context).pop();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Recipe added successfully!')),
        );
        Navigator.pop(context); // Go back to previous screen
      } catch (e) {
        // Hide loading indicator
        Navigator.of(context).pop();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding recipe: $e')),
        );
      }
    }
  }

 
  Widget _buildMediaItem(dynamic item) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: item is File && item.path.toLowerCase().endsWith('.mp4')
          ? _buildVideoPlayer()
          : item is File
              ? Image.file(item, fit: BoxFit.cover)
              : Container(child: Text('Unsupported media type')),
    );
  }

  Widget _buildVideoPlayer() {
    if (!_isVideoInitialized) {
      return Center(child: CircularProgressIndicator());
    } else if (_videoErrorMessage.isNotEmpty) {
      return Center(child: Text(_videoErrorMessage, style: TextStyle(color: Colors.red)));
    } else {
      return AspectRatio(
        aspectRatio: _videoPlayerController!.value.aspectRatio,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            VideoPlayer(_videoPlayerController!),
            VideoProgressIndicator(_videoPlayerController!, allowScrubbing: true),
            _PlayPauseOverlay(controller: _videoPlayerController!),
          ],
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: ClipRRect(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
          child: CustomAppBar(title: 'Add Recipe',weight: FontWeight.bold,actions: [
          
             IconButton(onPressed: () {
              _saveRecipe();
            }, icon: Icon(Icons.check,size: 35,color: Colors.black,)),

          ],))),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: Column(
              
              children: [
                 Container(
              height: MediaQuery.of(context).size.height * 0.3,
               width: MediaQuery.of(context).size.width,
              child: _images.isEmpty && _video == null
                  ? Center(child: Text('No media selected'))
                  : CarouselSlider(
                      items: [
                        ..._images.map((image) => _buildMediaItem(image)).toList(),
                        if (_video != null) _buildMediaItem(_video),
                      ],
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height * 0.3,
                        viewportFraction: 1.0,
                        enlargeCenterPage: false,
                        onPageChanged: (index, reason) {
                          if (_videoPlayerController != null && _isVideoInitialized) {
                            if (index == _images.length) {
                              _videoPlayerController!.play();
                            } else {
                              _videoPlayerController!.pause();
                            }
                          }
                        },
                      ),
                    ),
            ),
               
                SizedBox(height: 20.h,),
                 Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Add Image'),
                ),
                ElevatedButton(
                  onPressed: _pickVideo,
                  child: Text('Add Video'),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTextField('Title',width: 200,controller: _titleController),
                      Column(
                        children: [
                          _buildTextField('Category',width: 130,controller: _categoryController),
                          
                        ],
                      ),
                    ],
                  ),
        
                ),
                SizedBox(height: 10.h,),
                
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTextField('Ingredients',width: 200,maxLines: 10,height: 110,controller: _ingredientsController),
                        Column(
                          children: [
                            _buildTextField('Serve',width: 130,controller: _serveController),
                             SizedBox(height: 10.h,),
                              _buildTextField('Time',width: 130,controller: _timeController),
                          ],
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CustomText1(text: 'Cooking Method', size: 20),
                    ],
                  ),
                  
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    children: [
                      _buildTextField('',height: 120,maxLines: 10,width: 350,controller:_cookingMethodController ),
                    ],
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CustomText1(text: 'Tips', size: 20),
                    ],
                  ),
                  
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    children: [
                      _buildTextField('',height: 120,maxLines: 10,width: 350,controller: _tipsController),
                    ],
                  ),
                )
              
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildTextField(String label, {int maxLines=1,double height=50,double width=100,required TextEditingController controller} ) {
    return SizedBox(
      height: height,
      width: width,
      child: TextFormField(
         validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xff313131),
          labelText: label,
          labelStyle: GoogleFonts.poppins(textStyle: TextStyle(color: Color(0xffE0DBDB))),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        maxLines: maxLines,
      ),
    );
    
  }
}
class _PlayPauseOverlay extends StatelessWidget {
  const _PlayPauseOverlay({Key? key, required this.controller}) : super(key: key);

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            if (controller.value.isPlaying) {
              controller.pause();
            } else {
              controller.play();
            }
          },
        ),
      ],
    );
  }
}
