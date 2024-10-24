import 'package:firebase_core/firebase_core.dart';
import 'package:flavour_fusion/firebase_options.dart';
import 'package:flavour_fusion/sample%20media/upload.dart';

import 'package:flutter/material.dart';
import 'package:flavour_fusion/common/SplashScreen/splash1.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


void main()async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   
    return ScreenUtilInit(
      builder: (context, child) =>    MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
       
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:    const Splash1()
        
       
        
        
      ),
      designSize: Size(406, 852),
    );
  }
}

