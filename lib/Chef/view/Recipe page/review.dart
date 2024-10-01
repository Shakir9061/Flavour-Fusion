import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flavour_fusion/Chef/view/Recipe%20page/Addreport.dart';
import 'package:flavour_fusion/Chef/view/Recipe%20page/addreview.dart';
import 'package:flavour_fusion/Chef/view/settings/theme.dart';

class ReviewTab_chef extends StatefulWidget {
  const ReviewTab_chef({super.key});

  @override
  State<ReviewTab_chef> createState() => _ReviewTab_chefState();
}

class _ReviewTab_chefState extends State<ReviewTab_chef> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20),
          child: Column(
            children: [
             SizedBox(
              
               child: Card(
                color: Colors.grey[800],
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(12),
                     ),
                     child: Padding(
                       padding: const EdgeInsets.all(12.0),
                       child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Row(
                             children: [
                               CircleAvatar(
                                radius: 20,
                               ),
                                  SizedBox(width: 10,),
                           Expanded(
                             child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              CustomText1(text: 'User', size: 13),
                              CustomText1(text: '12-12-22', size: 12)
                             ],),
                           ),
                          PopupMenuButton(
                           iconColor: Colors.white,
                            color: Colors.grey[600],
                            itemBuilder: (context) => [PopupMenuItem(
                              onTap: () {
                                showThemeDialog(context);
                              },
                              child: Row(
                              children: [
                                
                                Icon(Icons.flag),
                                SizedBox(
                                  width: 5,
                                ),
                                CustomText1(text: 'Report', size: 13),
                              ],
                            )),])
                             ],
                           ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                          child: CustomText1(text: 'loved it !!!', size: 14),
                        )
                         ],
                       ),
                     ),
               ),
             )
            ],
          ),
        ),
      ),
        floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Addreview_chef(),));
        },child: Icon(Icons.add,size: 35,color: Colors.white,),
        backgroundColor: Colors.teal,
        ),
      ),
    );
  }
   Future<void> showThemeDialog(BuildContext context) async {
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AddReport_chef(),
    );

    if (result != null) {
      print('Selected theme: $result');
    }
  }

}