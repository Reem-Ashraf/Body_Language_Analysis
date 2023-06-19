import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/view/componant/pages/screens%20in%20Home%20Page/camera_detection.dart';
import 'package:graduation_project/view_model/Camera_Scanning/camera_cubit.dart';
import 'package:graduation_project/view_model/Camera_Scanning/camera_state.dart';
import 'package:lottie/lottie.dart';

class CameraScreen extends StatelessWidget {
   CameraScreen({Key? key}) : super(key: key);
  PatientCubit profile =PatientCubit();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      profile
        ..getPatients(),
      child: BlocConsumer<PatientCubit, PatientStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: (state is PatientLoadingState) ? Center(child: CircularProgressIndicator(),):(state is PatientErrorState)?
            Center(child: Lottie.asset('assets/Main.json'),):
            Stack(
              children: [
                Center(
                  child: Image(
                      height: 1050,
                      width: 1850,
                      //   fit: BoxFit.fitWidth,
                      image: AssetImage('assets/camera background2.jpeg')),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // SizedBox(height: 10,),
                      Column(
                        children: [
                          Text("Body Analysis",
                            style: GoogleFonts.poppins(color: Color(0xff666bd5),
                                shadows: <Shadow>[
                                  Shadow(

                                    //offset: Offset(50.0, 50.0),
                                    blurRadius: 5,
                                    color: Color(0xff2A3164),
                                  ),
                                ],
                                // fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),),
                          Container(
                            // width: 200,
                            height: 100,
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BlocProvider.value(
                                                value:
                                                profile,
                                                child: CameraDetection(),
                                              )));
                                },
                                child: Lottie.asset(
                                    'assets/10521-face-scan.json')),
                            padding: EdgeInsets.all(16),

                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),);
        },
      ),
    );
  }
}
