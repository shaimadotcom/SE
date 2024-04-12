class ProgressModel {
  int? level_id;
  int? q1; int? q2; int? q3; int? q4;
  int? points;

  ProgressModel({this.level_id,this.q1,this.q2,this.q3,this.q4, this.points});

ProgressModel.fromJson(Map<String, dynamic> json) {
    level_id = json['level_id'];
    q1 = json['q1'];
    q2 = json['q2'];
    q3 = json['q3'];
    q4 = json['q4'];
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['level_id'] = level_id;
    data['q1'] = q1;
    data['q2'] = q2;
    data['q3'] = q3;
    data['q4'] = q4;
    data['points'] = points;
    return data;
  }
}
