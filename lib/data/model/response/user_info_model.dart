class UserInfoModel {
  int? id;
  String? name;
  String? username;
  int? play_count;
  int? total_points;
  UserInfoModel(
      {this.id,  this.name, this.username,
        this.play_count, this.total_points
     });

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    play_count = json['play_count'];
    total_points =int.parse(json['total_points'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['play_count'] = play_count;
    data['total_points'] = total_points;
    return data;
  }
}
