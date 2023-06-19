import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/view/componant/pages/lay_out/HomeLayOut.dart';
import 'package:graduation_project/view/componant/pages/lay_out/myHomePage.dart';
import 'package:graduation_project/view_model/sign_up/sign_up_cubit.dart';
import 'package:particles_flutter/particles_flutter.dart';

import '../../../../model/shaerd_prefrense/shaerd_prefrense.dart';
import '../../../../model/signup_model/signup_model.dart';
import '../../core/constant.dart';
import 'login.dart';

class SignUp extends StatelessWidget {
  var formkey=GlobalKey<FormState>();
  var nameConntroller=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var confirmPasswordController=TextEditingController();
  late SignupModel signupModel;
  // List<String> items=["Student","Doctor"];
  // String?SelectionItem="Choice";

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (BuildContext)=>SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if(state is SignupSuccessState){
            Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) {
              return Login();
            }
            ));
            final snackBar = SnackBar(
              /// need to set following properties for best effect of awesome_snackbar_content
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: 'Gratefull',
                message:
                'Sign Up Success',

                /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                contentType: ContentType.success,
              ),
            );

            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBar);
          }
          else if(state is SignupErrorState) {
            final snackBar = SnackBar(
              /// need to set following properties for best effect of awesome_snackbar_content
              elevation: 0,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.transparent,
              content: AwesomeSnackbarContent(
                title: 'oooops',
                message:
                'Sign Up Error',

                /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                contentType: ContentType.failure,
              ),
            );

            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBar);

          };
          // if(state is SignupSuccessState){
          //   print("llll");
          //   //CacheHelper.saveData(key: accessTokenKey, value: state.loginModel!.accessToken);
          //   print('Login Goooooo');
          //   //print(state.loginModel!.accessToken);
          //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
          //     return Login();
          //   }));
          //
          //   // if(state.?.message != null){
          //   //   print(state.loginModel?.message);
          //   //
          //   // }else{
          //   //   print(state.loginModel?.message);
          //   //
          //   // }
          // }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon:Icon(Icons.keyboard_arrow_left,color: Color(0xff181d43),size: 35,),),),

            body: SingleChildScrollView(
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Center(
                    //
                    //   child: Image(
                    //   height: 600,
                    //    // width: 1360,
                    //     fit: BoxFit.fill,
                    //       image: AssetImage(
                    //           'assets/signup.PNG')),
                    // )
                    Center(
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white),
                        key: UniqueKey(),
                        child: Center(
                          child: CircularParticle(
                            // key: UniqueKey(),
                            awayRadius: 80,
                            numberOfParticles: 80,
                            speedOfParticles: 1,
                            height: screenHeight,
                            width: screenWidth,
                            onTapAnimation: true,
                            particleColor:Color(0xff2A3164) ,
                            awayAnimationDuration: Duration(milliseconds: 700),
                            maxParticleSize: 6,
                            isRandSize: true,
                            isRandomColor: true,
                            randColorList: [
                              Color(0xff2A3164)
                            ],
                            awayAnimationCurve: Curves.easeInOutBack,
                            enableHover: true,
                            hoverColor: Color(0xffda5f4e),
                            hoverRadius: 90,
                            connectDots: false, //not recommended
                          ),
                        ),
                      ),
                    )
                    ,
                    Center(
                      child: BlocBuilder<SignUpCubit, SignUpState>(
                        builder: (context, state) {

                          SignUpCubit signupCubit = SignUpCubit.Get(context);
                          return Form(
                            key: formkey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Sign Up ",style: GoogleFonts.poppins(fontSize: 35,color: Color(0xff2A3164)),),
                                SizedBox(height: 20,),
                                Text("Name",style:  GoogleFonts.poppins(color:Color(0xff334e56)),),
                                SizedBox(height: 10,),
                                Container(
                                    width: 400,
                                    child: TextFormField(
                                      controller:nameConntroller ,
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(10),
                                            ),)
                                      ),
                                      validator: (value){
                                        if(value!.isEmpty){
                                          return "This field musn't be empty";
                                        }
                                        return null;
                                      },
                                    )),
                                SizedBox(height: 10,),
                                Text("Email",style:  GoogleFonts.poppins(color:Color(0xff334e56))),
                                SizedBox(height: 10,),
                                Container(
                                    width: 400,
                                    child: TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      controller:emailController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(10))),),
                                      validator: (value){
                                        if(value!.isEmpty){
                                          return "This field musn't be empty";
                                        }
                                        return null;
                                      },)),
                                SizedBox(height: 10,),
                                Text("Password",style:  GoogleFonts.poppins(color:Color(0xff334e56))),
                                SizedBox(height: 10,),
                                Container(
                                    width: 400,
                                    child: TextFormField(
                                      keyboardType:TextInputType.visiblePassword,
                                      controller: passwordController,
                                      obscureText: SignUpCubit.Get(context).isSecure,
                                      decoration: InputDecoration(
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
                                SizedBox(height: 10,),
                                Text("Confirm Password",style:  GoogleFonts.poppins(color:Color(0xff334e56))),
                                SizedBox(height: 10,),
                                Container(
                                    width: 400,
                                    child: TextFormField(
                                      keyboardType: TextInputType.visiblePassword,
                                      controller:confirmPasswordController,
                                      obscureText: SignUpCubit.Get(context).secure,
                                      decoration: InputDecoration(
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
                                        if(value!=passwordController.text){
                                          return "This Password not matching";
                                        }
                                        return null;
                                      },
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                    )),
                                SizedBox(height: 20,),

                                SizedBox(height: 20,),
                                Container(
                                  width: 400,
                                  height: 50,
                                  child: Material(

                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0)),
                                    color: Color(0xff2A3164),
                                    child: MaterialButton(
                                      hoverColor:Color(0xff181d43) ,
                                      onPressed: (){
                                        if(formkey.currentState?.validate() ?? true){

                                          signupCubit.postSignup(
                                              context,
                                              nameConntroller.text,
                                              emailController.text,
                                              passwordController.text,
                                              confirmPasswordController.text);

                                        }
                                      },
                                      child: Text("Sign Up",style:GoogleFonts.poppins(fontWeight:FontWeight.bold,color: Colors.white)),

                                    ),
                                  ),
                                ),



                              ],),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),);
        },
      )

    );
  }
}
