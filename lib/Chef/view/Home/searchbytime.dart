import 'package:flutter/material.dart';
import 'package:flavour_fusion/widgets/custom_appbar.dart';
import 'package:flavour_fusion/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Searchbytimesuser extends StatefulWidget {
  const Searchbytimesuser({super.key});

  @override
  State<Searchbytimesuser> createState() => _SearchbyitimesuserState();
}

class _SearchbyitimesuserState extends State<Searchbytimesuser> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: ClipRRect(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
          child: CustomAppBar(title: 'Search',weight: FontWeight.bold,))),
          body: Center(
            child: Column(
            
              children: [
                 Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: SizedBox(
                    height: 50,
                    width: 320,
                    child: TextFormField(
                      cursorColor: Colors.teal,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(color: Colors.white)),
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Search by Time',
                          hintStyle: GoogleFonts.poppins(
                              textStyle:
                                  TextStyle(fontSize: 15.sp, color: Colors.white60)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ),
               Padding(
                 padding: const EdgeInsets.only(top: 20),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     _button(Colors.grey[800], '5 min'),
                      _button(Colors.grey[800], '10 min'),
                   ],
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.only(top: 30),
                 child: _button(Colors.grey[800], '30 min'),
               ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: _button(Colors.teal, 'Search')
                    ),
                  ),
                ),
                
              ],
            ),
          ),
    );
  }
}
class _button extends StatelessWidget{
  final Color? color;
  final String text;
  _button(this.color,this.text);
  @override
  Widget build(BuildContext context){
    return  ElevatedButton(onPressed: () {
                  
                },
                style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(color)),
                 child: CustomText1(text: text,size: 15,));
  }
}