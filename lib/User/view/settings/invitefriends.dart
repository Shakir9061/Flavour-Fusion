import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Invitefriends_user extends StatefulWidget {
  const Invitefriends_user({super.key});

  @override
  State<Invitefriends_user> createState() => _Invitefriends_userState();
}

class _Invitefriends_userState extends State<Invitefriends_user> {
 
  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      backgroundColor:  Color(0xff313131),
      title: Center(child: CustomText1(text: 'Invite Using', size: 16.sp,weight: FontWeight.bold,color: Colors.white,)),
      alignment: Alignment.bottomCenter,
      
      content:
       
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
           
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                 Image.asset('images/whatsapplogo.png',height: 35.h,),
                 SizedBox(
                  height: 10.h,
                ),
                CustomText1(text: 'Whatsapp', size: 13.sp,color: Colors.white,)
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('images/telegram.png',height: 35.h,),
                SizedBox(
                  height: 10.h,
                ),
                CustomText1(text: 'Telegram', size: 13.sp,color: Colors.white,)
              ],
            ),
          ],
        ),
      ),
      actions: [SizedBox(
        width: 300,
        child: TextButton(onPressed: () {
          Navigator.pop(context);
        },
        style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.teal)),
         child: CustomText1(text: 'Cancel', size: 15,color: Colors.white,)),
      ),
     
      ],
    );
  }
}