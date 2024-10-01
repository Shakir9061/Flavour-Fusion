import 'package:flavour_fusion/User/view/Login/Login.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:google_fonts/google_fonts.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: CustomText1(
                    text: 'Sign Up',
                    size: 36,
                    weight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: CustomText1(
                  text: 'Create your account',
                  size: 18,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: SizedBox(
                  height: 50,
                  width: 320,
                  child: TextFormField(cursorColor: Colors.teal,
                    style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white)),
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
                        label: CustomText1(text: 'Name', size: 13),
                        border: OutlineInputBorder(
                        
                            borderRadius: BorderRadius.circular(10))),
                            
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    height: 50,
                    width: 320,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white60, width: 0.5)),
                    child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                      value: selectedValue,
                      hint: CustomText1(text: 'Select gender', size: 13),
                      isExpanded: true,
                      items: <String>['Male', 'Female']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: CustomText1(text: value, size: 13),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value;
                        });
                      },
                      dropdownStyleData: DropdownStyleData(
                          offset: Offset(0, -10),
                          decoration: BoxDecoration(
                            color:Color(0xff313131),
                              borderRadius: BorderRadius.circular(10))),
                    )),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: SizedBox(
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
                padding: const EdgeInsets.only(top: 15),
                child: SizedBox(
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
                padding: const EdgeInsets.only(top:40),
                child: SizedBox(
                      width: 320,
                      child: ElevatedButton(onPressed: () {
                        
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
                  padding: const EdgeInsets.only(top: 10),
                  child: Text.rich(TextSpan(
                    children: [
                      TextSpan(
                        text: "Already have an account?",
                        style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white))
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                        ..onTap=(){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginUser(),));
                        },
                        
                        text: "Login",
                        style: GoogleFonts.poppins(textStyle: TextStyle(color: Color(0xff2420F1)))
                      )
                    ]
                  )),
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
    );
  }
}
