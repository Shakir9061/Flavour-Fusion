
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:permission_handler/permission_handler.dart';
class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({Key? key}) : super(key: key);

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final otpController = TextEditingController();
  String? _commingSms = '';
  String? _appSignature = '';

  Future<void> requestSmsPermission() async {
    final status = await Permission.sms.request();
    if (status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('SMS Permission granted')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('SMS Permission denied')),
      );
    }
  }

  Future<void> initSmsListener() async {
    try {
      // Get app signature
      final signature = await SmsAutoFill().getAppSignature;
      setState(() {
        _appSignature = signature;
      });
      print('App Signature: $signature');

      // Listen for SMS
      SmsAutoFill().listenForCode().then((value) {
        print('Started listening for SMS');
      });

      // Listen for incoming SMS
      await SmsAutoFill().listenForCode;
      print('SMS Listener initialized');
    } catch (e) {
      print('Error initializing SMS listener: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    requestSmsPermission();
    initSmsListener();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Waiting for OTP...',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            PinFieldAutoFill(
              currentCode: _commingSms,
              onCodeSubmitted: (code) {
                print('Code Submitted: $code');
                setState(() {
                  _commingSms = code;
                });
              },
              onCodeChanged: (code) {
                print('Code Changed: $code');
                setState(() {
                  _commingSms = code;
                });
                if (code?.length == 6) {
                  print('Complete code received: $code');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('OTP Received: $code')),
                  );
                }
              },
              decoration: UnderlineDecoration(
                textStyle: const TextStyle(fontSize: 24, color: Colors.black),
                colorBuilder: const FixedColorBuilder(Colors.black),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'App Signature: $_appSignature',
              style: const TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 20),
            Text(
              'Current OTP: $_commingSms',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await requestSmsPermission();
                await initSmsListener();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Restarted SMS Listener')),
                );
              },
              child: const Text('Restart SMS Listener'),
            ),
          ],
        ),
      ),
    );
  }
}