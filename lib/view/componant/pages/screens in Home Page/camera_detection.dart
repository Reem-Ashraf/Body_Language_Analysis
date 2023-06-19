
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/model/shaerd_prefrense/shaerd_prefrense.dart';
import 'package:graduation_project/view_model/Camera_Scanning/camera_cubit.dart';
import 'package:graduation_project/view_model/Camera_Scanning/camera_state.dart';
import 'package:http/http.dart' as http;
import 'package:desktop_webview_window/desktop_webview_window.dart';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:convert';

import '../../../../view_model/History/history_cubit.dart';
import '../../core/constant.dart';

class CameraDetection extends StatefulWidget {
  @override
  State<CameraDetection> createState() => _CameraDetectionState();
}

class _CameraDetectionState extends State<CameraDetection> {
  TextEditingController nameController = TextEditingController();

  TextEditingController idController = TextEditingController();

  var request = http.Request('GET', Uri.parse('http://127.0.0.1:8000/stream'));

  var formkey = GlobalKey<FormState>();

  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PatientCubit,PatientStates>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return  Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xff2A3164),
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  print("why");
                },
                icon: const Icon(
                  Icons.keyboard_arrow_left,
                  color: Colors.white,
                  size: 35,
                ),
              ),
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
                    Column(
                      //  crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text("Session Number :-",
                                    style: GoogleFonts.poppins(
                                        color: Color(0xff2A3164),fontSize: 20)),
                                const SizedBox(height: 5,),
                                Container(
                                  width: 250,
                                  height: 43.3,
                                  //color: Colors.purple,
                                  child: TextFormField(
                                    controller: nameController,
                                    keyboardType: TextInputType.name,
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return "This field mustn't be empty ";

                                      }else
                                        return null;
                                    },
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        )),
                                  ),
                                ),],),
                            SizedBox(width: 20,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Patient Name :-",
                                    style: GoogleFonts.poppins(
                                        color: Color(0xff2A3164),fontSize: 20)),
                                SizedBox(height: 5,),
                                Container(
                                  height: 50,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius:
                                      BorderRadius
                                          .circular(10),
                                      border: Border.all(
                                          color:
                                          Colors.white)),
                                  child:  DropdownButton(
                                    isExpanded: true,
                                    hint: Text("Select Your Patient"),

                                    // Initial Value
                                    value: PatientCubit.get(context).pationt,

                                    // Down Arrow Icon
                                    icon: const Icon(Icons.keyboard_arrow_down),

                                    // Array list of items
                                    items:  PatientCubit.get(context).patientModel!.patients!.map((items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items.patientName!),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: ( newValue) {
                                      setState(() {
                                       PatientCubit.get(context).pationt = newValue;
                                       print(newValue!.id);
                                       print(PatientCubit.get(context).pationt!.userId!);
                                      });
                                      print(newValue);
                                    },
                                  ),
                                ),
                              ],),
                          ],
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            MaterialButton(
                                hoverColor: Color(0xff8a8edb),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(
                                        10.0)),
                                onPressed: ()
                                async
                                {

                                    var headers = {
                                      'Content-Type': 'application/json',
                                      'Authorization': 'Bearer ${token ?? ''}'
                                    };
                                    var request = http.Request('POST',
                                        Uri.parse(
                                            'http://127.0.0.1:8000/start/record'));
                                    request.body = json.encode({
                                      "session_name": nameController.text,
                                      "patient_id": PatientCubit
                                          .get(context)
                                          .pationt!
                                          .id!
                                    });
                                    request.headers.addAll(headers);

                                    http
                                        .StreamedResponse response = await request
                                        .send();

                                    if (response.statusCode == 200) {
                                      print(await response.stream
                                          .bytesToString());
                                      final snackBar= SnackBar(
                                        /// need to set following properties for best effect of awesome_snackbar_content
                                        elevation: 0,
                                        behavior: SnackBarBehavior.floating,
                                        backgroundColor: Colors.transparent,
                                        content: AwesomeSnackbarContent(
                                          title: 'Gratefull',
                                          message:
                                          'Start Recording Success',

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
                                          title: 'ooooops',
                                          message:
                                          'Start Recording Error',

                                          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                          contentType: ContentType.failure,
                                        ),
                                      );
                                      ScaffoldMessenger.of(context)
                                        ..hideCurrentSnackBar()
                                        ..showSnackBar(snackBar);
                                    }
                                  } ,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 25),
                                  child: Text('Start Recording',style: TextStyle(color: Colors.white)),
                                ),
                                color: Color(0xff2A3164)),
                            const SizedBox(width: 10),
                            MaterialButton(
                                hoverColor: Color(0xff8a8edb),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(
                                        10.0)),
                                onPressed:()async{
                                  String token = await CacheHelper.getData(key: accessTokenKey);
                                  print(token);
                                  var headers = {
                                    'Authorization': 'Bearer ${token }',
                                    'Content-Type': 'application/json'
                                  };
                                  var request = http.Request('POST', Uri.parse('http://127.0.0.1:8000/stop/record'));
                                  request.body = json.encode({
                                    "session_name" : nameController.text,
                                    "patient_id": PatientCubit.get(context).pationt!.id!
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
                                        'Stop Recording Success and video saved successfully',

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
                                        title: 'ooooops',
                                        message:
                                        'Stop Recording Error',

                                        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                        contentType: ContentType.failure,
                                      ),
                                    );
                                    ScaffoldMessenger.of(context)
                                      ..hideCurrentSnackBar()
                                      ..showSnackBar(snackBar);
                                  }
                                  HistoryCubit.get(context).getPatientsHistory(PatientCubit.get(context).pationt!.id.toString());

                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 25),
                                  child: Text('Stop Recording',style: TextStyle(color: Colors.white)),
                                ),
                                color: Color(0xff2A3164)),
                            const SizedBox(width: 10),
                            MaterialButton(
                                hoverColor: Color(0xff8a8edb),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(
                                        10.0)),
                                onPressed: ()
                                async
                                {
                                  final webview = await WebviewWindow.create();
                                  webview.launch('http://127.0.0.1:8000/open/stream');
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 25),
                                  child: Text('OpenCamera',style: TextStyle(color: Colors.white)),
                                ),
                                color: Color(0xff2A3164)),
                            const SizedBox(width: 10),
                            MaterialButton(

                                hoverColor: Color(0xff8a8edb),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(
                                        10.0)),
                                onPressed: ()async{
                                  var request = http.Request('GET', Uri.parse('http://127.0.0.1:8000/close/stream'));
                                  http.StreamedResponse response = await request.send();

                                  if (response.statusCode == 200) {
                                    print(await response.stream.bytesToString());
                                  }
                                  else {
                                  print(response.reasonPhrase);
                                  }

                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 25),
                                  child: Text('Close Camera',style: TextStyle(color: Colors.white)),
                                ),
                                color: Color(0xff2A3164)),
                          ],
                        ),
                        SizedBox(height: 20,),
                        // MaterialButton(
                        //
                        //     hoverColor: Color(0xff8a8edb),
                        //     shape: RoundedRectangleBorder(
                        //         borderRadius:
                        //         BorderRadius.circular(
                        //             10.0)),
                        //     onPressed: ()async{
                        //       var headers = {
                        //         'Authorization':'Bearer ${token ?? ''}'
                        //       };
                        //       var request = http.Request('GET', Uri.parse('http://127.0.0.1:8000/api/patients/1'));
                        //
                        //       request.headers.addAll(headers);
                        //
                        //       http.StreamedResponse response = await request.send();
                        //
                        //       if (response.statusCode == 200) {
                        //         print(await response.stream.bytesToString());
                        //       }
                        //       else {
                        //         print(response.reasonPhrase);
                        //       }
                        //
                        //     },
                        //     child: Padding(
                        //       padding: EdgeInsets.symmetric(
                        //           vertical: 8,
                        //           horizontal: 25),
                        //       child: Text('Download Video',style: TextStyle(color: Colors.white)),
                        //     ),
                        //     color: Color(0xff2A3164)),
                      ],
                    ),
                    // const SizedBox(height: 5),
                    // ImageStream()
                    //Image.network('${request}')


                  ),
                ),
              ),
            ),
          );
        },
      );
  }
}
