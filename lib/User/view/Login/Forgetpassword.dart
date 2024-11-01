import 'package:flavour_fusion/Chef/controller/forgetpassword_controller.dart';
import 'package:flavour_fusion/Chef/model/chef_forgetpass_model.dart';
import 'package:flavour_fusion/User/controller/user_forgetpasswordconttroller.dart';
import 'package:flavour_fusion/User/model/user_forgetmodel.dart';
import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:google_fonts/google_fonts.dart';

class UserForgetPassword extends StatefulWidget {
  const UserForgetPassword({super.key});

  @override
  State<UserForgetPassword> createState() => _UserForgetPasswordState();
}

class _UserForgetPasswordState extends State<UserForgetPassword> {
  final TextEditingController _emailController = TextEditingController();
  final User_ForgetPasswordcontroller _user_forgetPasswordcontroller =
      User_ForgetPasswordcontroller();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            )),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 150,
                ),
                child: Center(
                    child: CustomText1(
                  text: 'Forget Password',
                  size: 24,
                  color: Colors.white,
                  weight: FontWeight.bold,
                )),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 100, left: 30),
                    child: CustomText1(text: 'Enter your email', size: 14),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 30),
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
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
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
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          user_forgetpass_model userpassreset =
                              user_forgetpass_model(
                                  email: _emailController.text);
                          _user_forgetPasswordcontroller.userresetpass(
                              userpassreset, context);
                        }
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                          backgroundColor: WidgetStatePropertyAll(Colors.teal)),
                      child: CustomText1(text: 'Confirm', size: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
