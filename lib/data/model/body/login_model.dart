class LoginModel {
  String? mobile;
  String? password;

  LoginModel({this.mobile, this.password});

  LoginModel.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mobile'] = mobile;
    data['password'] = password;
    return data;
  }
}
