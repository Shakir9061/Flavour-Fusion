import 'package:firebase_core/firebase_core.dart';
import 'package:flavour_fusion/common/theme/themeprovider.dart';
import 'package:flavour_fusion/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flavour_fusion/common/SplashScreen/splash1.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


void main()async {
   WidgetsFlutterBinding.ensureInitialized();

    await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
    final themeProvider = ThemeProvider();
  await themeProvider.loadThemeMode();

  runApp(
    ChangeNotifierProvider(create: (context) => ThemeProvider(),child: const MyApp(),),
    );
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
        theme:  Provider.of<ThemeProvider>(context).themeData,
        home:  const Splash1()
        
       
        
        
      ),
      designSize: Size(406, 852),
    );
  }
}

