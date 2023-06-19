import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/view/componant/pages/screens%20in%20Home%20Page/ChangePassword.dart';
import 'package:graduation_project/view_model/UserModel/user_model_cubit.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>UserModelCubit()..profile(),
      child: BlocConsumer<UserModelCubit, UserModelState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          UserModelCubit userModelCubit=UserModelCubit.get(context);
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
                        height: 300,
                        width: 700,
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
                          padding: const EdgeInsets.all(40.0),
                          child: Column(
                            //  crossAxisAlignment: CrossAxisAlignment.center,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "User Profile",
                                    style: GoogleFonts.poppins(
                                        fontSize: 30, color: Color(0xff2A3164)),

                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 700,
                                height: 1,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Name : ",
                                    style: GoogleFonts.poppins(
                                        fontSize: 20, color: Color(0xff2A3164)),

                                  ),
                                  SizedBox(width: 5,),
                                //  Text("ggdf"),
                                  Text(userModelCubit.userModel?.name ?? "error name",
                                    style: GoogleFonts.poppins(
                                        fontSize: 20, color: Color(0xff2A3164)),)
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "E-Mail : ",
                                    style: GoogleFonts.poppins(
                                        fontSize: 20, color: Color(0xff2A3164)),

                                  ),
                                  SizedBox(width: 5,),
                                  Text(userModelCubit.userModel?.email ?? "error email",
                                    style: GoogleFonts.poppins(
                                        fontSize: 20, color: Color(0xff2A3164)),)
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Change Password : ",
                                    style: GoogleFonts.poppins(
                                        fontSize: 20, color: Color(0xff2A3164)),

                                  ),
                                  SizedBox(width: 10,),
                                  Container(
                                    width: 250,
                                    child: MaterialButton(
                                        hoverColor: Color(0xff2A3164),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(
                                                5.0)),
                                        onPressed: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => ChangePassword()));
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8,
                                              horizontal: 25),
                                          child: Text('Change Password',style: TextStyle(color: Colors.white),),
                                        ),
                                        color: Color(0xff181d43)),
                                  ),
                                ],
                              ),
                            ],
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
