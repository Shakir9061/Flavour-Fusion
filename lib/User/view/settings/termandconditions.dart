import 'package:flavour_fusion/widgets/custom_appbar.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsAndConditions_user extends StatelessWidget {
  const TermsAndConditions_user({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              child: CustomAppBar(
                title: 'Terms & Conditions',
                weight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildSectionTitle('Terms & Conditions'),
                  _buildNumberedItem('1. Introduction',
                      'Welcome to Flavour Fusion, a food recipe application that allows users to view and share recipes, provide feedback, and engage with a culinary community. By using our app, you agree to comply with these Terms and Conditions.'),
                  _buildNumberedItem('2.User Accounts', ''),
                  _buildBulletPoint(
                      ' Registration: Users must register to create an account. All information provided must be accurate and updated regularly.'),
                  _buildBulletPoint(
                      'Account Security: Users are responsible for maintaining the confidentiality of their account information. Notify us immediately of any unauthorized use.'),
                  _buildNumberedItem('3. Content Submission', ''),
                  _buildBulletPoint(
                      'Recipe Submission: Chefs and users can submit recipes, images, and videos. By submitting content, you grant Flavour Fusion a non-exclusive, royalty-free license to use, modify, and distribute your content.'),
                  _buildBulletPoint(
                      'Content Standards: All submitted content must be original, accurate, and not infringe on any third-party rights. We reserve the right to remove content that violates our guidelines.'),
                  _buildNumberedItem('4. Feedback and Ratings', ''),
                  _buildBulletPoint(
                      'Users and chefs can provide feedback and ratings on recipes. All feedback must be honest and respectful. Abusive or misleading feedback will be removed.'),
                ],
              ),
            )
          ],
        ));
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: CustomText1(
          text: title,
          size: 16,
          weight: FontWeight.bold,
        ));
  }

  Widget _buildNumberedItem(String title, String content) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 5.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText1(
            text: title,
            size: 15.sp,
            weight: FontWeight.w600,
          ),
          if (content.isNotEmpty) SizedBox(height: 4),
          if (content.isNotEmpty)
            CustomText1(
              text: content,
              size: 15.sp,
              weight: FontWeight.w400,
            ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String content) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 25.0, right: 10.0, top: 4.0, bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText1(text: '• ', size: 18),
          Expanded(child: CustomText1(text: content, size: 15)),
        ],
      ),
    );
  }
}
