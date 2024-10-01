import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddReport extends StatefulWidget {
  const AddReport({super.key});

  @override
  State<AddReport> createState() => _AddReportState();
}

class _AddReportState extends State<AddReport> {
  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      backgroundColor:  Color(0xff313131),
 title: Column(
   children: [
     Row(
       children: [
         CustomText1(text: 'Report', size: 15,weight: FontWeight.w600,),
       ],
     ),
     SizedBox(
      height: 10,
     ),
          Row(
            children: [
              CustomText1(text: 'What’s going on ?', size: 24,weight: FontWeight.w600,),
            ],
          ),

   ],
 ),
 content: Column(
  mainAxisSize: MainAxisSize.min,
   children: [
   SizedBox(
    height: 200,
    width: 300,
     child: TextField(
      maxLines: 10,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        hintText: 'Write something....',
        hintStyle: TextStyle(color: Colors.white),
        filled:true,fillColor: Colors.black),
     ),
   )
   ],
 ),
 actions: [
  SizedBox(
    width: 300,
    child: TextButton(onPressed: () {
      Navigator.pop(context);
    }, 
     style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.teal)),
    child: CustomText1(text: 'Submit', size: 15.sp,)),
  ),
 
  
 ],
    );
  }
}