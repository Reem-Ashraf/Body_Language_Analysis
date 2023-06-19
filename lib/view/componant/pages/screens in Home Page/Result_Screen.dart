import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/model/History.dart';
import 'package:graduation_project/view_model/Camera_Scanning/camera_cubit.dart';
import 'package:graduation_project/view_model/Camera_Scanning/camera_state.dart';
import 'package:graduation_project/view_model/History/history_cubit.dart';

import '../../../../view_model/result_cubit/result_cubit.dart';
import '../../core/constant.dart';
import 'package:http/http.dart' as http;

class ResultScreen extends StatefulWidget {
  ResultScreen({Key? key, required this.patinetID}) : super(key: key);
  final int patinetID;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ResultCubit()
          ..getPatientsVideoInfo(widget.patinetID.toString()),
        child: BlocConsumer<ResultCubit, ResultState>(
         listener: (context, state) {
            // TODO: implement listener
            if (state is DownloadSuccessfully) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Donload Successfully"),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is DownloadLoading) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Loading"),
                  backgroundColor: Colors.grey,
                ),
              );
            }
          },
          builder: (context, state) {
            ResultCubit cubit = ResultCubit.get(context);
            Future<void> _dialogBuilder(BuildContext context, int id) {
              return showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Basic dialog title'),
                    content: SizedBox(
                      height: 300,
                      width: 300,
                      child: ListView.builder(
                        itemCount: cubit.resultModel!.results!.length,
                        itemBuilder: (context, index) {
                          if (id ==
                              cubit.resultModel!.results![index]
                                  .patientVideoId) {
                            return Text(
                                cubit.resultModel!.results![index].status!,style: GoogleFonts.poppins(
                                color: Color(
                                    0xff2A3164),
                            fontSize: 16),);
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                        child: const Text('Disable'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      // TextButton(
                      //   style: TextButton.styleFrom(
                      //     textStyle: Theme.of(context).textTheme.labelLarge,
                      //   ),
                      //   child: const Text('Enable'),
                      //   onPressed: () {
                      //     Navigator.of(context).pop();
                      //   },
                      // ),
                    ],
                  );
                },
              );
            }

            return Scaffold(
                appBar: AppBar(
                    backgroundColor: Color(0xff2A3164),
                    elevation: 0,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.keyboard_arrow_left,
                        color: Colors.white,
                        size: 35,
                      ),
                    )),
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
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text("Session Name",
                                      style: GoogleFonts.poppins(
                                          color: Color(0xff2A3164),
                                          fontSize: 23)),
                                  Spacer(),
                                  Text("Session Video",
                                      style: GoogleFonts.poppins(
                                          color: Color(0xff2A3164),
                                          fontSize: 23)),
                                  Spacer(),
                                  Text("Session Result",
                                      style: GoogleFonts.poppins(
                                          color: Color(0xff2A3164),
                                          fontSize: 23)),
                                  Spacer(),
                                  Container(
                                    width: 85,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                color: Colors.grey[300],
                                width: double.infinity,
                                height: 1,
                              ),
                              //   (PatientCubit.get(context).patientModel == null)? Center(child: CircularProgressIndicator(),):
                              (cubit.videoModel != null)
                                  ? Expanded(
                                      child: ListView.builder(
                                        itemCount:
                                            cubit.videoModel!.videos!.length,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      "${cubit.videoModel!.videos![index].videoName}",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color: Color(
                                                                  0xff2A3164),
                                                              fontSize: 22)),
                                                  Container(
                                                    width: 60,
                                                  ),
                                                  Spacer(),
                                                  //Text("",style: TextStyle(fontSize: 30),),
                                                  SizedBox(width: 120,),
                                                  Container(
                                                    height: 45,
                                                    width: 200,
                                                    child: MaterialButton(
                                                        hoverColor:
                                                            Color(0xff2A3164),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0)),
                                                        onPressed: () {
                                                          cubit.getPatientsDanloadVideo(
                                                              cubit
                                                                  .videoModel!
                                                                  .videos![
                                                                      index]
                                                                  .fileName!);
                                                        },
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 8,
                                                                  horizontal:
                                                                      25),
                                                          child: Text(
                                                            'Download Video',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                        color:
                                                            Color(0xff181d43)),
                                                  ),
                                                 // Text(""),
                                                  SizedBox(width: 110,),
                                                  Spacer(),
                                                  Container(
                                                    height: 45,
                                                    width: 200,
                                                    child: MaterialButton(
                                                        hoverColor:
                                                            Color(0xff2A3164),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0)),
                                                        onPressed: () {
                                                          cubit.getPatientsResultInfo(cubit
                                                              .videoModel!
                                                              .videos![
                                                          index]
                                                              .id!.toString()).then((value)
                                                          {
                                                            _dialogBuilder(
                                                                context,
                                                                cubit
                                                                    .videoModel!
                                                                    .videos![
                                                                index]
                                                                    .id!);

                                                          });

                                                        },
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 8,
                                                                  horizontal:
                                                                      25),
                                                          child: Text(
                                                            'See Result',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                        color:
                                                            Color(0xff181d43)),
                                                  ),

                                                  Spacer(),
                                                 // SizedBox(width: 30,),
                                                  Container(
                                                    height: 45,
                                                    width: 200,
                                                    child: MaterialButton(
                                                        hoverColor: Color(0xff2A3164),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                5.0)),
                                                        onPressed: () async {
                                                          var headers = {
                                                            'Authorization': 'Bearer  ${token ?? ''}'
                                                          };
                                                          var request = http.Request('DELETE',
                                                              Uri.parse('http://127.0.0.1:8000/api/delete/session/${

                                                                  cubit.videoModel!.videos![index].id}'));

                                                          request.headers.addAll(headers);

                                                          http.StreamedResponse response = await request.send();

                                                          if (response.statusCode == 200) {
                                                            print(await response.stream.bytesToString());
                                                              setState(() {
                                                                cubit.videoModel!.videos!.removeAt(index);
                                                                // PatientCubit.get(context)
                                                                //     .patientModel!
                                                                //     .patients!.removeAt(index);

                                                              });
                                                          }
                                                          else {
                                                            print(response.reasonPhrase);
                                                          }

                                                        },
                                                        child: Padding(
                                                          padding: EdgeInsets.symmetric(
                                                              vertical: 8,
                                                              horizontal: 25),
                                                          child: Text(
                                                            'Delete Session',
                                                            style: TextStyle(
                                                                color: Colors.white),
                                                          ),
                                                        ),
                                                        color: Color(0xff181d43)),
                                                  ),
                                                 // Spacer(),
                                                  SizedBox(
                                                    height: 100,
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                color: Colors.grey[300],
                                                width: double.infinity,
                                                height: 1,
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                    )
                                  : Center(
                                      child: CircularProgressIndicator(),
                                    ),
                            ],
                          ),
                        ),
                        // const SizedBox(height: 5),
                        // ImageStream()
                        //Image.network('${request}')
                      ),
                    ),
                  ),
                ));
          },
        ));
  }
}
