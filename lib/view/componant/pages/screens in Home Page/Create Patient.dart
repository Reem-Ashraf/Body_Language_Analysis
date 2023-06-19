import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/view_model/History/history_cubit.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

import '../../../../model/shaerd_prefrense/shaerd_prefrense.dart';
import '../../core/constant.dart';
class CreatePatient extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.,
          children: [
            Text("Create new Patient :-",
                style: GoogleFonts.poppins(
                    color: Color(0xff2A3164),fontSize: 25)),
            SizedBox(height: 15,),
            Container(
              width: 620,
             // height: 40,
              //color: Colors.purple,
              child: TextFormField(

                controller: nameController,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "This field mustn't empty";
                  }
                  return null;
                },
                decoration: InputDecoration(

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),

                      ),
                    )),
              ),
            ),
            SizedBox(height: 15,),
            Container(),
               // Spacer(),
            SizedBox(
              height: 40,
              width: 200,
              child: MaterialButton(
                  hoverColor: Color(0xff8a8edb),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(
                          8.0)),
                  onPressed: ()async{
                    if (formkey.currentState!.validate()) {
                      String token = await CacheHelper.getData(key: accessTokenKey);
                      var headers = {
                        'Authorization': 'Bearer ${token ?? ''}',
                        'Content-Type': 'application/json'
                      };
                      var request = http.Request('POST', Uri.parse('http://127.0.0.1:8000/api/patient/create'));
                      request.body = json.encode({
                        "name": nameController.text
                      });
                      request.headers.addAll(headers);

                      http.StreamedResponse response = await request.send();

                      if (response.statusCode == 200) {
                        print(await response.stream.bytesToString());
                        final snackBar= SnackBar(
                          /// need to set following properties for best effect of awesome_snackbar_content
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: 'Gratefull',
                            message:
                            'Patient created Success',

                            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                            contentType: ContentType.success,
                          ),
                        );
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                      }
                      else {
                        print(response.reasonPhrase);
                        final snackBar= SnackBar(
                          /// need to set following properties for best effect of awesome_snackbar_content
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: 'oooops',
                            message:
                            " can't create this patient",

                            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                            contentType: ContentType.failure,
                          ),
                        );
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                      };

                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 25),
                    child: Text('Create',style: TextStyle(color: Colors.white),),
                  ),
                  color: Color(0xff2A3164)),
            )

          ],
        ),
      ),
    );
  }
}
