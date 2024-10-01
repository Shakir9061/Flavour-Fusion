import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_appbar.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Addreview_chef extends StatefulWidget {
  const Addreview_chef({super.key});

  @override
  State<Addreview_chef> createState() => _Addreview_chefState();
}

class _Addreview_chefState extends State<Addreview_chef> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              child: CustomAppBar(
                title: 'Add review',
                weight: FontWeight.bold,
              ))),
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
            SizedBox(
              height: 15.h,
            ),
            SizedBox(
                height: 200,
                width: 350,
                child: TextField(
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: 'Add comment',
                      filled: true,
                      fillColor: Colors.grey[800],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                )),
                Padding(
              padding: const EdgeInsets.only(left: 8.0,top: 20),
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
            SizedBox(
              height: 10,
            ), 
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
                     print(rating);
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
          child: FloatingActionButton(onPressed: () {
            
          },child:Center(child: CustomText1(text: 'Post', size: 15,weight: FontWeight.w600,)),
          backgroundColor: Colors.teal,
          ),
        ),
      ),
    );
  }
}
