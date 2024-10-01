import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flavour_fusion/Admin/view/home/chefverify.dart';

class ChefRequest extends StatefulWidget {
  const ChefRequest({super.key});

  @override
  State<ChefRequest> createState() => _ChefRequestState();
}

class _ChefRequestState extends State<ChefRequest> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
            backgroundColor: Colors.black,

    
      body:   Center(
        child: Column(
          
          children: [
            Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: SizedBox(
                      height: 60,
                      width: 350,
                      child: ListTile(
                        tileColor: Color(0xff313131),
                        leading: CircleAvatar(),
                        title: CustomText1(text: 'Chef', size: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Chefverify(),));
                        },
                      ),
                    ),
                  ),
          ],
        ),
      )
    );
  }
}