class RegisterModel {
  String? password;
  String? fName;
  String? lName;
  String? mobile;

  RegisterModel({this.password, this.fName, this.lName});

  RegisterModel.fromJson(Map<String, dynamic> json) {

    password = json['password'];
    fName = json['f_name'];
    lName = json['l_name'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['password'] = password;
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['mobile'] = mobile;
    return data;
  }
}
