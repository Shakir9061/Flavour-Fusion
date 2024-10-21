import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavour_fusion/Chef/model/view/Recipe%20page/Addreport.dart';
import 'package:flavour_fusion/Chef/model/view/Recipe%20page/addreview.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewTab_chef extends StatelessWidget {
  final String recipeId;

  const ReviewTab_chef({Key? key, required this.recipeId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
           .collectionGroup('reviews')
            .where('recipeId', isEqualTo: recipeId)
            .orderBy('timestamp', descending: true)
            .snapshots(),
            
          
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: CustomText1(
                text: 'No reviews yet for this recipe.',
                size: 18.sp,
              ),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var review = snapshot.data!.docs[index];
              return _buildReviewCard(context, review);
            },
          );
        },
      ),
      floatingActionButton: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return FloatingActionButton(
              onPressed: () => _navigateToAddReview(context),
              child: Icon(Icons.add, size: 35, color: Colors.white),
              backgroundColor: Colors.teal,
            );
          } else {
            return SizedBox.shrink(); // Hide button if user is not authenticated
          }
        },
      ),
    );
  }

  Widget _buildReviewCard(BuildContext context, DocumentSnapshot review) {
    Map<String, dynamic> reviewData = review.data() as Map<String, dynamic>;
    return Card(
      color: Colors.grey[800],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildReviewHeader(context, reviewData, review.id),
            SizedBox(height: 12.h),
            _buildRatingBar(reviewData),
            SizedBox(height: 12.h),
            CustomText1(
              text: reviewData['review'] ?? 'No review text',
              size: 14.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewHeader(BuildContext context, Map<String, dynamic> reviewData, String reviewId) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20.r,
          backgroundColor: Colors.teal,
          child: Text(
            (reviewData['userName'] ?? 'A')[0].toUpperCase(),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText1(
                text: reviewData['userName'] ?? 'Anonymous',
                size: 16.sp,
                weight: FontWeight.bold,
              ),
              SizedBox(height: 4.h),
              CustomText1(
                text: _formatDate(reviewData['timestamp']),
                size: 12.sp,
                color: Colors.grey[400]!,
              ),
            ],
          ),
        ),
        PopupMenuButton(
          iconColor: Colors.white,
          color: Colors.grey[600],
          itemBuilder: (context) => [
            PopupMenuItem(
              onTap: () => _showReportDialog(context),
              child: Row(
                children: [
                  Icon(Icons.flag, color: Colors.white),
                  SizedBox(width: 8.w),
                  CustomText1(text: 'Report', size: 14.sp),
                ],
              ),
            ),
            if (FirebaseAuth.instance.currentUser?.uid == reviewData['userId'])
              PopupMenuItem(
                onTap: () => _deleteReview(context, reviewId),
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Colors.white),
                    SizedBox(width: 8.w),
                    CustomText1(text: 'Delete', size: 14.sp),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildRatingBar(Map<String, dynamic> reviewData) {
    return RatingBar.builder(
      initialRating: (reviewData['rating'] as num?)?.toDouble() ?? 0.0,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      itemSize: 20.r,
      itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
      onRatingUpdate: (rating) {},
      ignoreGestures: true,
    );
  }

  String _formatDate(dynamic timestamp) {
    if (timestamp == null) return 'Date not available';
    if (timestamp is Timestamp) {
      DateTime date = timestamp.toDate();
      return '${date.day}/${date.month}/${date.year}';
    }
    return 'Invalid date';
  }

  void _navigateToAddReview(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Addreview_chef(recipeId: recipeId),
      ),
    );
  }

  Future<void> _showReportDialog(BuildContext context) async {
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AddReport_chef(),
    );
    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Report submitted successfully')),
      );
    }
  }

  Future<void> _deleteReview(BuildContext context, String reviewId) async {
    try {
      await FirebaseFirestore.instance
          .collection('recipe reviews')
          .doc(recipeId)
          .collection('reviews')
          .doc(reviewId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Review deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting review: $e')),
      );
    }
  }
}