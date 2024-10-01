import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_appbar.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       backgroundColor: Colors.black,
      body:  Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
            child: CustomAppBar(title: 'Reports',weight: FontWeight.bold,)),
        ],
      )
    );
  }
}