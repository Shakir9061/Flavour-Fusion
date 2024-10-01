import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_appbar.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';

class ChefprofileAdmin extends StatefulWidget {
  const ChefprofileAdmin({super.key});

  @override
  State<ChefprofileAdmin> createState() => _ChefprofileAdminState();
}

class _ChefprofileAdminState extends State<ChefprofileAdmin> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       backgroundColor: Colors.black,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
              child: CustomAppBar(title: 'Chef Profile')),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: CircleAvatar(
                  radius: 40,
                ),
                
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50,left: 30,right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText1(text: 'Name', size: 18,color: Colors.white,),
                        SizedBox(
                          height: 10,
                        ),
                         CustomText1(text: 'Gender', size: 18,color: Colors.white,),
                          SizedBox(
                          height: 10,
                        ),
                          CustomText1(text: 'E-mail', size: 18,color: Colors.white,),
                           SizedBox(
                          height: 10,
                        ),
                           CustomText1(text: 'Password', size: 18,color: Colors.white,),
                            SizedBox(
                          height: 10,
                        ),
                            CustomText1(text: 'Chef Id', size: 18,color: Colors.white,),
                      ],
                    ),
                    
                     Column(
                       children: [
                         CustomText1(text: ':', size: 18,color: Colors.white,),
                          SizedBox(
                          height: 10,
                        ),
                        CustomText1(text: ':', size: 18,color: Colors.white,),
                         SizedBox(
                          height: 10,
                        ),
                       CustomText1(text: ':', size: 18,color: Colors.white,),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText1(text: ':', size: 18,color: Colors.white,),
                         SizedBox(
                          height: 10,
                        ),
                         CustomText1(text: ':', size: 18,color: Colors.white,),
                        
                       ],
                     ),
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText1(text: 'Chef', size: 18,color: Colors.white,),
                         SizedBox(
                          height: 10,
                        ),
                        CustomText1(text: 'male', size: 18,color: Colors.white,),
                         SizedBox(
                          height: 10,
                        ),
                        CustomText1(text: 'chef@gmail.com ', size: 18,color: Colors.white,),
                         SizedBox(
                          height: 10,
                        ),
                        CustomText1(text: 'chef@123', size: 18,color: Colors.white,),
                         SizedBox(
                          height: 10,
                        ),
                        CustomText1(text: 'chef3321', size: 18,color: Colors.white,)
                      ],
                     )
                     
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(left: 30,top: 30),
              child: Row(
                children: [
                  CustomText1(text: 'Documents', size: 20,color: Colors.white,),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 300,
                    decoration: BoxDecoration(color: Color(0xff313131),borderRadius: BorderRadius.circular(10)),
                  ),
                ],
              ),
            ),
              Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 300,
                    decoration: BoxDecoration(color: Color(0xff313131),borderRadius: BorderRadius.circular(10)),
                  ),
                ],
              ),
            ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.teal)),
                        onPressed: () {
                        
                      }, child: CustomText1(text: 'Delete', size: 19)),
                    ),
                     SizedBox(
                      width: 150,
                       child: ElevatedButton(
                        style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.teal)),
                        onPressed: () {
                        
                                         }, child: CustomText1(text: 'Suspend', size: 19)),
                     ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}