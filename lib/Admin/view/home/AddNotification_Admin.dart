import 'package:flavour_fusion/Admin/view/home/Home.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flavour_fusion/widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';

class AddnotificationAdmin extends StatefulWidget {
  const AddnotificationAdmin({super.key});

  @override
  State<AddnotificationAdmin> createState() => _AddnotificationAdminState();
}

class _AddnotificationAdminState extends State<AddnotificationAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Add Notification',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminHome(),
                  ));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CustomText1(
                    text: 'Add Title : ',
                    color: Colors.white,
                    weight: FontWeight.w600,
                    size: 18,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomTextformfield(
                hintText: 'Add Title',
                hintStyle: TextStyle(color: Colors.white70),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CustomText1(
                    text: 'Add Content : ',
                    color: Colors.white,
                    weight: FontWeight.w600,
                    size: 18,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CustomTextformfield(
                height: 200,
                maxLines: 10,
                hintText: 'Add Content',
                hintStyle: TextStyle(color: Colors.white70),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                    onPressed: () {},
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
