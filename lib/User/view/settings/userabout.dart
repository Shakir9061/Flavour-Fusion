import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class user_about extends StatelessWidget {
  const user_about({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme=Theme.of(context).colorScheme;
    return  Scaffold(
      backgroundColor:Theme.of(context).scaffoldBackgroundColor ,
        appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor ,
        automaticallyImplyLeading: false,
        title: CustomText1(text: 'About', size: 20, weight: FontWeight.w500,color: ColorScheme.primary,),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: ColorScheme.primary),
        ),
      ),
    );
  }
}