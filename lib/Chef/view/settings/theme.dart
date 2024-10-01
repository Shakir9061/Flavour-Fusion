import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_alertdialog.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeAlertDialog_chef extends StatefulWidget {
  const ThemeAlertDialog_chef({Key? key}) : super(key: key);

  @override
  State<ThemeAlertDialog_chef> createState() => _ThemeAlertDialog_chefState();
}

class _ThemeAlertDialog_chefState extends State<ThemeAlertDialog_chef> {
  String selectedValue = "";
 

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xff313131),
      title: CustomText1(text: 'Choose Theme', size: 16.sp),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                activeColor: Colors.teal,
               
                title: CustomText1(text: 'Dark', size: 15.sp),
                value: 'dark',
                groupValue: selectedValue,
                onChanged: (String? value) {
                  setState(() {
                    selectedValue = value!;
                    print(selectedValue);
                  });
                },
              ),
              RadioListTile<String>(
                activeColor: Colors.teal,
                title: CustomText1(text: 'Light', size: 15.sp),
                value: 'light',
                groupValue: selectedValue,
                onChanged: (String? value) {
                  setState(() {
                    selectedValue = value!;
                    print(selectedValue);
                  });
                },
              ),
            ],
          );
        },
      ),
      actions: [
        TextButton(
          child: CustomText1(text: 'Cancel', size: 15.sp,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child:CustomText1(text: 'Ok', size: 15.sp,color: Colors.teal,), 
          onPressed: () {
            Navigator.of(context).pop(selectedValue);
          },
        ),
      ],
    );
  }
}