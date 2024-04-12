import 'package:flutter/material.dart';
import 'package:learnjava/data/model/response/base/api_response.dart';
import 'package:learnjava/screens/auth/main_Auth_screen.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class ApiChecker {
  static void checkApi(ApiResponse apiResponse) {
    if(apiResponse.error is! String && apiResponse.error.errors[0].message == 'Unauthorized.') {
      Navigator.of(Get.context!).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const AuthScreen()), (route) => false);
    }else {
      if (apiResponse.error is String) {
      } else {
      }
    }
  }
}