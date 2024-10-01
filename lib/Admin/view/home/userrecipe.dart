import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flavour_fusion/Admin/view/home/userrecipedetails.dart';

class UserrecipeAdmin extends StatefulWidget {
  const UserrecipeAdmin({super.key});

  @override
  State<UserrecipeAdmin> createState() => _UserrecipeAdminState();
}

class _UserrecipeAdminState extends State<UserrecipeAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30,left: 30),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UserRecipeDetailsAdmin(),));
              },
              child: Container(
               height: 120,
                width: 350,
                decoration: BoxDecoration(color: Color(0xff313131),borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        width: 120,
                        height: 120,
                        fit: BoxFit.fill,
                        image: AssetImage('images/arabic.jpg')),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 7.0,top: 7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText1(text: 'Korean fried Chicken', size: 15),
                             Padding(
                               padding: const EdgeInsets.only(top: 5,),
                               child: CustomText1(text: '2 broiler/fryer chickens (3-1/2 to 4 pounds each), cut up, 4 cups all-purpose flour, divided,2 tablespoons garlic salt,1 tablespoon paprika,3 teaspoons pepper divided.....', size: 8,softWrap: true,),
                             ),
                             SizedBox(
                              height: 6,
                             ),
                             Row(
                               children: [
                                 CircleAvatar(
                                  radius: 15,
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.only(left: 10),
                                   child: CustomText1(text: 'John', size: 12),
                                 )
                               ],
                             )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}