import 'package:flavour_fusion/Chef/controller/chef_RegisterController.dart';
import 'package:flavour_fusion/Chef/model/chef_Register_Model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flavour_fusion/Chef/view/Login/Login.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterChef extends StatefulWidget {
  const RegisterChef({super.key});

  @override
  State<RegisterChef> createState() => _RegisterChefState();
}

class _RegisterChefState extends State<RegisterChef> {
  final _formkey = GlobalKey<FormState>();
  final _namecontroller = TextEditingController();
  final _emailcontroller = TextEditingController();

  final _passwordcontroller = TextEditingController();
  final chef_RegisterController _chef_registerController=chef_RegisterController();
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
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
                    padding: const EdgeInsets.only(top: 30),
                    child: SizedBox(
                     
                      width: 320,
                      child: TextFormField(
                        controller: _namecontroller,
                         validator: (value) {
                            if (value == null || value.isEmpty) {
                            return 'Field cannot be empty';
                          }
                          return null;
                        },
                        cursorColor: Colors.teal,
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
                      child:  Container(
                        height: 60,
            width: 320,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white60, width: 0.5),
            ),
            child: FormField<String>(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a gender';
                }
                return null;
              },
              builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                    border: InputBorder.none,
                  ),
                  isEmpty: selectedValue == null,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
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
                        state.didChange(value);
                      },
                      dropdownStyleData: DropdownStyleData(
                        offset: Offset(0, -10),
                        decoration: BoxDecoration(
                          color: Color(0xff313131),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: SizedBox(
                      
                      width: 320,
                      child: TextFormField(
                        controller: _emailcontroller,
                        validator: (value) {
                            if (value == null || value.isEmpty) {
                            return 'Field cannot be empty';
                          }
                          return null;
                        },
                        cursorColor: Colors.teal,
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
                     
                      width: 320,
                      child: TextFormField(
                        controller: _passwordcontroller,
                         validator: (value) {
                            if (value == null || value.isEmpty) {
                            return 'Field cannot be empty';
                          }
                          return null;
                        },
                        cursorColor: Colors.teal,
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
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                       SizedBox(
                    width: 10,
                  ),
                      CustomText1(text: 'Documents', size: 20,weight: FontWeight.bold,),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 200,
                    width: 300,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.grey[800]),
                    child: IconButton(onPressed: () {
                      
                    }, icon: Icon(Icons.add,color: Colors.white,size: 45,)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:40),
                    child: SizedBox(
                          width: 320,
                          child: ElevatedButton(onPressed: () {
                            if(_formkey.currentState!.validate()){
                              Chef_Register_Model chefregister=Chef_Register_Model(
                                name: _namecontroller.text,
                                email: _emailcontroller.text,
                                gender: selectedValue,
                                password: _passwordcontroller.text
                              );
                              _chef_registerController.chefRegister(chefregister, context);
                              setState(() {
                                 _namecontroller.clear();
                              _emailcontroller.clear();
                              _passwordcontroller.clear();
                              selectedValue=null;
                              });
                             
                            }
                          },
                          style: ButtonStyle(
                            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                            backgroundColor: WidgetStatePropertyAll(Colors.teal)),
                           child:
                           CustomText1(text: 'Submit', size: 16)
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
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ChefLogin(),));
                            },
                            
                            text: "Login",
                            style: GoogleFonts.poppins(textStyle: TextStyle(color: Color(0xff2420F1)))
                          )
                        ]
                      )),
                    ),
                     Padding(
                      padding: const EdgeInsets.only(top: 30),
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
      ),
    );
  }
}
