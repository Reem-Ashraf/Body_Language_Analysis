class UserModel {
  int? id;
  String? name;
  String? email;
  bool? isAdmin;

  UserModel({this.id, this.name, this.email, this.isAdmin});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    name = json['name'];
    email = json['email'];
    isAdmin = json['is_admin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['is_admin'] = this.isAdmin;
    return data;
  }
}