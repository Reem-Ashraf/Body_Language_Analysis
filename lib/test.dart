
import 'package:flutter/material.dart';

class test extends StatelessWidget {
  const test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.deepPurple[300],
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Container(
          width: 300,
            child: TextFormField(decoration: InputDecoration(labelText: "Email"),)),
          SizedBox(height: 15,),
          Container(
              width: 300,
              child: TextFormField(
                decoration: InputDecoration(labelText: "Password",suffixIcon: Icon(Icons.remove_red_eye)),)),
          SizedBox(height: 20,),
         Container(
           width: 300,
           height: 40,
           child: Material(
             shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(10.0)),
             color: Colors.deepPurple,
             child: MaterialButton(
                 onPressed: (){},
               child: Text("Log In"),


             ),
           ),
         )
      ],),
    ),);
  }
}
