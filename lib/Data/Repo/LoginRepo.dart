// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
//
// //import 'package:akari/data/Models/log_in_model/log_in_model.dart';
// //import 'package:akari/helpers/myApplication.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
//
// import '../../view/componant/core/constant.dart';
// import '../models/LoginModel.dart';
// //import '../../App/constants.dart';
//
// class LoginRepo {
//   Future<LoginModel?> logIn(String mail, String pass) async {
//     try {
//       var response = await http.post(Uri.parse('$baseUrl/auth/login'),
//           headers: {}, body: {"email": mail, "password": pass});
//
//       Map<String, dynamic> responsemap = json.decode(response.body);
//       if (response.statusCode == 200 && responsemap["result"] == true) {
//         final data =LoginModel .fromJson(responsemap);
//         Fluttertoast.showToast(msg: "Login Success",backgroundColor: Colors.green);
//        // myApplication.showToast(text: data.message!, color: Colors.green);
//         return data;
//       } else {
//         Fluttertoast.showToast(msg: "Login Failed",backgroundColor: Colors.red);
//         //myApplication.showToast(
//             //text: responsemap["message"], color: Colors.red);
//         return null;
//       }
//     } on TimeoutException catch (e) {
//       if (kDebugMode) {
//         print('TimeoutException: ${e.toString()}');
//       }
//     } on SocketException catch (e) {
//       if (kDebugMode) {
//         print('SocketException: ${e.toString()}');
//       }
//     }
//   }
// }
