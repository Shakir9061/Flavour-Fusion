import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavour_fusion/widgets/custom_appbar.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Addreview_chef extends StatefulWidget {
  final String recipeId; // Add this line to receive the recipe ID

  const Addreview_chef({Key? key, required this.recipeId}) : super(key: key);

  @override
  State<Addreview_chef> createState() => _Addreview_chefState();
}

class _Addreview_chefState extends State<Addreview_chef> {
  final TextEditingController _reviewController = TextEditingController();
  double _rating = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
            title: 'Add review',
            weight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  CustomText1(
                    text: 'Leave a Review',
                    size: 20,
                    weight: FontWeight.w600,
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            SizedBox(
              height: 200,
              width: 350,
              child: TextField(
                controller: _reviewController,
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: 'Add comment',
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 20),
              child: Row(
                children: [
                  CustomText1(
                    text: 'Rate this recipe',
                    size: 20,
                    weight: FontWeight.w600,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  unratedColor: Colors.white,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: 80,
          child: FloatingActionButton(
            onPressed: () {
              _submitReview();
            },
            child: Center(
              child: CustomText1(
                text: 'Post',
                size: 15,
                weight: FontWeight.w600,
              ),
            ),
            backgroundColor: Colors.teal,
          ),
        ),
      ),
    );
  }

    void _submitReview() async {
    if (_reviewController.text.isEmpty || _rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a review and rating')),
      );
      return;
    }

    try {
      User? currentUser = _auth.currentUser;
      
      if (currentUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You must be logged in to submit a review')),
        );
        return;
      }

      // Fetch the user's display name from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      String userName = 'Anonymous';
      if (userDoc.exists) {
        userName = (userDoc.data() as Map<String, dynamic>)['displayName'] ?? 'Anonymous';
      }

      await FirebaseFirestore.instance.collection('reviews').add({
        'recipeId': widget.recipeId,
        'userId': currentUser.uid,
        'userName': userName,
        'review': _reviewController.text,
        'rating': _rating,
        'timestamp': FieldValue.serverTimestamp(),
      });

      Navigator.pop(context);
    } catch (e) {
      print('Error submitting review: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error submitting review. Please try again.')),
      );
    }
  }
}

