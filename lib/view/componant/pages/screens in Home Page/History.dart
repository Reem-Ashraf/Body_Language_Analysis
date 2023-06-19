import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/model/History.dart';
import 'package:graduation_project/view/componant/pages/screens%20in%20Home%20Page/Result_Screen.dart';
import 'package:graduation_project/view_model/Camera_Scanning/camera_cubit.dart';
import 'package:graduation_project/view_model/Camera_Scanning/camera_state.dart';
import 'package:graduation_project/view_model/History/history_cubit.dart';
import 'package:http/http.dart' as http;
import '../../../../Data/Repo/GetPatieantRepo.dart';
import '../../../../model/patientmodel.dart';
import '../../../../model/patientmodel.dart';
import '../../core/constant.dart';

class HistoryScreen extends StatefulWidget {
   HistoryScreen({Key? key,}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  HistoryModel? data;
  @override
  void initState() {
    super.initState();
    GetPatientsRepo().getPatients().then((value) {
      if (value != null) {
        data = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => PatientCubit()..getPatients(),
        child: BlocConsumer<PatientCubit, PatientStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("ID",
                            style: GoogleFonts.poppins(
                                color: Color(0xff2A3164), fontSize: 20)),
                        Spacer(),
                        Text("Name",
                            style: GoogleFonts.poppins(
                                color: Color(0xff2A3164), fontSize: 20)),

                        Spacer(),

                      Container(
                        height: 45,
                        width: 200,
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
                    (PatientCubit.get(context).patientModel == null)
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: PatientCubit.get(context)
                                  .patientModel!
                                  .patients!
                                  .length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  hoverColor: Colors.grey[200],
                                  onTap: () {
                                    int id = PatientCubit.get(context)
                                        .patientModel!
                                        .patients![index].id!;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ResultScreen(patinetID: id,)));
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        // mainAxisAlignment: MainAxisAlignment,
                                        children: [
                                          Text("${(index + 1)}",
                                              style: GoogleFonts.poppins(
                                                  color: Color(0xff2A3164),
                                                  fontSize: 15)),
                                          Spacer(),
                                          //SizedBox(width: 200,),
                                          Text(
                                              PatientCubit.get(context)
                                                  .patientModel!
                                                  .patients![index]
                                                  .patientName!,
                                              style: GoogleFonts.poppins(
                                                  color: Color(0xff2A3164),
                                                  fontSize: 15)),

                                          Spacer(),
                                          const SizedBox(
                                            height: 70,
                                          ),
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
                                                    'Authorization':
                                                        'Bearer  ${token ?? ''}'
                                                  };
                                                  var request = http.Request(
                                                      'DELETE',
                                                      Uri.parse(
                                                          'http://127.0.0.1:8000/api/patient/delete/${ PatientCubit.get(context)
                                                              .patientModel!
                                                              .patients![index]
                                                              .id}'));

                                                  request.headers
                                                      .addAll(headers);

                                                  http.StreamedResponse
                                                      response =
                                                      await request.send();

                                                  if (response.statusCode ==
                                                      200) {
                                                    print(await response.stream
                                                        .bytesToString());
                                                    setState(() {
                                                      PatientCubit.get(context)
                                                          .patientModel!
                                                          .patients!.removeAt(index);

                                                    });
                                                  } else {
                                                    print(
                                                        response.reasonPhrase);
                                                  }
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 25),
                                                  child: Text(
                                                    'Delete Patient',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                color: Color(0xff181d43)),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        color: Colors.grey[300],
                                        width: double.infinity,
                                        height: 1,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
//body: Container(),
// body: data == null
//     ? Center(
//         child: Text("No Data"),
//       )
//     : ListView.builder(
//   //itemCount: data.,
//     itemBuilder: (BuildContext, index) {
//         return Text(
//             HistoryCubit.get(context).pationt!.patientName.toString());
//       }),
