import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:learnjava/data/model/body/progress_model.dart';
import 'package:learnjava/data/model/response/base/api_response.dart';
import 'package:learnjava/data/model/response/config_model.dart';
import 'package:learnjava/data/model/response/user_score_model.dart';
import 'package:learnjava/data/repository/profile_repo.dart';
import 'package:learnjava/utill/app_constants.dart';
import '../data/model/body/register_model.dart';
import '../data/model/response/user_info_model.dart';
import '../data/repository/splash_repo.dart';
import '../helper/api_checker.dart';


class ProfileProvider extends ChangeNotifier {
  final ProfileRepo? profileRepo;
  ProfileProvider({required this.profileRepo});
  bool _isLoading = false;
  UserInfoModel? _userInfoModel;
  UserInfoModel? get userInfoModel => _userInfoModel;
  bool get isLoading => _isLoading;

  setUserPoints(ProgressModel progressModel, Function callback) async{
    _isLoading = true;
    ApiResponse apiResponse = await profileRepo!.setUserPoints(progressModel);
    logger.i(progressModel.toJson());
    _isLoading = false;
    bool isSuccess;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map map = apiResponse.response!.data;
      callback(true, map['message'])
      ;
      isSuccess = true;
    } else {
      isSuccess = false;
    }
    notifyListeners();
  }
setUserProfile(UserInfoModel user){
  _userInfoModel=user;
  notifyListeners();
}

  Future<String> getProfile(BuildContext context) async {
    String userID = '-1';
    ApiResponse apiResponse = await profileRepo!.getProfile();
    bool isSuccess;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _userInfoModel = UserInfoModel.fromJson(apiResponse.response!.data["data"]);
      userID = _userInfoModel!.id.toString();
      // logger.i(_userInfoModel!.toJson());
      // logger.i(userID);
      isSuccess = true;
    } else {
      isSuccess = false;
    }
    notifyListeners();
    return userID;
  }


  Future updateProfile(RegisterModel register, Function callback) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await profileRepo!.updateProfile(register);
    _isLoading = false;

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String,dynamic> map = apiResponse.response!.data['data'];
      UserInfoModel? user;
      String? message;
      logger.i(map);
      try{
        message=apiResponse.response!.data["message"];
        user =UserInfoModel.fromJson(map) ;

      }catch(e){
        if (kDebugMode) {
          print(e);
        }

      }
      callback(true, user, message);
      notifyListeners();
    }
    else{
      callback(false, null, apiResponse.error);
    }
    notifyListeners();
  }

  Future getScores(Function callback) async {
    _isLoading = true;
    ApiResponse apiResponse = await profileRepo!.getScores();
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map<String,dynamic> map = apiResponse.response!.data;
      UserScores? scores;
      try{
        scores =UserScores.fromJson(map) ;
      }catch(e){
        if (kDebugMode) {
          print(e);
        }

      }
      callback(true, scores);
    }
    else{
      callback(false, null, apiResponse.error);
    }
    notifyListeners();
  }

}
