
import 'package:flavour_fusion/User/view/settings/deleteaccount.dart';
import 'package:flavour_fusion/User/view/settings/invitefriends.dart';
import 'package:flavour_fusion/User/view/settings/singout.dart';
import 'package:flavour_fusion/User/view/settings/termandconditions.dart';
import 'package:flavour_fusion/User/view/settings/theme.dart';
import 'package:flavour_fusion/widgets/custom_appbar.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsUser extends StatefulWidget {
  const SettingsUser({super.key});

  @override
  State<SettingsUser> createState() => _SettingsUserState();
}

class _SettingsUserState extends State<SettingsUser> {
  String selectedvalue = " ";
  final List<String> text = [
    'Theme',
    'Invite Friends',
    'Terms & Conditions',
    'Contact Us',
    'Delete Account',
    'Sign Out'
  ];
  late List<Function()> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      () => showThemeDialog(context),
      () => invitefriends(context),
      () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => TermsAndConditions_user())),
      () =>_launchEmail('muhammedshakir154@gmail.com'),
      () => Deleteaccount(context),
      () =>AccountSignOut(context),
    ];
  }

  Future<void> showThemeDialog(BuildContext context) async {
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) => ThemeAlertDialog_user(),
    );

    if (result != null) {
      print('Selected theme: $result');
    }
  }

  Future<void> invitefriends(BuildContext context) async {
    final res = await showDialog<String>(
      context: context,
      builder: (BuildContext context) => Invitefriends_user(),
    );
  }

  Future<void> Deleteaccount(BuildContext context) async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => DeleteAccount_user(),
    );
  }
  Future<void> AccountSignOut(BuildContext context) async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => SignOut_user(),
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              child: CustomAppBar(
                title: 'Settings',
                weight: FontWeight.bold,
              )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
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
                              color: Colors.white,
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
