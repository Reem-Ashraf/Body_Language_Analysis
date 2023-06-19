class HistoryModel {
  Patient? patient;
  List<Videos>? videos;

  HistoryModel({this.patient, this.videos});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    patient =
    json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos!.add(new Videos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.patient != null) {
      data['patient'] = this.patient!.toJson();
    }
    if (this.videos != null) {
      data['videos'] = this.videos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Patient {
  int? id;
  String? name;

  Patient({this.id, this.name});

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Videos {
  int? id;
  String? fileName;
  String? videoName;
  int? patientId;

  Videos({this.id, this.fileName, this.videoName, this.patientId});

  Videos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fileName = json['file_name'];
    videoName = json['video_name'];
    patientId = json['patient_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['file_name'] = this.fileName;
    data['video_name'] = this.videoName;
    data['patient_id'] = this.patientId;
    return data;
  }
}