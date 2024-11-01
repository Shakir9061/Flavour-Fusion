import 'package:flavour_fusion/widgets/custom_appbar.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsAndConditions_user extends StatelessWidget {
  const TermsAndConditions_user({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: CustomAppBar(title: 'Terms & Conditions',backgroundColor: Theme.of(context).scaffoldBackgroundColor,),
        body: Column(
          children: [
           
            Expanded(
              child: ListView(
                children: [
                  _buildSectionTitle('Terms & Conditions',context),
                  _buildNumberedItem('1. Introduction',
                      'Welcome to Flavour Fusion, a food recipe application that allows users to view and share recipes, provide feedback, and engage with a culinary community. By using our app, you agree to comply with these Terms and Conditions.',context),
                  _buildNumberedItem('2.User Accounts', '',context),
                  _buildBulletPoint(
                      ' Registration: Users must register to create an account. All information provided must be accurate and updated regularly.',context),
                  _buildBulletPoint(
                      'Account Security: Users are responsible for maintaining the confidentiality of their account information. Notify us immediately of any unauthorized use.',context),
                  _buildNumberedItem('3. Content Submission', '',context),
                  _buildBulletPoint(
                      'Recipe Submission: Chefs and users can submit recipes, images, and videos. By submitting content, you grant Flavour Fusion a non-exclusive, royalty-free license to use, modify, and distribute your content.',context),
                  _buildBulletPoint(
                      'Content Standards: All submitted content must be original, accurate, and not infringe on any third-party rights. We reserve the right to remove content that violates our guidelines.',context),
                  _buildNumberedItem('4. Feedback and Ratings', '',context),
                  _buildBulletPoint(
                      'Users and chefs can provide feedback and ratings on recipes. All feedback must be honest and respectful. Abusive or misleading feedback will be removed.',context),
                ],
              ),
            )
          ],
        ));
  }
 Widget _buildSectionTitle(String title,BuildContext context) {
    final ColorScheme=Theme.of(context).colorScheme;
    return Padding(
        padding: const EdgeInsets.all(15.0),
        child: CustomText1(
          text: title,
          size: 16,
          weight: FontWeight.w600,
          color:ColorScheme.primary ,
        ));
  }

  Widget _buildNumberedItem(String title, String content,BuildContext context) {
        final ColorScheme=Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 5.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText1(
            text: title,
            size: 15.sp,
            weight: FontWeight.w600,
            color: ColorScheme.primary,
          ),
          if (content.isNotEmpty) SizedBox(height: 4),
          if (content.isNotEmpty)
            CustomText1(
              text: content,
              size: 15.sp,
              weight: FontWeight.w400,
              color: ColorScheme.primary,
            ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String content,BuildContext context) {
            final ColorScheme=Theme.of(context).colorScheme;

    return Padding(
      padding:
          const EdgeInsets.only(left: 25.0, right: 10.0, top: 4.0, bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText1(text: '• ', size: 18,color: ColorScheme.primary,),
          Expanded(child: CustomText1(text: content, size: 15,color: ColorScheme.primary,)),
        ],
      ),
    );
  }
}
