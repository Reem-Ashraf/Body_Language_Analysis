// import 'dart:async';
// import 'dart:convert';
//
// import 'package:camera_platform_interface/camera_platform_interface.dart';
// import 'package:desktop_webview_window/desktop_webview_window.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:graduation_project/view_model/Camera_Scanning/camera_cubit.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:http/http.dart' as http;
//
// class Camera extends StatefulWidget {
//   const Camera({Key? key}) : super(key: key);
//
//   @override
//   State<Camera> createState() => _CameraState();
// }
//
// class _CameraState extends State<Camera> {
//   String _cameraInfo = 'Unknown';
//   List<CameraDescription> _cameras = <CameraDescription>[];
//   int _cameraIndex = 0;
//   int _cameraId = -1;
//   bool _initialized = false;
//   bool _recording = false;
//   bool _recordingTimed = false;
//   bool _recordAudio = true;
//   bool _previewPaused = false;
//   Size? _previewSize;
//   ResolutionPreset _resolutionPreset = ResolutionPreset.veryHigh;
//   StreamSubscription<CameraErrorEvent>? _errorStreamSubscription;
//   StreamSubscription<CameraClosingEvent>? _cameraClosingStreamSubscription;
//   TextEditingController nameController = TextEditingController();
//   final _formKey=GlobalKey<FormState>();
//
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsFlutterBinding.ensureInitialized();
//     _fetchCameras();
//   }
//
//   @override
//   void dispose() {
//     _disposeCurrentCamera();
//     _errorStreamSubscription?.cancel();
//     _errorStreamSubscription = null;
//     _cameraClosingStreamSubscription?.cancel();
//     _cameraClosingStreamSubscription = null;
//     super.dispose();
//   }
//
//   /// Fetches list of available cameras from camera_windows plugin.
//   Future<void> _fetchCameras() async {
//     String cameraInfo;
//     List<CameraDescription> cameras = <CameraDescription>[];
//
//     int cameraIndex = 0;
//     try {
//       cameras = await CameraPlatform.instance.availableCameras();
//       if (cameras.isEmpty) {
//         cameraInfo = 'No available cameras';
//       } else {
//         cameraIndex = _cameraIndex % cameras.length;
//         cameraInfo = 'Found camera: ${cameras[cameraIndex].name}';
//       }
//     } on PlatformException catch (e) {
//       cameraInfo = 'Failed to get cameras: ${e.code}: ${e.message}';
//     }
//
//     if (mounted) {
//       setState(() {
//         _cameraIndex = cameraIndex;
//         _cameras = cameras;
//         _cameraInfo = cameraInfo;
//       });
//     }
//   }
//
//   /// Initializes the camera on the device.
//   Future<void> _initializeCamera() async {
//     assert(!_initialized);
//
//     if (_cameras.isEmpty) {
//       return;
//     }
//
//     int cameraId = -1;
//     try {
//       final int cameraIndex = _cameraIndex % _cameras.length;
//       final CameraDescription camera = _cameras[cameraIndex];
//
//       cameraId = await CameraPlatform.instance.createCamera(
//         camera,
//         _resolutionPreset,
//         enableAudio: _recordAudio,
//       );
//
//       _errorStreamSubscription?.cancel();
//       _errorStreamSubscription = CameraPlatform.instance
//           .onCameraError(cameraId)
//           .listen(_onCameraError);
//
//       _cameraClosingStreamSubscription?.cancel();
//       /*  _cameraClosingStreamSubscription = CameraPlatform.instance
//           .onCameraClosing(cameraId)
//           .listen(_onCameraClosing);*/
//
//       final Future<CameraInitializedEvent> initialized =
//           CameraPlatform.instance.onCameraInitialized(cameraId).first;
//
//       await CameraPlatform.instance.initializeCamera(
//         cameraId,
//
//       );
//
//       final CameraInitializedEvent event = await initialized;
//       _previewSize = Size(
//         event.previewWidth,
//         event.previewHeight,
//       );
//
//       if (mounted) {
//         setState(() {
//           _initialized = true;
//           _cameraId = cameraId;
//           _cameraIndex = cameraIndex;
//           _cameraInfo = 'Capturing camera: ${camera.name}';
//         });
//       }
//     } on CameraException catch (e) {
//       try {
//         if (cameraId >= 0) {
//           await CameraPlatform.instance.dispose(cameraId);
//         }
//       } on CameraException catch (e) {
//         debugPrint('Failed to dispose camera: ${e.code}: ${e.description}');
//       }
//
//       // Reset state.
//       if (mounted) {
//         setState(() {
//           _initialized = false;
//           _cameraId = -1;
//           _cameraIndex = 0;
//           _previewSize = null;
//           _recording = false;
//           _recordingTimed = false;
//           _cameraInfo =
//               'Failed to initialize camera: ${e.code}: ${e.description}';
//         });
//       }
//     }
//   }
//
//   Future<void> _disposeCurrentCamera() async {
//     if (_cameraId >= 0 && _initialized) {
//       try {
//         await CameraPlatform.instance.dispose(_cameraId);
//
//         if (mounted) {
//           setState(() {
//             _initialized = false;
//             _cameraId = -1;
//             _previewSize = null;
//             _recording = false;
//             _recordingTimed = false;
//             _previewPaused = false;
//             _cameraInfo = 'Camera disposed';
//           });
//         }
//       } on CameraException catch (e) {
//         if (mounted) {
//           setState(() {
//             _cameraInfo =
//                 'Failed to dispose camera: ${e.code}: ${e.description}';
//           });
//         }
//       }
//     }
//   }
//
//   Widget _buildPreview() {
//     return CameraPlatform.instance.buildPreview(_cameraId);
//   }
//
// /*  Future<void> _takePicture() async {
//     final XFile file = await CameraPlatform.instance.takePicture(_cameraId);
//     _showInSnackBar('Picture captured to: ${file.path}');
//   }
//
//   Future<void> _recordTimed(int seconds) async {
//     if (_initialized && _cameraId > 0 && !_recordingTimed) {
//       CameraPlatform.instance
//           .onVideoRecordedEvent(_cameraId)
//           .first
//           .then((VideoRecordedEvent event) async {
//         if (mounted) {
//           setState(() {
//             _recordingTimed = false;
//           });
//
//           _showInSnackBar('Video captured to: ${event.file.path}');
//         }
//       });
//
//       await CameraPlatform.instance.startVideoRecording(
//         _cameraId,
//         maxVideoDuration: Duration(seconds: seconds),
//       );
//
//       if (mounted) {
//         setState(() {
//           _recordingTimed = true;
//         });
//       }
//     }
//   }
//
//   Future<void> _toggleRecord() async {
//     if (_initialized && _cameraId > 0) {
//       if (_recordingTimed) {
//         /// Request to stop timed recording short.
//         await CameraPlatform.instance.stopVideoRecording(_cameraId);
//       } else {
//         if (!_recording) {
//           await CameraPlatform.instance.startVideoRecording(_cameraId);
//         } else {
//           final XFile file =
//           await CameraPlatform.instance.stopVideoRecording(_cameraId);
//
//           _showInSnackBar('Video captured to: ${file.path}');
//         }
//
//         if (mounted) {
//           setState(() {
//             _recording = !_recording;
//           });
//         }
//       }
//     }
//   }
//
//   Future<void> _togglePreview() async {
//     if (_initialized && _cameraId >= 0) {
//       if (!_previewPaused) {
//         await CameraPlatform.instance.pausePreview(_cameraId);
//       } else {
//         await CameraPlatform.instance.resumePreview(_cameraId);
//       }
//       if (mounted) {
//         setState(() {
//           _previewPaused = !_previewPaused;
//         });
//       }
//     }
//   }
//
//   Future<void> _switchCamera() async {
//     if (_cameras.isNotEmpty) {
//       // select next index;
//       _cameraIndex = (_cameraIndex + 1) % _cameras.length;
//       if (_initialized && _cameraId >= 0) {
//         await _disposeCurrentCamera();
//         await _fetchCameras();
//         if (_cameras.isNotEmpty) {
//           await _initializeCamera();
//         }
//       } else {
//         await _fetchCameras();
//       }
//     }
//   }
//
//   Future<void> _onResolutionChange(ResolutionPreset newValue) async {
//     setState(() {
//       _resolutionPreset = newValue;
//     });
//     if (_initialized && _cameraId >= 0) {
//       // Re-inits camera with new resolution preset.
//       await _disposeCurrentCamera();
//       await _initializeCamera();
//     }
//   }*/
//
// /*  Future<void> _onAudioChange(bool recordAudio) async {
//     setState(() {
//       _recordAudio = recordAudio;
//     });
//     if (_initialized && _cameraId >= 0) {
//       // Re-inits camera with new record audio setting.
//       await _disposeCurrentCamera();
//       await _initializeCamera();
//     }
//   }*/
//
//   void _onCameraError(CameraErrorEvent event) {
//     if (mounted) {
//       _scaffoldMessengerKey.currentState?.showSnackBar(
//           SnackBar(content: Text('Error: ${event.description}')));
//
//       // Dispose camera on camera error as it can not be used anymore.
//       _disposeCurrentCamera();
//       _fetchCameras();
//     }
//   }
//
//   void _onCameraClosing(CameraClosingEvent event) {
//     if (mounted) {
//       _showInSnackBar('Camera is closing');
//     }
//   }
//
//   void _showInSnackBar(String message) {
//     _scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
//       content: Text(message),
//       duration: const Duration(seconds: 1),
//     ));
//   }
//
//
//
//   final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
//       GlobalKey<ScaffoldMessengerState>();
//
//   @override
//   Widget build(BuildContext context) {
//     final List<DropdownMenuItem<ResolutionPreset>> resolutionItems =
//         ResolutionPreset.values
//             .map<DropdownMenuItem<ResolutionPreset>>((ResolutionPreset value) {
//       return DropdownMenuItem<ResolutionPreset>(
//         value: value,
//         child: Text(value.toString()),
//       );
//     }).toList();
//
//     return BlocProvider(
//         create: (BuildContext) => CameraCubit(),
//         child: BlocConsumer<CameraCubit, CameraState>(
//           listener: (context, state) {
//             // TODO: implement listener
//           },
//           builder: (context, state) {
//             return Scaffold(
//                 appBar: AppBar(
//                   backgroundColor: Color(0xff2A3164),
//                   elevation: 0,
//                   leading: IconButton(
//                     onPressed: () {
//                       Navigator.pop(context);
//                       print("why");
//                     },
//                     icon: Icon(
//                       Icons.keyboard_arrow_left,
//                       color: Colors.white,
//                       size: 35,
//                     ),
//                   ),
//                 ),
//                 body: Container(
//                   decoration: BoxDecoration(color: Color(0xff2A3164)),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.only(right: 20, bottom: 20, left: 20),
//                     child: Container(
//                       width: double.infinity,
//                       height: double.infinity,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(50),
//                               topRight: Radius.circular(50)),
//                           color: Colors.white),
//                       child: ListView(
//                         scrollDirection: Axis.horizontal,
//                         children: [
//                           /*Padding(
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 5,
//                     horizontal: 10,
//                   ),
//                   child: Text(_cameraInfo),
//                 ),*/
//                           /*if (_cameras.isEmpty)
//                             ElevatedButton(
//                               onPressed: _fetchCameras,
//                               child: const Text('Re-check available cameras'),
//                             ),*/
//                           if (_cameras.isNotEmpty)
//                             Container(
//                               margin: EdgeInsets.only(top: 150, left: 20),
//                               // color: Colors.red,
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   /*DropdownButton<ResolutionPreset>(
//                           value: _resolutionPreset,
//                           onChanged: (ResolutionPreset? value) {
//                             if (value != null) {
//                               _onResolutionChange(value);
//                             }
//                           },
//                           items: resolutionItems,
//                         ),*/
//
//                                   // const SizedBox(width: 20),
//
//                                   /*  const Text('Audio:'),
//                         Switch(
//                             value: _recordAudio,
//                             onChanged: (bool state) => _onAudioChange(state)),*/
//                                   // const SizedBox(width: 50),
//
//                                   Container(
//                                     padding:EdgeInsets.only(top: 100),
//                                     child: Column(
//                                       children: [
//                                         // SizedBox(
//                                         //   height: 80,
//                                         // ),
//                                         // _initialized
//                                         //     ? Text(
//                                         //         "Status: ${CameraCubit.Get(context).open}",
//                                         //         style: GoogleFonts.poppins(
//                                         //             color: Color(0xff666bd5),
//                                         //             shadows: <Shadow>[
//                                         //               Shadow(
//                                         //                 //offset: Offset(50.0, 50.0),
//                                         //                 blurRadius: 5,
//                                         //                 color: Color(0xff2A3164),
//                                         //               ),
//                                         //             ],
//                                         //             fontSize: 35),
//                                         //       )
//                                         //     : Text(
//                                         //         "Status: ${CameraCubit.Get(context).clos}",
//                                         //         style: GoogleFonts.poppins(
//                                         //             color: Color(0xff666bd5),
//                                         //             shadows: <Shadow>[
//                                         //               Shadow(
//                                         //                 //offset: Offset(50.0, 50.0),
//                                         //                 blurRadius: 5,
//                                         //                 color: Color(0xff2A3164),
//                                         //               ),
//                                         //             ],
//                                         //             fontSize: 35),
//                                         //       ),
//                                         Text("Name:",
//                                             style: GoogleFonts.poppins(
//                                                 color: Color(0xff2A3164),fontSize: 25)),
//                                         Container(
//                                           width: 500,
//                                           height: 40,
//                                           //color: Colors.purple,
//                                           child: TextFormField(
//                                             controller: nameController,
//                                             keyboardType: TextInputType.name,
//                                             decoration: InputDecoration(
//                                                 border: OutlineInputBorder(
//                                                   borderRadius: BorderRadius.all(
//                                                     Radius.circular(10),
//                                                   ),
//                                                 )),
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           height: 20,
//                                         ),
//                                         Row(
//                                           children: [
//
//                                             MaterialButton(
//                                                 hoverColor: Color(0xff8a8edb),
//                                                 shape: RoundedRectangleBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             10.0)),
//                                                 onPressed: ()
//                                                 async
//                                                 {
//
//                                                   var headers = {
//                                                     'Content-Type': 'application/json'
//                                                   };
//                                                   var request = http.Request('POST', Uri.parse('http://127.0.0.1:8000/stream/start'));
//                                                   request.body = json.encode({
//                                                     "name": nameController.text
//                                                   });
//                                                   request.headers.addAll(headers);
//
//                                                   http.StreamedResponse response = await request.send();
//                                                   print(response.statusCode);
//
//                                                   if (response.statusCode == 200) {
//                                                     print(await response.stream.bytesToString());
//                                                   }
//                                                   else {
//                                                     print(response.reasonPhrase);
//                                                   }
//
//                                                 },
//                                                 child: Padding(
//                                                   padding: EdgeInsets.symmetric(
//                                                       vertical: 8,
//                                                       horizontal: 25),
//                                                   child: Text('Start Recording'),
//                                                 ),
//                                                 color: Colors.grey[200]),
//                                             const SizedBox(width: 10),
//                                             MaterialButton(
//                                                 hoverColor: Color(0xff8a8edb),
//                                                 shape: RoundedRectangleBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             10.0)),
//                                                 onPressed:({String? token})async{
//                                                   var headers = {
//                                                     'Authorization': 'Bearer ${token ?? ''}',
//                                                     'Content-Type': 'application/json'
//                                                   };
//                                                   var request = http.Request('POST', Uri.parse('http://127.0.0.1:8000/stream/stop'));
//                                                   request.body = json.encode({
//                                                     "name":nameController.text
//                                                   });
//                                                   request.headers.addAll(headers);
//
//                                                   http.StreamedResponse response = await request.send();
//
//                                                   if (response.statusCode == 200) {
//                                                     print(await response.stream.bytesToString());
//                                                   }
//                                                   else {
//                                                     print(response.reasonPhrase);
//                                                   }
//
//
//                                                 },
//                                                 child: Padding(
//                                                   padding: EdgeInsets.symmetric(
//                                                       vertical: 8,
//                                                       horizontal: 25),
//                                                   child: Text('Stop Recording'),
//                                                 ),
//                                                 color: Colors.grey[200]),
//                                             const SizedBox(width: 10),
//                                             MaterialButton(
//                                                 hoverColor: Color(0xff8a8edb),
//                                                 shape: RoundedRectangleBorder(
//                                                     borderRadius:
//                                                     BorderRadius.circular(
//                                                         10.0)),
//                                                 onPressed: ()
//                                                 async
//                                                 {
//                                                   final webview = await WebviewWindow.create();
//                                                   webview.launch("http://127.0.0.1:8000/stream");
//                                                 },
//                                                 child: Padding(
//                                                   padding: EdgeInsets.symmetric(
//                                                       vertical: 8,
//                                                       horizontal: 25),
//                                                   child: Text('OpenCamera'),
//                                                 ),
//                                                 color: Colors.grey[200]),
//                                             const SizedBox(width: 10),
//                                             MaterialButton(
//
//                                                 hoverColor: Color(0xff8a8edb),
//                                                 shape: RoundedRectangleBorder(
//                                                     borderRadius:
//                                                     BorderRadius.circular(
//                                                         10.0)),
//                                                 onPressed: _disposeCurrentCamera,
//                                                 child: Padding(
//                                                   padding: EdgeInsets.symmetric(
//                                                       vertical: 8,
//                                                       horizontal: 25),
//                                                   child: Text('Close Camera'),
//                                                 ),
//                                                 color: Colors.grey[200]),
//                                           ],
//                                         ),
//                                         /* ElevatedButton(
//                           onPressed: _initialized ? _takePicture : null,
//                           child: const Text('Take picture'),
//                         ),
//                         const SizedBox(width: 5),
//                         ElevatedButton(
//                           onPressed: _initialized ? _togglePreview : null,
//                           child: Text(
//                             _previewPaused ? 'Resume preview' : 'Pause preview',
//                           ),
//                         ),
//                         const SizedBox(width: 5),
//                         ElevatedButton(
//                           onPressed: _initialized ? _toggleRecord : null,
//                           child: Text(
//                             (_recording || _recordingTimed)
//                                 ? 'Stop recording'
//                                 : 'Record Video',
//                           ),
//                         ),
//                         const SizedBox(width: 5),
//                         ElevatedButton(
//                           onPressed: (_initialized && !_recording && !_recordingTimed)
//                               ? () => _recordTimed(5)
//                               : null,
//                           child: const Text(
//                             'Record 5 seconds',
//                           ),
//                         ),
//                         if (_cameras.length > 1) ...<Widget>[
//                           const SizedBox(width: 5),
//                           ElevatedButton(
//                             onPressed: _switchCamera,
//                             child: const Text(
//                               'Switch camera',
//                             ),
//                           ),
//                         ]*/
//                                       ],
//                                     ),
//                                   ),
//                                   const SizedBox(height: 5),
//                                   (_initialized &&
//                                           _cameraId > 0 &&
//                                           _previewSize != null)
//                                       ? Container(
//                                           //clipBehavior: Clip.antiAlias,
//                                           decoration: BoxDecoration(
//                                               boxShadow: [
//                                                 BoxShadow(
//                                                   color: Color(0xff2A3164)
//                                                       .withOpacity(0.5),
//                                                   spreadRadius: 8,
//                                                   blurRadius: 8,
//                                                   offset: Offset(2,
//                                                       3), // changes position of shadow
//                                                 ),
//                                               ],
//                                               borderRadius:
//                                                   BorderRadius.circular(20)),
//                                           //  margin: EdgeInsets.only(left: 450),
//                                           child: Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                               vertical: 10,
//                                             ),
//                                             child: Align(
//                                               child: Container(
//                                                 constraints:
//                                                     const BoxConstraints(
//                                                   //maxHeight: 350,
//                                                 ),
//                                                 child: AspectRatio(
//                                                   aspectRatio:
//                                                       _previewSize!.width /
//                                                           _previewSize!.height,
//                                                   child: _buildPreview(),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         )
//                                       : Container(
//                                           decoration: BoxDecoration(
//                                               color: Colors.white,
//                                               boxShadow: [
//                                                 BoxShadow(
//                                                   color: Color(0xff2A3164)
//                                                       .withOpacity(0.5),
//                                                   spreadRadius: 5,
//                                                   blurRadius: 7,
//                                                   offset: Offset(0,
//                                                       3), // changes position of shadow
//                                                 ),
//                                               ],
//                                               borderRadius:
//                                                   BorderRadius.circular(20)),
//
//                                           // margin: EdgeInsets.only(left: 450),
//                                           child: Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                               vertical: 10,
//                                             ),
//                                             child: Align(
//                                               child: Container(
//                                                 constraints:
//                                                     const BoxConstraints(
//                                                   maxHeight: 350,
//                                                 ),
//                                                 child: AspectRatio(
//                                                   aspectRatio: 480 / 500,
//                                                   child: _buildPreview(),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         )
//                                 ],
//                               ),
//                             ),
//
//                           /*if (_previewSize != null)
//                   Center(
//                     child: Text(
//                       'Preview size: ${_previewSize!.width.toStringAsFixed(0)}x${_previewSize!.height.toStringAsFixed(0)}',
//                     ),
//                   ),*/
//                         ],
//                       ),
//                     ),
//                   ),
//                 ));
//           },
//         ));
//   }
// }
