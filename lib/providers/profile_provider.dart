import 'package:flutter/material.dart';
import 'package:learnjava/data/model/response/base/api_response.dart';
import 'package:learnjava/data/model/response/config_model.dart';
import 'package:learnjava/data/repository/profile_repo.dart';
import '../data/repository/splash_repo.dart';
import '../helper/api_checker.dart';


class ProfileProvider extends ChangeNotifier {
  final ProfileRepo? profileRepo;
  ProfileProvider({required this.profileRepo});
  int? _totalPoints=0;
  int? get totalPoints=>_totalPoints;


  setUserPoints(){
    _totalPoints=_totalPoints!+25;
    notifyListeners();
  }
  resetUserPoints(){
    _totalPoints=0;
    notifyListeners();
  }
  Future<bool> getProfile(BuildContext context) async {
    ApiResponse apiResponse = await profileRepo!.getProfile();
    bool isSuccess;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      isSuccess = true;
    } else {
      isSuccess = false;
    }
    notifyListeners();
    return isSuccess;
  }

}
