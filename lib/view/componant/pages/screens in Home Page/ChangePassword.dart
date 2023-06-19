import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/view/componant/pages/authonication/sign_up.dart';
import 'package:graduation_project/view_model/login/login_cubit.dart';
import 'package:graduation_project/view_model/sign_up/sign_up_cubit.dart';
import 'package:http/http.dart' as http;

import '../../core/constant.dart';

class ChangePassword extends StatelessWidget {
//const ChangePassword({Key? key}) : super(key: key);
  var passwordController=TextEditingController();
  var newPasswordController=TextEditingController();
  var confirmPasswordController=TextEditingController();
  var formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext)=>SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                  backgroundColor:  Color(0xff2A3164),
                  elevation: 0,
                  leading: IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon:Icon(Icons.keyboard_arrow_left,color: Colors.white,size: 35,),)
              ),
              body: Container(
                decoration: BoxDecoration(color: Color(0xff2A3164)),
                child: Padding(
                  padding:
                  const EdgeInsets.only(right: 20, bottom: 20, left: 20),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50)),
                        color: Colors.white),
                    child: Center(
                      child:
                      Container(
                        height: 530,
                        width: 600,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(9),
                          boxShadow: [
                            BoxShadow(
                              color:   Color(0xff2A3164),
                              blurRadius: 6,
                              offset: Offset(1, 1), // Shadow position
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Form(
                            key: formkey,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Text(
                                    "Change Password",
                                    style: GoogleFonts.poppins(
                                        fontSize: 25, color: Color(0xff2A3164)),

                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  Container(
                                    width: 700,
                                    height: 1,
                                    color: Colors.grey,
                                  ),

                                  Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Old Password",
                                        style: GoogleFonts.poppins(
                                            fontSize: 15, color: Color(0xff2A3164)),

                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                          width: 500,
                                          child: TextFormField(
                                            keyboardType:TextInputType.visiblePassword,
                                             controller: passwordController,
                                            //keyboardType: TextInputType.visiblePassword,
                                            //controller:confirmPasswordController,
                                            obscureText: SignUpCubit.Get(context).secure,
                                            decoration: InputDecoration(
                                                hintText: "Enter Your Old Password",
                                                suffixIcon: IconButton(onPressed: (){
                                                  SignUpCubit.Get(context).Secure();
                                                },
                                                  icon:SignUpCubit.Get(context).suffixIcon2 ,),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(Radius.circular(10)))),
                                            validator: (value){
                                              if(value!.isEmpty){
                                                return "This field musn't be empty";
                                              }
                                              return null;
                                            },)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "New Password",
                                        style: GoogleFonts.poppins(
                                            fontSize: 15, color: Color(0xff2A3164)),

                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                          width: 500,
                                          child: TextFormField(
                                            keyboardType:TextInputType.visiblePassword,
                                            controller: newPasswordController,
                                            obscureText: SignUpCubit.Get(context).isSecure,
                                            decoration: InputDecoration(
                                                hintText: "Enter Your New Password",
                                                suffixIcon: IconButton(onPressed: (){
                                                  SignUpCubit.Get(context).ObSecure();
                                                },
                                                  icon:SignUpCubit.Get(context).suffixIcon ,),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(Radius.circular(10)))),
                                            validator: (value){
                                              if(value!.isEmpty){
                                                return "This field musn't be empty";
                                              }
                                              return null;
                                            },)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Confirm Password",
                                        style: GoogleFonts.poppins(
                                            fontSize: 15, color: Color(0xff2A3164)),

                                      ),

                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                          width: 500,
                                          child: TextFormField(
                                            keyboardType:TextInputType.visiblePassword,
                                              controller: confirmPasswordController,
                                              obscureText: SignUpCubit.Get(context).isSecure,
                                              decoration: InputDecoration(
                                                  hintText: "Confirm Your New Password",
                                                  suffixIcon: IconButton(onPressed: (){
                                                    SignUpCubit.Get(context).ObSecure();
                                                  },
                                                    icon:SignUpCubit.Get(context).suffixIcon ,),

                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.all(Radius.circular(10)))),
                                            validator: (value){
                                              if(value!.isEmpty){
                                                return "This field musn't be empty";
                                              }
                                              if(value!=newPasswordController.text){
                                                return "This Password not matching";
                                              }
                                              return null;
                                            },)),

                                      SizedBox(
                                        height: 15,
                                      ),

                                    ],
                                  ),
                                  Container(
                                    width: 250,
                                    height: 40,
                                    child: MaterialButton(
                                        hoverColor: Color(0xff2A3164),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(
                                                5.0)),
                                        onPressed: ()async{
                                          if(formkey.currentState?.validate() ?? true){
                                            var headers = {
                                              'Content-Type': 'application/json',
                                              'Authorization': 'Bearer ${token ?? ''}'
                                            };
                                            var request = http.Request('PUT', Uri.parse('http://127.0.0.1:8000/api/changePassword'));
                                            request.body = json.encode({
                                              "old_password": passwordController.text,
                                              "new_password": newPasswordController.text,
                                              "confirm_password": confirmPasswordController.text
                                            });
                                            request.headers.addAll(headers);

                                            http.StreamedResponse response = await request.send();

                                            if (response.statusCode == 200) {
                                              print(await response.stream.bytesToString());
                                              final snackBar = SnackBar(
                                                /// need to set following properties for best effect of awesome_snackbar_content
                                                elevation: 0,
                                                behavior: SnackBarBehavior.floating,
                                                backgroundColor: Colors.transparent,
                                                content: AwesomeSnackbarContent(
                                                  title: 'Gratefully',
                                                  message:
                                                  'Password Update Successfully',

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
                                          final snackBar = SnackBar(
                                            /// need to set following properties for best effect of awesome_snackbar_content
                                            elevation: 0,
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.transparent,
                                            content: AwesomeSnackbarContent(
                                              title: 'oops',
                                              message:
                                              ' Change Password  Error',

                                              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                              contentType: ContentType.failure,
                                            ),
                                          );

                                          ScaffoldMessenger.of(context)
                                            ..hideCurrentSnackBar()
                                            ..showSnackBar(snackBar);

                                            }


                                        }
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8,
                                              horizontal: 25),
                                          child: Text('Change',style: TextStyle(color: Colors.white),),
                                        ),
                                        color: Color(0xff181d43)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // const SizedBox(height: 5),
                      // ImageStream()
                      //Image.network('${request}')


                    ),
                  ),
                ),
              )
          );
        },
      )
    );
  }
}