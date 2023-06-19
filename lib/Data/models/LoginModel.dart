// class LoginModel {
//   LoginModel({
//     required this.result,
//     required this.message,
//     required this.data,
//   });
//   late final bool result;
//   late final String message;
//   late final Data data;
//
//   LoginModel.fromJson(Map<String, dynamic> json){
//     result = json['result'];
//     message = json['message'];
//     data = Data.fromJson(json['data']);
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['result'] = result;
//     _data['message'] = message;
//     _data['data'] = data.toJson();
//     return _data;
//   }
// }
//
// class Data {
//   Data({
//     required this.id,
//     required this.email,
//     required this.name,
//     required this.phone,
//     required this.roles,
//     required this.tempPassword,
//     required this.accessToken,
//   });
//   late final String id;
//   late final String email;
//   late final String name;
//   late final String phone;
//   late final List<String> roles;
//   late final bool tempPassword;
//   late final String accessToken;
//
//   Data.fromJson(Map<String, dynamic> json){
//     id = json['id'];
//     email = json['email'];
//     name = json['name'];
//     phone = json['phone'];
//     roles = List.castFrom<dynamic, String>(json['roles']);
//     tempPassword = json['tempPassword'];
//     accessToken = json['accessToken'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['id'] = id;
//     _data['email'] = email;
//     _data['name'] = name;
//     _data['phone'] = phone;
//     _data['roles'] = roles;
//     _data['tempPassword'] = tempPassword;
//     _data['accessToken'] = accessToken;
//     return _data;
//   }
// }