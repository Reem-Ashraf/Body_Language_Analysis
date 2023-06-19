class ResultModel {
  List<Results>? results;

  ResultModel({this.results});

  ResultModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? id;
  int? userId;
  int? patientId;
  int? patientVideoId;
  String? status;

  Results(
      {this.id, this.userId, this.patientId, this.patientVideoId, this.status});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    patientId = json['patient_id'];
    patientVideoId = json['patient_video_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['patient_id'] = this.patientId;
    data['patient_video_id'] = this.patientVideoId;
    data['status'] = this.status;
    return data;
  }
}
