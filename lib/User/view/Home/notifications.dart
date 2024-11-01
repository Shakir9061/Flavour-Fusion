import 'package:flavour_fusion/User/view/Home/bottomnavigation.dart';
import 'package:flavour_fusion/widgets/custom_appbar.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationUser extends StatefulWidget {
  const NotificationUser({super.key});

  @override
  State<NotificationUser> createState() => _NotificationUserState();
}

class _NotificationUserState extends State<NotificationUser> {
  @override
  Widget build(BuildContext context) {
    final ColorScheme=Theme.of(context).colorScheme;
    return  Scaffold(
     backgroundColor:Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title:CustomText1(text: 'Notifications',color:ColorScheme.primary ,) ,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Bottomnavigation_user(),));
        }, icon: Icon(Icons.arrow_back,color: ColorScheme.primary,)),
      ),
    );
  }
}