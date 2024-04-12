import 'package:learnjava/data/model/response/user_info_model.dart';

class UserScores {
  String? message;
  List<UserInfoModel>? data;

  UserScores({this.message, this.data});

  UserScores.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <UserInfoModel>[];
      json['data'].forEach((v) {
        data!.add(UserInfoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}