import 'package:flavour_fusion/Chef/controller/forgetpassword_controller.dart';
import 'package:flavour_fusion/Chef/model/chef_forgetpass_model.dart';
import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flavour_fusion/Chef/view/Login/updatepassword.dart';
import 'package:google_fonts/google_fonts.dart';

class ChefForgetPassword extends StatefulWidget {
  const ChefForgetPassword({super.key});

  @override
  State<ChefForgetPassword> createState() => _ChefForgetPasswordState();
}

class _ChefForgetPasswordState extends State<ChefForgetPassword> {
    final TextEditingController _emailController = TextEditingController();
    final Chef_ForgetPasswordcontroller _chef_forgetPasswordcontroller=Chef_ForgetPasswordcontroller();
final _formkey = GlobalKey<FormState>();  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,color: Colors.white,size: 30,)),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 150,),
                child: Center(child: CustomText1(text: 'Forget Password', size: 24,color: Colors.white,weight: FontWeight.bold,)),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 100,left: 30),
                    child: CustomText1(text: 'Enter your email', size: 14),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10,left: 30),
                    child: SizedBox(
                         
                          width: 300,
                          child: TextFormField(
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                          return 'Field cannot be empty';
                        }
                        return null; 
                            },
                              style: GoogleFonts.poppins(
                            textStyle: TextStyle(color: Colors.white)),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: SizedBox(
                      width: 300,
                      child: ElevatedButton(onPressed: () {
                        if(_formkey.currentState!.validate()){
                        chef_forgetpass_model chefpassreset=  chef_forgetpass_model(email: _emailController.text);
                          _chef_forgetPasswordcontroller.chefresetpass(chefpassreset, context);
                        }
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                        backgroundColor: WidgetStatePropertyAll(Colors.teal)),
                       child:
                       CustomText1(text: 'Confirm', size: 16)
                       ),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}