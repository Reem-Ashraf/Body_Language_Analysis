class LoginModel {
  String? accessToken;
  late String message;

  LoginModel({this.accessToken, required this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.accessToken;
    data['message'] = this.message;
    return data;
  }
}