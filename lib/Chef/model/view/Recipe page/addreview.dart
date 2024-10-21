import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavour_fusion/widgets/custom_appbar.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Addreview_chef extends StatefulWidget {
  final String recipeId;
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
            title: 'Add Review',
            weight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText1(
                text: 'Rate this recipe',
                size: 20.sp,
                weight: FontWeight.w600,
              ),
              SizedBox(height: 15.h),
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                unratedColor: Colors.white,
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
              SizedBox(height: 30.h),
              CustomText1(
                text: 'Write your review',
                size: 20.sp,
                weight: FontWeight.w600,
              ),
              SizedBox(height: 15.h),
              TextField(
                controller: _reviewController,
                maxLines: 5,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Share your thoughts about this recipe...',
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Center(
                child: ElevatedButton(
                  onPressed: _submitReview,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
                    child: CustomText1(
                      text: 'Submit Review',
                      size: 18.sp,
                      weight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
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

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('ChefAuth')
          .doc(currentUser.uid)
          .get();

      String userName = 'Anonymous';
      if (userDoc.exists) {
        userName = (userDoc.data() as Map<String, dynamic>)['name'] ?? 'Anonymous';
      }

      await FirebaseFirestore.instance.collection('recipes review'). doc(widget.recipeId).collection('reviews').   add({
        'recipeId': widget.recipeId,
        'userId': currentUser.uid,
        'userName': userName,
        'review': _reviewController.text,
        'rating': _rating,
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Review submitted successfully')),
      );
      Navigator.pop(context);
    } catch (e) {
      print('Error submitting review: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error submitting review. Please try again.')),
      );
    }
  }
}