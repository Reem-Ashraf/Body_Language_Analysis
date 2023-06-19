import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: ClipRRect(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
          child: Container(
            padding: EdgeInsets.all(60),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft:Radius.circular(50), )),
            child: Row(children: [
              Container(
               // padding: EdgeInsets.only(top: 40),
                child: Column(
               // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Welcome",style: GoogleFonts.poppins(color: Color(0xff666bd5),
                        shadows:<Shadow>[
                          Shadow(

                           //offset: Offset(50.0, 50.0),
                           blurRadius: 5,
                           color:  Color(0xff2A3164),
                          ),
                        ]
                        ,fontSize: 40
                    ),),
                    SizedBox(height: 20,),
                    Text("let's start ....",
                        style: GoogleFonts.poppins(color: Color(0xff2A3164),fontSize: 16)),
                    Text("your journey of body language analysis",
                        style: GoogleFonts.poppins(color: Color(0xff2A3164),fontSize: 16)),
                  ],
                ),
              ),
              SizedBox(width: 40,),
              Flexible(child: Container(
                child: Lottie.asset('assets/welcomePage.json')
                ),
              )
            ],),
          ),
        ),
      ),
    );
  }
}
