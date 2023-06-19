class PatientModel {
  List<PatientData>? patients;

  PatientModel({this.patients});

  PatientModel.fromJson(Map<String, dynamic> json) {
    if (json['patients'] != null) {
      patients = <PatientData>[];
      json['patients'].forEach((v) {
        patients!.add( PatientData.fromJson(v));
      });
    }
  }
}

class PatientData {
  int? id;
  int? userId;
  String? patientName;

  PatientData({this.id, this.userId, this.patientName});

  PatientData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    patientName = json['patient_name'];
  }
}