import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';
import '../../../utill/color_resources.dart';
import '../../utill/dimensions.dart';
import '../../utill/images.dart';
import '../../utill/labelKeys.dart';
import '../base_widgets/custom_app_bar.dart';
import '../base_widgets/drawer/Drawer.dart';
import '../home/home_screens.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key,this.index}) : super(key: key);
  final int? index;


  @override
  DashBoardScreenState createState() => DashBoardScreenState();
}

class DashBoardScreenState extends State<DashBoardScreen>  with TickerProviderStateMixin,WidgetsBindingObserver{
  late int _currentSelectedBottomNavIndex = 0;
  late int _previousSelectedBottmNavIndex = -1;

  final ScrollController _scrollController = ScrollController();
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  late final Animation<double> _bottomNavAndTopProfileAnimation =
  Tween<double>(begin: 0.0, end: 1.0).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ),
  );

  late final List<AnimationController> _bottomNavItemTitlesAnimationController =
  [];

  late List<GlobalKey> _bottomNavItemShowCaseKey = [];

  Future<void> changeBottomNavItem(int index) async {
    _bottomNavItemTitlesAnimationController[_currentSelectedBottomNavIndex]
        .forward();

    // //need to assign previous selected bottom index only if menu is close
    // if (!_isMoreMenuOpen && _currentlyOpenMenuIndex == -1) {
    //   _previousSelectedBottmNavIndex = _currentSelectedBottomNavIndex;
    // }

    //change current selected bottom index
    setState(() {
      _currentSelectedBottomNavIndex = index;
      //
      // //if user taps on non-last bottom nav item then change _currentlyOpenMenuIndex
      // if (_currentSelectedBottomNavIndex != _bottomNavItems.length - 1) {
      //   _currentlyOpenMenuIndex = -1;
      // }
    });

    _bottomNavItemTitlesAnimationController[_currentSelectedBottomNavIndex]
        .reverse();
  }

  @override
  void dispose() {
    _animationController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    for (var animationController in _bottomNavItemTitlesAnimationController) {
      animationController.dispose();
    }
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _animationController.forward();
   // widget.index!=null?changeBottomNavItem(widget.index!):null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (_currentSelectedBottomNavIndex != 0) {
          changeBottomNavItem(0);
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: ColorResources.pagecolor,
        drawer:  const Drawer(
          child: CustomDrawer(),
        ),
        body:Stack(
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: CustomAppBar(homeBar: true,)),
            Positioned(
              top: Dimensions.appBarBodyStackTop, // Adjust this value to overlap from point 100
              left: 0,
              right: 0,
              child: IndexedStack(
                index: _currentSelectedBottomNavIndex,
                children: [
                   HomePage(index:widget.index??0),
                 // Container(),
                 // _previousSelectedBottmNavIndex == 0
                 //      ? const HomePage()
                 //      : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}