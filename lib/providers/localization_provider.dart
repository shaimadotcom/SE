import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/datasource/remote/dio/dio_client.dart';
import '../data/model/language_model.dart';
import '../utill/app_constants.dart';

class LocalizationProvider extends ChangeNotifier {
  final SharedPreferences? sharedPreferences;
  final DioClient? dioClient;

  LocalizationProvider({required this.sharedPreferences, required this.dioClient}) {
    _loadCurrentLanguage();
  }

  Locale _locale = Locale(AppConstants.languages[1].languageCode!, AppConstants.languages[1].countryCode);
  bool _isLtr = true;
  int? _languageIndex;

  Locale get locale => _locale;
  bool get isLtr => _isLtr;
  int? get languageIndex => _languageIndex;

  void setLanguage(Locale locale) {
    _locale = locale;
    _isLtr = _locale.languageCode != 'ar';
    dioClient!.updateHeader(null, locale.countryCode);
    for(int index=0; index<AppConstants.languages.length; index++) {
      if(AppConstants.languages[index].languageCode == locale.languageCode) {
        _languageIndex = index;
        break;
      }
    }
    _saveLanguage(_locale);
    notifyListeners();
  }

  _loadCurrentLanguage() async {
    _locale = Locale(sharedPreferences!.getString(AppConstants.languageCode) ?? AppConstants.languages[1].languageCode!,
        sharedPreferences!.getString(AppConstants.countryCode) ?? AppConstants.languages[1].countryCode);
    _isLtr = _locale.languageCode != 'ar';
    for(int index=0; index<AppConstants.languages.length; index++) {
      if(AppConstants.languages[index].languageCode == locale.languageCode) {
        _languageIndex = index;
        break;
      }
    }
    notifyListeners();
  }

  _saveLanguage(Locale locale) async {
    sharedPreferences!.setString(AppConstants.languageCode, locale.languageCode);
    sharedPreferences!.setString(AppConstants.countryCode, locale.countryCode!);
  }

  LanguageModel getLanguageByName(String languageName) {
    return AppConstants.languages.firstWhere((lang) => lang.languageName == languageName,
        orElse: () =>AppConstants.languages[0]);
  }
  LanguageModel getLanguageByCode(String languageCode) {
    return AppConstants.languages.firstWhere((lang) => lang.languageCode == languageCode,
        orElse: () =>AppConstants.languages[0]);
  }
}