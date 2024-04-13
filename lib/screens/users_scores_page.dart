import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:learnjava/data/model/response/config_model.dart';
import 'package:learnjava/data/model/response/user_info_model.dart';
import 'package:learnjava/data/model/response/user_score_model.dart';
import 'package:learnjava/providers/profile_provider.dart';
import 'package:provider/provider.dart';

import '../../../../localization/language_constrants.dart';
import '../../../../providers/localization_provider.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../data/model/body/register_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/splash_provider.dart';
import '../../utill/images.dart';
import '../base_widgets/customTextFieldContainer.dart';
import '../base_widgets/custom_app_bar.dart';
import '../base_widgets/drawer/Drawer.dart';
import '../base_widgets/passwordHideShowButton.dart';

class UsersscorePage extends StatefulWidget {
  const UsersscorePage({super.key});
  @override
  State<UsersscorePage> createState() => _UsersscorePageState();
}

class _UsersscorePageState extends State<UsersscorePage> with TickerProviderStateMixin {
  UserScores? allScoress;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProfileProvider>(context, listen: false).getScores(route);
  }
void route(bool done,UserScores scores){
    if (done){
      setState(() {
        allScoress=scores;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated(scores.message, context) ?? scores.message!), backgroundColor: ColorResources.primaryOrangeColor));
    }
}
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: ColorResources.pagecolor,
        drawer: const Drawer(
          child: CustomDrawer(),
        ),
        body: Stack(children: [
          Align(alignment: Alignment.topCenter, child: CustomAppBar()),
          Positioned(
            top: Dimensions.appBarBodyStackTop, // Adjust this value to overlap from point 100
            left: Dimensions.appBarStackedContainerPadding,
            right: Dimensions.appBarStackedContainerPadding,
            //bottom:-51,
            child: SizedBox(
              height: height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getTranslated("users_score", context) ?? "Users Scores",
                        style: beINNormal.copyWith(
                          fontSize: 14,
                          color: ColorResources.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                  levelInfoWidget(context),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                ],
              ),
            ),
          ),
        ]));
  }

  Widget levelInfoWidget(BuildContext context) {
    String lang = Provider.of<LocalizationProvider>(context, listen: false).locale.languageCode;
    return  Consumer<ProfileProvider>(builder: (context, profile, child) {
     return Container(
        height: MediaQuery.of(context).size.height*0.8,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ColorResources.white,
          boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)],
        ),
        child: profile.isLoading?
        Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 50, vertical: Dimensions.marginSizeExtraLarge),
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  ColorResources.primaryColor,
                ),
              ),
            )):
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge, vertical: Dimensions.paddingSizeSmall),
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisExtent: 100,
              ),
              itemCount:allScoress!.data!.length,
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return gridItem(allScoress!.data![index]);
              })
          ),
      );}
    );
  }
  Widget gridItem(UserInfoModel user ){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      // padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 3),
              color: ColorResources.primaryColor
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Text(user.name ?? "",
                style: beINNormal.copyWith(
                    color: ColorResources.primaryOrangeColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            Spacer(flex: 1,),
            Center(
              child: Text(user.total_points.toString() ?? "",
                style: beINNormal.copyWith(
                    color: ColorResources.primaryOrangeColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
