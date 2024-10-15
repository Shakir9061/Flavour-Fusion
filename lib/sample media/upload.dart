import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flavour_fusion/sample%20media/show.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddMediaPage extends StatefulWidget {
  @override
  _AddMediaPageState createState() => _AddMediaPageState();
}

class _AddMediaPageState extends State<AddMediaPage> {
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;

  Future<void> _addMedia(bool isVideo) async {
    setState(() {
      _isUploading = true;
    });

    try {
      final XFile? file = isVideo
          ? await _picker.pickVideo(source: ImageSource.gallery)
          : await _picker.pickImage(source: ImageSource.gallery);

      if (file != null) {
        String fileUrl = await uploadFileToFirebase(file, isVideo);

        await FirebaseFirestore.instance.collection('slides').add({
          'url': fileUrl,
          'isVideo': isVideo,
          'timestamp': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Media uploaded successfully')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading media: $e')),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  Future<String> uploadFileToFirebase(XFile file, bool isVideo) async {
    File fileToUpload = File(file.path);
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    String extension = isVideo ? '.mp4' : '.jpg';

    Reference storageRef = FirebaseStorage.instance.ref().child('media/$fileName$extension');
    UploadTask uploadTask = storageRef.putFile(fileToUpload);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Media')),
      body: Center(
        child: _isUploading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => _addMedia(false),
                    child: Text('Add Image'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _addMedia(true),
                    child: Text('Add Video'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SlideshowPage()));
                    },
                    child: Text('View Slideshow'),
                  ),
                ],
              ),
      ),
    );
  }
}