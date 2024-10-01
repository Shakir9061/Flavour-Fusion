import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flavour_fusion/Chef/view/Login/Login.dart';

class ChefUpdatePassword extends StatefulWidget {
  const ChefUpdatePassword({super.key});

  @override
  State<ChefUpdatePassword> createState() => _ChefUpdatePasswordState();
}

class _ChefUpdatePasswordState extends State<ChefUpdatePassword> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ChefLogin(),));
          },
          icon: Icon(Icons.arrow_back,color: Colors.white,size: 30,)),
      ),
      backgroundColor: Colors.black,
       body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100,),
              child: Center(child: CustomText1(text: 'Update Password', size: 24,color: Colors.white,weight: FontWeight.bold,)),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100,left: 30),
                  child: CustomText1(text: 'New password', size: 14),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10,left: 30),
                  child: SizedBox(
                        height: 50,
                        width: 300,
                        child: TextFormField(
                          decoration: InputDecoration(
                           
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                        ),
                      ),
                ),
              ],
            ),
               Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20,left: 30),
                  child: CustomText1(text: 'Confirm password', size: 14),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10,left: 30),
                  child: SizedBox(
                        height: 50,
                        width: 300,
                        child: TextFormField(
                          decoration: InputDecoration(
                           
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
    );
  }
}