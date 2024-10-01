import 'package:flavour_fusion/widgets/custom_appbar.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';


class Shoppinglist extends StatefulWidget {
  const Shoppinglist({super.key});

  @override
  State<Shoppinglist> createState() => _ShoppinglistState();
}

class _ShoppinglistState extends State<Shoppinglist> {
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
                title: 'Shopping List',
                weight: FontWeight.bold,
              )),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart,
                      size: 60, color: Color.fromARGB(255, 224, 219, 219)),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomText1(
                    text: 'Shopping List is Empty',
                    size: 20,
                    weight: FontWeight.w500,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomText1(
                        text:
                            '  Start your shopping list by adding ingredients using the add button below.',
                        size: 12,textAlign: TextAlign.center,),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(onPressed: () {
          
        },child: Icon(Icons.add,size: 35,color: Colors.white,),
        backgroundColor: Colors.teal,
        ),
      ),
    );
  }
}
