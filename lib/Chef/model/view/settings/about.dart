import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class Chef_about extends StatelessWidget {
  const Chef_about({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: CustomText1(text: 'About', size: 20, weight: FontWeight.w500),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
    );
  }
}