import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddReport_user extends StatefulWidget {
   final String? reviewId;
  final String? reportedUserId;
  const AddReport_user({super.key, this. reportedUserId, this. reviewId,});

  @override
  State<AddReport_user> createState() => _AddReport_userState();
}

class _AddReport_userState extends State<AddReport_user> {
   final TextEditingController _reportController = TextEditingController();
  bool _isSubmitting = false;
   Future<void> _submitReport() async {
    if (_reportController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please write your report first')),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception('User not authenticated');
      }

      await FirebaseFirestore.instance.collection('reports').add({
        'reviewId': widget.reviewId,
        'reportedUserId': widget.reportedUserId,
        'reporterId': currentUser.uid,
        'reporterName': currentUser.displayName ?? 'Anonymous',
        'content': _reportController.text.trim(),
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'pending', // Can be 'pending', 'reviewed', 'resolved'
      });

      if (mounted) {
        Navigator.pop(context, 'success');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error submitting report: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }
  
  @override
  void dispose() {
    _reportController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme=Theme.of(context).colorScheme;
    return  AlertDialog(
      backgroundColor:Theme.of(context).scaffoldBackgroundColor  ,
 title: Column(
   children: [
     Row(
       children: [
         CustomText1(text: 'Report', size: 15,weight: FontWeight.w600,color: ColorScheme.primary,),
       ],
     ),
     SizedBox(
      height: 10,
     ),
          Row(
            children: [
              CustomText1(text: 'What’s going on ?', size: 24,weight: FontWeight.w600,color: ColorScheme.primary),
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
      controller: _reportController,
      maxLines: 10,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        hintText: 'Write something....',
        hintStyle: TextStyle(color: Colors.grey[400]),
        filled:true,fillColor: Theme.of(context).cardColor),
     ),
   )
   ],
 ),
  actions: [
        SizedBox(
          width: 300,
          child: TextButton(
            onPressed: _isSubmitting ? null : _submitReport,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.disabled)) {
                    return Colors.grey;
                  }
                  return Colors.teal;
                },
              ),
            ),
            child: _isSubmitting
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : CustomText1(
                    text: 'Submit',
                    size: 15.sp,
                  ),
          ),
        ),
      ],
    );
  }
}