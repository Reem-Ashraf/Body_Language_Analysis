import 'dart:convert';

import '../../model/History.dart';
import 'package:http/http.dart' as http;

import '../../view/componant/core/constant.dart';

class GetPatientsRepo {
  Future<HistoryModel?> getPatients() async {
    try {
      var response = await http.get(Uri.parse(
          "http://127.0.0.1:8000/api/patients/user"),
          headers:{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token ?? ''}'
      });

      Map<String, dynamic> responseMap = json.decode(response.body);

      if (response.statusCode == 200) {
        print("The API Request Done Successfully");
        final data = HistoryModel.fromJson(responseMap);

        return data;
      } else {
        print("Failed");

        return null;
      }
    } catch (error) {}
  }}