class RegisterModel {
  String? password;
  String? username;
  String? name;

  RegisterModel({this.password, this.username, this.name});

  RegisterModel.fromJson(Map<String, dynamic> json) {

    password = json['password'];
    username = json['username'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['password'] = password;
    data['username'] = username;
    data['name'] = name;
    return data;
  }
}
