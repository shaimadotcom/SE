import 'package:learnjava/data/model/response/user_info_model.dart';

class ConfigModel {
  String? message;
  Data? data;

  ConfigModel({this.message, this.data});

  ConfigModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  UserInfoModel? user;
  int? pointsToOnline;
  bool? canPlayOnline;
  List<OfflineLevels>? offlineLevels;
  List<OnlineLevels>? onlineLevels;

  Data(
      {this.user,
        this.pointsToOnline,
        this.canPlayOnline,
        this.offlineLevels,
        this.onlineLevels});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? UserInfoModel.fromJson(json['user']) : null;
    pointsToOnline = json['points_to_online'];
    canPlayOnline = json['can_play_online'];
    if (json['offline_levels'] != null) {
      offlineLevels = <OfflineLevels>[];
      json['offline_levels'].forEach((v) {
        offlineLevels!.add(OfflineLevels.fromJson(v));
      });
    }
    if (json['online_levels'] != null) {
      onlineLevels = <OnlineLevels>[];
      json['online_levels'].forEach((v) {
        onlineLevels!.add(OnlineLevels.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['points_to_online'] = pointsToOnline;
    data['can_play_online'] = canPlayOnline;
    if (offlineLevels != null) {
      data['offline_levels'] =
          offlineLevels!.map((v) => v.toJson()).toList();
    }
    if (onlineLevels != null) {
      data['online_levels'] =
          onlineLevels!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OfflineLevels {
  int? id;
  String? title;
  String? type;
  String? vidoeUrl;
  String? points;
  bool? alreadyPlayed;
  Progress? progress;
  List<Questions>? questions;

  OfflineLevels(
      {this.id,
        this.title,
        this.type,
        this.vidoeUrl,
        this.points,
        this.alreadyPlayed,
        this.progress,
        this.questions});

  OfflineLevels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    vidoeUrl = json['vidoe_url'];
    points = json['points'];
    alreadyPlayed = json['already_played'];
    progress = json['progress'] != null
        ? Progress.fromJson(json['progress'])
        : null;
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['type'] = type;
    data['vidoe_url'] = vidoeUrl;
    data['points'] = points;
    data['already_played'] = alreadyPlayed;
    if (progress != null) {
      data['progress'] = progress!.toJson();
    }
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Progress {
  String? q1;
  String? q2;
  String? q3;
  String? q4;
  String? points;

  Progress({this.q1, this.q2, this.q3, this.q4, this.points});

  Progress.fromJson(Map<String, dynamic> json) {
    q1 = json['q1'];
    q2 = json['q2'];
    q3 = json['q3'];
    q4 = json['q4'];
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['q1'] = q1;
    data['q2'] = q2;
    data['q3'] = q3;
    data['q4'] = q4;
    data['points'] = points;
    return data;
  }
}

class Questions {
  int? id;
  String? text;
  String? answer1;
  String? answer2;
  String? answer3;
  String? answer4;
  String? correctAnswer;

  Questions(
      {this.id,
        this.text,
        this.answer1,
        this.answer2,
        this.answer3,
        this.answer4,
        this.correctAnswer});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    answer1 = json['answer1'];
    answer2 = json['answer2'];
    answer3 = json['answer3'];
    answer4 = json['answer4'];
    correctAnswer = json['correct_answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    data['answer1'] = answer1;
    data['answer2'] = answer2;
    data['answer3'] = answer3;
    data['answer4'] = answer4;
    data['correct_answer'] = correctAnswer;
    return data;
  }
}

class OnlineLevels {
  int? id;
  String? title;
  String? type;
  String? vidoeUrl;
  String? points;
  bool? alreadyPlayed;
  Progress? progress;
  List<Questions>? questions;

  OnlineLevels(
      {this.id,
        this.title,
        this.type,
        this.vidoeUrl,
        this.points,
        this.alreadyPlayed,
        this.progress,
        this.questions});

  OnlineLevels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    vidoeUrl = json['vidoe_url'];
    points = json['points'];
    alreadyPlayed = json['already_played'];
    progress = json['progress'] != null
        ? Progress.fromJson(json['progress'])
        : null;
      if (json['questions'] != null) {
        questions = <Questions>[];
        json['questions'].forEach((v) {
          questions!.add(Questions.fromJson(v));
        });
      }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['type'] = type;
    data['vidoe_url'] = vidoeUrl;
    data['points'] = points;
    data['already_played'] = alreadyPlayed;
    if (progress != null) {
      data['progress'] = progress!.toJson();
    }
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
