
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:learnjava/data/model/body/login_model.dart';
import 'package:learnjava/data/model/body/register_model.dart';
import 'package:learnjava/data/model/response/base/api_response.dart';
import 'package:learnjava/data/model/response/base/error_response.dart';
import 'package:learnjava/data/repository/auth_repo.dart';
import 'package:learnjava/utill/app_constants.dart';
import 'package:provider/provider.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepo? authRepo;
  AuthProvider({required this.authRepo});

  bool _isLoading = false;
  bool? _isRemember = false;
  bool? _acceptPolicy = false;
  int _selectedIndex = 0;
  int get selectedIndex =>_selectedIndex;

  updateSelectedIndex(int index){
    _selectedIndex = index;
    notifyListeners();
  }


  bool get isLoading => _isLoading;
  void setLoadingValue(bool newValue) {
    _isLoading = newValue;
    //notifyListeners();
  }
  bool? get isRemember => _isRemember;
  bool? get acceptPolicy => _acceptPolicy;

  void updateRemember(bool? value) {
    _isRemember = value;
    notifyListeners();
  }
  void updateAcceptPolicy(bool? value) {
    _acceptPolicy = value;
    notifyListeners();
  }

  Future registration(RegisterModel register, Function callback) async {
    // logger.i(register.toJson());
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo!.registration(register);
    _isLoading = false;

    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map map = apiResponse.response!.data['data'];
      logger.i(map);
      String? temporaryToken = '';
      String? token = '';
      String? message = '';
      int? testCode = 0;

      logger.i(map["code"]);
      try{
        message = map["message"];

      }catch(e){

        if (kDebugMode) {
          print(e);
        }
      }
      try{
        token = map["token"];

      }catch(e){
        if (kDebugMode) {
          print(e);
        }

      }

      if(token != null && token.isNotEmpty){
        authRepo!.saveUserToken(token);
        //await authRepo!.updateToken();
      }

      callback(true, token, message);
      notifyListeners();
    }
    else{
      callback(false, '', apiResponse.error);
    }
    notifyListeners();
  }

  Future login(LoginModel loginBody, Function callback) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await authRepo!.login(loginBody);
    _isLoading = false;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      Map map = apiResponse.response!.data['data'];

      logger.i(map);
      String? temporaryToken = '';
      String? token = '';
      String? message = '';
      bool verified=false;
      int newCode = 0;
      try{
        newCode = map["newcode"];

      }catch(e){

        if (kDebugMode) {
          print(e);
        }
      }
      try{
        verified = map["verified"]==1?true:false;

      }catch(e){

        if (kDebugMode) {
          print(e);
        }
      }
      try{
        message = map["message"];

      }catch(e){

        if (kDebugMode) {
          print(e);
        }
      }
      try{
        token = map["token"];

      }catch(e){
        if (kDebugMode) {
          print(e);
        }
      }
      try{
        temporaryToken = map["temporary_token"];

      }catch(e){
        if (kDebugMode) {
          print(e);
        }
      }

      if(token != null && token.isNotEmpty){
        authRepo!.saveUserToken(token);
       // await authRepo!.updateToken();
      }
      callback(true, token, token, message)
      ;
      notifyListeners();
    } else {
      String? errorMessage;
      if (apiResponse.error is String) {
        if (kDebugMode) {
          print(apiResponse.error.toString());
        }
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        if (kDebugMode) {
          print(errorResponse.errors![0].message);
        }
        errorMessage = errorResponse.errors![0].message;
      }
      callback(false, '', '' , errorMessage);
      notifyListeners();
    }
  }

  Future<void> updateToken(BuildContext context) async {
   // ApiResponse apiResponse = await authRepo!.updateToken();
   //  if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
   //
   //  } else {
   //    ApiChecker.checkApi( apiResponse);
   //  }
  }

  int resendTime = 60;

  // Future<ResponseModel> resetPassword(String identity, String otp, String password, String confirmPassword) async {
  //   _isPhoneNumberVerificationButtonLoading = true;
  //   _verificationMsg = '';
  //   notifyListeners();
  //   ApiResponse apiResponse = await authRepo!.resetPassword(identity,otp,password,confirmPassword);
  //   _isPhoneNumberVerificationButtonLoading = false;
  //   notifyListeners();
  //   ResponseModel responseModel;
  //   if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
  //     responseModel = ResponseModel( apiResponse.response!.data["message"], true);
  //   } else {
  //     String? errorMessage;
  //     if (apiResponse.error is String) {
  //       errorMessage = apiResponse.error.toString();
  //     } else {
  //       ErrorResponse errorResponse = apiResponse.error;
  //       errorMessage = errorResponse.errors![0].message;
  //     }
  //     responseModel = ResponseModel(errorMessage,false);
  //     _verificationMsg = errorMessage;
  //   }
  //   notifyListeners();
  //   return responseModel;
  // }



  // for phone verification
  bool _isPhoneNumberVerificationButtonLoading = false;

  bool get isPhoneNumberVerificationButtonLoading => _isPhoneNumberVerificationButtonLoading;
  String? _verificationMsg = '';

  String? get verificationMessage => _verificationMsg;
  String _email = '';
  String _phone = '';

  String get email => _email;
  String get phone => _phone;

  updateEmail(String email) {
    _email = email;
    notifyListeners();
  }
  updatePhone(String phone) {
    _phone = phone;
    notifyListeners();
  }

  void clearVerificationMessage() {
    _verificationMsg = '';
  }


  // for verification Code
  String _verificationCode = '';

  String get verificationCode => _verificationCode;
  bool _isEnableVerificationCode = false;

  bool get isEnableVerificationCode => _isEnableVerificationCode;

  updateVerificationCode(String query) {
    if (query.length == 6) {
      _isEnableVerificationCode = true;
    } else {
      _isEnableVerificationCode = false;
    }
    _verificationCode = query;
    notifyListeners();
  }





  // for user Section
  String getUserToken({bool isGuestToken=false}) {
    return authRepo!.getUserToken();
  }

  //get auth token
  // for user Section
  String getAuthToken() {
    return authRepo!.getAuthToken();
  }


  bool isLoggedIn() {
    return authRepo!.isLoggedIn();
  }
  Future<bool> logout() {
    return authRepo!.logout();
  }
  Future<bool> clearSharedData() async {
    return await authRepo!.clearSharedData();
  }

  // for  Remember Email
  void saveUserPhone(String phone, String password) {
    authRepo!.saveUserPhoneAndPassword(phone, password);
  }

  String getUserPhone() {
    return authRepo!.getUserPhone();
  }

  Future<bool> clearUserPhoneAndPassword() async {
    return authRepo!.clearUserPhoneAndPassword();
  }


  String getUserPassword() {
    return authRepo!.getUserPassword();
  }

}

class ErrorModel {
  String? code;
  String? message;

  ErrorModel({this.code, this.message});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }
}
