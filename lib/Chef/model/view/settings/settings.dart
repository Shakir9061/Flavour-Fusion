import 'package:flavour_fusion/Chef/model/view/settings/about.dart';
import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_alertdialog.dart';
import 'package:flavour_fusion/widgets/custom_appbar.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flavour_fusion/Chef/model/view/settings/Contactus.dart';

import 'package:flavour_fusion/Chef/model/view/settings/deleteaccount.dart';
import 'package:flavour_fusion/Chef/model/view/settings/termandconditions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsChef extends StatefulWidget {
  const SettingsChef({super.key});

  @override
  State<SettingsChef> createState() => _SettingsChefState();
}

class _SettingsChefState extends State<SettingsChef> {
  String selectedvalue = " ";
  final List<String> text = [
    'About',
   
    'Terms & Conditions',
    'Contact Us',
    'Delete Account',
    
  ];
  late List<Function()> pages;

  @override
  void initState() {
    super.initState();
    pages = [
     
      () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => Chef_about())),
      () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => TermsAndConditions_chef())),
      () =>_launchEmail('muhammedshakir154@gmail.com'),
      () => Deleteaccount(context),
     
    ];
  }

 

 

  Future<void> Deleteaccount(BuildContext context) async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => DeleteAccount_chef(),
    );
  }
 
 Future<void> _launchEmail(String email) async {
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: email,
  );
  try {
    if (!await launchUrl(emailLaunchUri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $emailLaunchUri');
    }
  } catch (e) {
    print('Error launching email: $e');
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Could not open email client')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
     final ColorScheme=Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        title: CustomText1(text: 'Settings', size: 20, weight: FontWeight.w500,color: ColorScheme.primary,),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color:  ColorScheme.primary),
        ),
      ),
      body: Column(
        children: [
        
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListView.builder(
                itemCount: text.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () {
                              pages[index]();
                            },
                            child: CustomText1(
                              text: text[index],
                              size: 18,
                              color:  ColorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 10, right: 20),
                        child: Divider(
                          thickness: 0.5,
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
