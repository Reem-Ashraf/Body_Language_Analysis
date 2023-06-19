import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/view/componant/pages/authonication/sign_up.dart';
import 'package:graduation_project/view/componant/pages/lay_out/HomeLayOut.dart';
import 'package:graduation_project/view/componant/pages/lay_out/myHomePage.dart';
import 'package:lottie/lottie.dart';

import '../../../../model/shaerd_prefrense/shaerd_prefrense.dart';
import '../../../../view_model/login/login_cubit.dart';
import '../../core/constant.dart';

class Login extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  String? PasswordError;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) async
          {
            // TODO: implement listener
            if(state is LoginSucessState){
                print("llll");
               await  CacheHelper.saveData(key: accessTokenKey, value: state.loginModel!.accessToken);
                print('Login Goooooo');
                print(state.loginModel!.accessToken);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
                  return HomeLayOut();
                }
                ));print("rrrr");
                 final snackBar= SnackBar(
                  /// need to set following properties for best effect of awesome_snackbar_content
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'Gratefull',
                    message:
                    'Login Success',

                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                    contentType: ContentType.success,
                  ),
                );
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);

                if(state.loginModel?.message != null){
                  print(state.loginModel?.message);

                }else{
                  print(state.loginModel?.message);

                }
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Row(
                children: [
                  Expanded(
                    child: Container(
                        color: Colors.white,
                        height: double.infinity,
                        //width: 700,
                        child:Lottie.asset('assets/login.json')),
                  ),
                  //  SizedBox(width: 20,),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Center(
                        child: Form(
                          key: formkey,
                          child: Column(
                            //  mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Login Account",
                                style: GoogleFonts.poppins(
                                    fontSize: 30, color: Color(0xff2A3164)),

                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Container(
                                  width: 300,
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: emailController,
                                    decoration: InputDecoration(
                                        errorText: PasswordError,
                                        labelText: "Email",
                                        labelStyle: GoogleFonts.poppins(
                                            color: Color(0xff334e56))),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "This field musn't empty";
                                      } else {
                                        final RegExp emailValidatorRegExp = RegExp(
                                            r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                                        if (!emailValidatorRegExp.hasMatch(value)) {
                                          return 'email  not valid';
                                        }
                                      }
                                      return null;
                                    },
                                  )),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: 300,
                                child: BlocBuilder<LoginCubit, LoginStates>(
                                    builder: (context, state) {
                                      return TextFormField(
                                        onFieldSubmitted: (value){
                                          if(formkey.currentState!.validate()){
                                            LoginCubit.Get(context).userLogin(
                                                email: emailController.text,
                                                password: passwordController.text);

                                          }

                                        },
                                        controller: passwordController,
                                        keyboardType: TextInputType.visiblePassword,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "This field musn't empty";
                                          }
                                          return null;
                                        },
                                        obscureText: LoginCubit.Get(context).isSecure,
                                        decoration: InputDecoration(
                                            labelText: "Password",
                                            labelStyle: GoogleFonts.poppins(
                                                color: Color(0xff334e56)),
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                LoginCubit.Get(context).ObSecure();
                                              },

                                              icon: LoginCubit.Get(context).suffixIcon,
                                            )),
                                      );
                                    }),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () {},
                                child: Text(
                                  "Forgot Password?",
                                  style: GoogleFonts.poppins(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xff2A3164)),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 300,
                                height: 40,
                                child: ConditionalBuilder(
                                    condition: state is!LoginLoadingState,
                                    builder: (context)=>Material(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0)),
                                        color: Color(0xff2A3164),
                                        child: MaterialButton(
                                          hoverColor: Color(0xff181d43),
                                          onPressed: () {

                                            if (formkey.currentState!.validate()) {
                                              LoginCubit.Get(context).userLogin(
                                                  email: emailController.text,
                                                  password: passwordController.text);
                                              print("${emailController.text}");
                                              print("${passwordController.text}");
                                            }
                                          },
                                          child: Text("Login",
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    fallback:(context)=> CircularProgressIndicator()),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 300,
                                height: 40,
                                child: Material(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0)),
                                  color: Color(0xff2A3164),
                                  child: MaterialButton(
                                    hoverColor: Color(0xff181d43),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SignUp()));
                                    },
                                    child: Text("Sign Up",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        )
        );
  }
}
