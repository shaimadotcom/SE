class LanguageModel {
  String? imageUrl;
  String? languageName;
  String? languageCode;
  String? countryCode;
  String? shortcut;

  LanguageModel({this.imageUrl, this.languageName, this.countryCode, this.languageCode,this.shortcut});
}

class LanguageApiModel{
  List<Language>? language;

  LanguageApiModel({this.language});

  LanguageApiModel.fromJson(Map<String, dynamic> json) {
    if (json['language'] != null) {
      language = <Language>[];
      json['language'].forEach((v) {
        language!.add(Language.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (language != null) {
      data['language'] = language!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Language {
  String? code;
  String? name;

  Language({this.code, this.name});

  Language.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    return data;
  }
}