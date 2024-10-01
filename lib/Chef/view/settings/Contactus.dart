import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class CoontactUs_chef extends StatelessWidget {
  const CoontactUs_chef({super.key});
void _launchEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      print('Could not launch $emailLaunchUri');
    }
  }
  @override

  Widget build(BuildContext context) {
    return  Scaffold(
    );
  }
}