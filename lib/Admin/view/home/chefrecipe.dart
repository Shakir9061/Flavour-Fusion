import 'package:flutter/material.dart';

class ChefrecipeAdmin extends StatefulWidget {
  const ChefrecipeAdmin({super.key});

  @override
  State<ChefrecipeAdmin> createState() => _ChefrecipeAdminState();
}

class _ChefrecipeAdminState extends State<ChefrecipeAdmin> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: Text('Chef recipe',style: TextStyle(color: Colors.white),),
    );
  }
}