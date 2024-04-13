import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:learnjava/providers/profile_provider.dart';
import 'package:learnjava/providers/splash_provider.dart';
import 'package:learnjava/screens/home/widget/menu_Item.dart';
import 'package:learnjava/utill/app_constants.dart';
import 'package:provider/provider.dart';

import '../../localization/language_constrants.dart';
import '../../providers/home_provider.dart';
import '../../utill/color_resources.dart';
import '../../utill/custom_themes.dart';
import '../../utill/dimensions.dart';
import '../../utill/images.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key,this.index}) : super(key: key);
  final int? index;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();
  late int _currentSelectedPageIndex = 0;

  Future<void> _loadData(bool reload) async {
    // logger.i(Provider.of<SplashProvider>(context, listen: false).getCities!);
    // await Provider.of<BannerProvider>(Get.context!, listen: false)
    //     .getFooterBannerList();
    // await Provider.of<BannerProvider>(Get.context!, listen: false)
    //     .getMainSectionBanner();
    // await Provider.of<CategoryProvider>(Get.context!, listen: false)
    //     .getCategoryList(reload);
    // await Provider.of<HomeCategoryProductProvider>(Get.context!, listen: false)
    //     .getHomeCategoryProductList(reload);
    // await Provider.of<TopSellerProvider>(Get.context!, listen: false)
    //     .getTopSellerList(reload);
    // await Provider.of<BrandProvider>(Get.context!, listen: false)
    //     .getBrandList(reload);
    // await Provider.of<ProductProvider>(Get.context!, listen: false)
    //     .getLatestProductList(1, reload: reload);
    // await Provider.of<ProductProvider>(Get.context!, listen: false)
    //     .getFeaturedProductList('1', reload: reload);
    // await Provider.of<FeaturedDealProvider>(Get.context!, listen: false)
    //     .getFeaturedDealList(reload);
    // await Provider.of<ProductProvider>(Get.context!, listen: false)
    //     .getLProductList('1', reload: reload);
    // await Provider.of<ProductProvider>(Get.context!, listen: false)
    //     .getRecommendedProduct();
  }
  final List<MenuItem> _menuItems = [
    MenuItem(
      image: Images.learn,
      title: "Learn",
    ),
    MenuItem(
      image: Images.shift_icon,
      title: "Play Online",
    ),
  ];
  @override
  void initState() {
    super.initState();
    _loadData(false);
    widget.index!=null?_currentSelectedPageIndex=(widget.index!):null;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    Provider.of<HomeProvider>(context, listen: false).initHomeList(context);
    return Stack(children: [
        Padding(
          padding:EdgeInsets.symmetric(horizontal:Dimensions.appBarStackedContainerPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(text: '${getTranslated("welcome_message", context) ?? "Welcome"},', style: droidNormal.copyWith(color: ColorResources.white, fontSize: 12), children: [
                  TextSpan(
                    text: '  ${Provider.of<ProfileProvider>(context, listen: false).userInfoModel?.name ?? ""} \n',
                    style: droidNormal.copyWith(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  TextSpan(
                    text: ' ${getTranslated("welcome_hint", context) ?? "Are you ready for an amazing java learning experience?"}',
                    style: droidNormal.copyWith(color: ColorResources.white, fontSize: 11),
                  )
                ]),
              ),
              const SizedBox(height: Dimensions.paddingSizeDefault,),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                margin: EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  color: ColorResources.white,
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 6,
                      offset: Offset(0, 3),
                      color: ColorResources.tabBackgroundColor,
                    )
                  ],
                  border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.1),
                  ),
                  shape: BoxShape.rectangle,
                ),
                height: MediaQuery.of(context).size.height>600?MediaQuery.of(context).size.height*0.15:MediaQuery.of(context).size.height * (0.2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      getTranslated("starthere", context) ?? "Start Here!",
                      style: beINBold.copyWith(fontSize: 14),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    LayoutBuilder(
                      builder: (context, boxConstraints) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: _menuItems.map((menuItem) {
                            final int index = _menuItems.indexWhere((e) => e.title == menuItem.title);
                            return MenuItemContainer(
                              item: _menuItems[index],
                              selected: _currentSelectedPageIndex == index,
                              onTap: changePage,
                              index: index,
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Consumer<HomeProvider>(
                  builder: (context, homeList, child) => SizedBox(height: height,
                    child: ListView(children: [
                      SizedBox(
                        height: height/1.5,
                        child: Column(mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                          Expanded(
                            child: PageView.builder(
                              itemCount: homeList.homeList.length,
                              controller: _pageController,
                              itemBuilder: (context, index) {
                                return SingleChildScrollView(
                                  child: homeList.homeList[index].child,
                                );
                              },
                              onPageChanged: (index) {
                               // if(index==1&&(Provider.of<ProfileProvider>(context,listen: false).totalPoints??0)>=100){
                               //   logger.i(index);
                               //
                               // }else{
                                homeList.changeSelectIndex(index);
                                setState(() {
                                  _currentSelectedPageIndex = index;
                                });
                              //}
                              },
                            ),
                          )
                        ]),
                      ),
                    ]),
                  ))
            ],
          ),
        ),

      ]
    );
  }

  Future<void> changePage(index) async {
    if(index==1){
      if(!Provider.of<SplashProvider>(context,listen: false).configModel!.data!.canPlayOnline!){
        showDialog(
            context: context,
            builder: (BuildContext context) {
          return AlertDialog(
          title:  Text(getTranslated('Not enough points', context)??'Not enough points'),
          content:  Text('${getTranslated("Not enough points_message", context)??"Your total points is Lower than Required points to enter online playing\n"} ${getTranslated("Collect", context)??"Collect"} ${Provider.of<SplashProvider>(context,listen: false).configModel!.data!.pointsToOnline??0} ${getTranslated("points to enter online play.", context)??" points to enter online play."}' ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(getTranslated('ok',context)??"OK"),
            ),
          ],
        );});
    }else{
      Provider.of<HomeProvider>(context, listen: false).changeSelectIndex(index);
    setState(() {
      _currentSelectedPageIndex = index;
    });
    _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }}else{
      Provider.of<HomeProvider>(context, listen: false).changeSelectIndex(index);
      setState(() {
        _currentSelectedPageIndex = index;
      });
      _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);

    }

  }
}
