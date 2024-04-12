import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../screens/home/widget/learn_questions/learn.dart';
import '../../screens/home/widget/play_online/playonline.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/home_model.dart';
import '../model/response/base/api_response.dart';

class HomeRepo{
  HomeRepo();

  Future<ApiResponse> getHomeList(BuildContext context) async {
    try {
      List<HomeModel> homeList = [
        HomeModel(
            LearnWidget(index: 0,),
          0
        ),
        HomeModel(
            const PlayOnLineWidget(index: 1,),
            1
        ),
      ];

      Response response = Response(requestOptions: RequestOptions(path: ''), data: homeList,statusCode: 200);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}