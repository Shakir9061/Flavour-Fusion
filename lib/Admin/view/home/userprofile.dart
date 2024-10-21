import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_appbar.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';

class UserprofileAdmin extends StatefulWidget {
 final String? userId;
  const UserprofileAdmin({super.key,  this. userId});

  @override
  State<UserprofileAdmin> createState() => _UserprofileAdminState();
}

class _UserprofileAdminState extends State<UserprofileAdmin> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
       appBar: AppBar(
        backgroundColor: Colors.black,
        title: CustomText1(
          text: 'User Profile',
          size: 18,
          weight: FontWeight.w600,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body:
       Column(
        children: [
         
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: CircleAvatar(
                radius: 40,
                backgroundImage: Image.network(widget.userId['']),
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
                          CustomText1(text: 'User Id', size: 18,color: Colors.white,),
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
                      CustomText1(text: 'user', size: 18,color: Colors.white,),
                       SizedBox(
                        height: 10,
                      ),
                      CustomText1(text: 'male', size: 18,color: Colors.white,),
                       SizedBox(
                        height: 10,
                      ),
                      CustomText1(text: 'user@gmail.com ', size: 18,color: Colors.white,),
                       SizedBox(
                        height: 10,
                      ),
                      CustomText1(text: 'user@123', size: 18,color: Colors.white,),
                       SizedBox(
                        height: 10,
                      ),
                      CustomText1(text: 'user3321', size: 18,color: Colors.white,)
                    ],
                   )
                   
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
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
    );
  }
}