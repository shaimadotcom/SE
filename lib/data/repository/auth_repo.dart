import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:learnjava/data/datasource/remote/dio/dio_client.dart';
import 'package:learnjava/data/datasource/remote/exception/api_error_handler.dart';
import 'package:learnjava/data/model/body/login_model.dart';
import 'package:learnjava/data/model/body/register_model.dart';
import 'package:learnjava/data/model/response/base/api_response.dart';
import 'package:learnjava/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final DioClient? dioClient;
  final SharedPreferences? sharedPreferences;
  AuthRepo({required this.dioClient, required this.sharedPreferences});

  Future<ApiResponse> registration(RegisterModel register) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.registrationUri,
        data: register.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> login(LoginModel loginBody) async {
    try {
      Response response = await dioClient!.post(
        AppConstants.loginUri,
        data: loginBody.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<void> saveUserToken(String token) async {
    dioClient!.updateHeader(token, null);

    try {
      await sharedPreferences!.setString(AppConstants.token, token);
    } catch (e) {
      rethrow;
    }
  }

  String getUserToken() {
    return sharedPreferences!.getString(AppConstants.token) ?? "";
  }
  //auth token
  // for  user token
  Future<void> saveAuthToken(String token) async {
    dioClient!.token = token;
    dioClient!.dio!.options.headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };

    try {
      await sharedPreferences!.setString(AppConstants.token, token);
    } catch (e) {
      rethrow;
    }
  }

  String getAuthToken() {
    return sharedPreferences!.getString(AppConstants.token) ?? "";
  }


  bool isLoggedIn() {
    return sharedPreferences!.containsKey(AppConstants.token);
  }
  Future<bool> logout() async {
    return clearSharedData();
  }

  Future<bool> clearSharedData() async {
    sharedPreferences!.remove(AppConstants.currency);
    sharedPreferences!.remove(AppConstants.token);
    sharedPreferences!.remove(AppConstants.user);
    //FirebaseMessaging.instance.unsubscribeFromTopic(AppConstants.topic);
    return true;
  }

  Future<ApiResponse> checkPhone(String phone, String temporaryToken) async {
    try {
      Response response = await dioClient!.post(
          AppConstants.checkPhoneUri,
          data: {"mobile": phone, "temporary_token" :temporaryToken});
      logger.i(response);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      logger.i(e);
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> resendPhoneOtp(String phone, String temporaryToken) async {
    try {
      Response response = await dioClient!.post(
          AppConstants.resendPhoneOtpUri,
          data: {"mobile": phone, "temporary_token" :temporaryToken});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> verifyPhone(String phone, String token,String otp) async {
    try {
      Response response = await dioClient!.post(
          AppConstants.verifyPhoneUri, data: {"mobile": phone.trim(), "temporary_token": token,"code": otp});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> verifyOtp(String identity, String otp) async {
    try {
      Response response = await dioClient!.post(
          AppConstants.verifyOtpUri, data: {"identity": identity.trim(), "otp": otp});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> resetPassword(String identity, String otp ,String password, String confirmPassword) async {
    try {
      Response response = await dioClient!.post(
          AppConstants.resetPasswordUri, data: {"_method" : "put", "identity": identity.trim(), "otp": otp,"password": password, "confirm_password":confirmPassword});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<void> saveUserPhoneAndPassword(String phone, String password) async {
    try {
      await sharedPreferences!.setString(AppConstants.userPassword, password);
      await sharedPreferences!.setString(AppConstants.userPhone, phone);
    } catch (e) {
      rethrow;
    }
  }

  String getUserPhone() {
    return sharedPreferences!.getString(AppConstants.userPhone) ?? "";
  }

  String getUserPassword() {
    return sharedPreferences!.getString(AppConstants.userPassword) ?? "";
  }

  Future<bool> clearUserPhoneAndPassword() async {
    await sharedPreferences!.remove(AppConstants.userPassword);
    return await sharedPreferences!.remove(AppConstants.userPhone);
  }


}
