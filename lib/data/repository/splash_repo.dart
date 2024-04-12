import 'package:learnjava/data/model/response/base/api_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utill/app_constants.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';

class SplashRepo {
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;
  SplashRepo({required this.dioClient, required this.sharedPreferences});

  Future<ApiResponse> getConfig() async {
    try {
      final response = await dioClient!.get(AppConstants.configUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  void initSharedData() async {
    if (!sharedPreferences!.containsKey(AppConstants.intro)) {
      sharedPreferences!.setBool(AppConstants.intro, true);
      logger.i(sharedPreferences!.get(AppConstants.intro));
    }
  }

  void disableIntro() {
    sharedPreferences!.setBool(AppConstants.intro, false);
  }
  void enableIntro() {
    sharedPreferences!.setBool(AppConstants.intro, true);
  }
  bool? showIntro() {
    return sharedPreferences!.getBool(AppConstants.intro);
  }


}
