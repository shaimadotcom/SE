import 'package:learnjava/data/model/body/register_model.dart';
import 'package:learnjava/data/model/response/base/api_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utill/app_constants.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/body/progress_model.dart';

class ProfileRepo {
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;
  ProfileRepo({required this.dioClient, required this.sharedPreferences});

  Future<ApiResponse> getProfile() async {
    try {
      final response = await dioClient!.get(AppConstants.customerUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> setUserPoints(ProgressModel progressModel) async{
    try {
      final response = await dioClient!.post(AppConstants.saveProgress,data: progressModel.toJson(),);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> updateProfile(RegisterModel registerModel) async{
    try {
      final response = await dioClient!.post(AppConstants.updateUser,data: registerModel.toJson(),);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getScores() async{
    try {
      final response = await dioClient!.get(AppConstants.usersSScores,);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
