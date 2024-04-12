import 'package:flutter/material.dart';
import 'package:learnjava/data/model/response/base/api_response.dart';
import 'package:learnjava/data/model/response/config_model.dart';
import '../data/repository/splash_repo.dart';
import '../helper/api_checker.dart';


class SplashProvider extends ChangeNotifier {
  final SplashRepo? splashRepo;
  SplashProvider({required this.splashRepo});
  ConfigModel? _configModel;
  bool _hasConnection = true;
  bool _fromSetting = false;
  bool _firstTimeConnectionCheck = true;
  bool _onOff = true;
  bool get onOff => _onOff;
  bool? _isGuest;
  String? _shareUrl;
   ConfigModel? get configModel => _configModel;
  bool get hasConnection => _hasConnection;
  bool get fromSetting => _fromSetting;
  bool? get isGuest => _isGuest;
  String? get shareURL=>_shareUrl;
  bool get firstTimeConnectionCheck => _firstTimeConnectionCheck;

  Future<bool> initConfig(BuildContext context) async {
    _hasConnection = true;
    ApiResponse apiResponse = await splashRepo!.getConfig();
    bool isSuccess;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _configModel = ConfigModel.fromJson(apiResponse.response!.data['data']);
       _shareUrl=_configModel!.shareUrl??"";
      isSuccess = true;
    } else {
      isSuccess = false;
      ApiChecker.checkApi( apiResponse);
      if(apiResponse.error.toString() == 'Connection to API server failed due to internet connection') {
        _hasConnection = false;
      }
    }
    notifyListeners();
    return isSuccess;
  }

  void setFirstTimeConnectionCheck(bool isChecked) {
    _firstTimeConnectionCheck = isChecked;
  }

  void initSharedPrefData() {
    splashRepo!.initSharedData();
  }

  void setFromSetting(bool isSetting) {
    _fromSetting = isSetting;
  }

  bool? showIntro() {
    return splashRepo!.showIntro();
  }

  void disableIntro() {
    splashRepo!.disableIntro();
  }

}
