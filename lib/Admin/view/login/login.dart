import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flavour_fusion/Admin/view/home/Home.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
       body: SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 160),
                child: CustomText1(text: 'Login', size: 36,weight: FontWeight.bold,color: Colors.white,)
              ),
                    CustomText1(text: 'Signin to your Account', size: 20,),    
        
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child:  SizedBox(
                height: 50,
                width: 320,
                child: TextFormField(cursorColor: Colors.teal,
                  style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white)),
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
                      label: CustomText1(text: 'E-mail', size: 13),
                      border: OutlineInputBorder(
                      
                          borderRadius: BorderRadius.circular(10))),
                          
                ),
              ),
              ),
               Padding(
                padding: const EdgeInsets.only(top: 20),
                child:  SizedBox(
                height: 50,
                width: 320,
                child: TextFormField(cursorColor: Colors.teal,
                  style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white)),
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
                      label: CustomText1(text: 'Password', size: 13),
                      border: OutlineInputBorder(
                      
                          borderRadius: BorderRadius.circular(10))),
                          
                ),
              ),
              ),
             
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: SizedBox(
                  width: 300,
                  child: ElevatedButton(onPressed: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => AdminHome(),));
                  },
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    backgroundColor: WidgetStatePropertyAll(Colors.teal)),
                   child:
                   CustomText1(text: 'Login', size: 16)
                   ),
                ),
              ),
           
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,top: 60),
                child: Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: CustomText1(text: 'or', size: 12),
                    ),
                     Expanded(child: Divider()),
                  ],
                ),
              ),
                Padding(
                padding: const EdgeInsets.only(top: 60),
                child: SizedBox(
                 
                  width: 300,
                  child: ListTile(
                    minTileHeight: 50,
                    leading: Image.asset('images/google 2.png'),
                    title: Center(child: CustomText1(text: 'Login with Google', size: 15,)),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 0.5,color: Colors.white),
                      borderRadius: BorderRadius.circular(10),),
                  ))
              ),
            
               
            
            ],
          ),
        ),
      ),
    ),
    );
  }
}