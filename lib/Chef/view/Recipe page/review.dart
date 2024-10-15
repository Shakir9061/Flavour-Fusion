import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flavour_fusion/Chef/view/Recipe%20page/Addreport.dart';
import 'package:flavour_fusion/Chef/view/Recipe%20page/addreview.dart';
import 'package:flavour_fusion/Chef/view/settings/theme.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewTab_chef extends StatefulWidget {
  final String recipeId;

  const ReviewTab_chef({Key? key, required this.recipeId}) : super(key: key);

  @override
  State<ReviewTab_chef> createState() => _ReviewTab_chefState();
}

class _ReviewTab_chefState extends State<ReviewTab_chef> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('reviews')
            .where('recipeId', isEqualTo: widget.recipeId)
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
            return Center(child: Text('No reviews yet.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var review = snapshot.data!.docs[index];
              return _buildReviewCard(review);
            },
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Addreview_chef(recipeId: widget.recipeId),
              ),
            );
          },
          child: Icon(Icons.add, size: 35, color: Colors.white),
          backgroundColor: Colors.teal,
        ),
      ),
    );
  }

  Widget _buildReviewCard(DocumentSnapshot review) {
    return Card(
      color: Colors.grey[800],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  // You can add user profile image here
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText1(text: review['userName'], size: 13),
                      CustomText1(
                        text: review['timestamp'] != null
                            ? review['timestamp'].toDate().toString().split(' ')[0]
                            : 'Date not available',
                        size: 12,
                      ),
                    ],
                  ),
                ),
                PopupMenuButton(
                  iconColor: Colors.white,
                  color: Colors.grey[600],
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () {
                        showThemeDialog(context);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.flag),
                          SizedBox(width: 5),
                          CustomText1(text: 'Report', size: 13),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            RatingBar.builder(
              initialRating: review['rating'].toDouble(),
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 20,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {},
              ignoreGestures: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: CustomText1(text: review['review'], size: 14),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showThemeDialog(BuildContext context) async {
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AddReport_chef(),
    );

    if (result != null) {
      print('Selected theme: $result');
    }
  }
}