import 'package:flutter/material.dart';
import '../data/model/home_model.dart';
import '../data/model/response/base/api_response.dart';
import '../data/repository/home_repo.dart';
import '../helper/api_checker.dart';

class HomeProvider with ChangeNotifier {
  final HomeRepo? homeRepo;

  HomeProvider({required this.homeRepo});

  final List<HomeModel> _homeList = [];
  List<HomeModel> get homeList => _homeList;

  int _selectedIndex = 0;
  int get selectedIndex =>_selectedIndex;

  changeSelectIndex(int index){
    _selectedIndex=index;
    notifyListeners();
  }

  void initHomeList(BuildContext context) async {
    ApiResponse apiResponse = await homeRepo!.getHomeList(context);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _homeList.clear();
      _homeList.addAll(apiResponse.response!.data);
    } else {
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }


}
