import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../../providers/localization_provider.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/images.dart';

class UserProfileDrawerHeader extends StatefulWidget {
  const UserProfileDrawerHeader({super.key});

  @override
  State<UserProfileDrawerHeader> createState() =>
      _UserProfileDrawerHeaderState();
}

class _UserProfileDrawerHeaderState extends State<UserProfileDrawerHeader> {
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return
        // Consumer<ProfileProvider>(
        // builder: (context, profile, child) =>
        Stack(alignment: Alignment.center, children: [
      Column(
        children: [
          Container(
            width: 65,
            height: 65,
            decoration: const BoxDecoration(
              color: ColorResources.white,
              shape: BoxShape.circle,
            ),
            child: GestureDetector(
                onTap: () {
                  Scaffold.of(context).closeDrawer();
                  //navigationService.navigateToProfileScreen(true);
                },
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        Images.user,
                      ),
                    ))),
          ),
          const SizedBox(height: 10),
          RichText(
            // text: TextSpan(text:' ${profile.userInfoModel!.fName ?? ""} ${profile.userInfoModel!.lName ?? ""}\n', style: droidNormal.copyWith(color: ColorResources.white, fontSize: 16,fontWeight: FontWeight.bold), children: [
            text: TextSpan(
                text: 'User Name',
                style: droidNormal.copyWith(
                    color: ColorResources.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                children: [
                  // TextSpan(
                  //   text: '+97188888888',
                  //   //text: '  ${Provider.of<ProfileProvider>(context, listen: false).userInfoModel?.mobile ?? ""}',
                  //   style: droidNormal.copyWith(
                  //       fontWeight: FontWeight.bold, fontSize: 12),
                  // ),
                ]),
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: SvgPicture.asset(
                      Images.notifications,
                      fit: BoxFit.fill,
                      height: 20,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      Images.editProfile,
                      fit: BoxFit.fill,
                      height: 20,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ],
              ))
        ],
      ),
      Provider.of<LocalizationProvider>(context, listen: false)
                  .locale
                  .languageCode ==
              "ar"
          ? Positioned(
              top: 10,
              left: 10,
              child: GestureDetector(
                  onTap: () {
                    Scaffold.of(context).closeDrawer();
                  },
                  child: SizedBox(
                    child: SvgPicture.asset(
                      Images.back,
                      fit: BoxFit.fitHeight,
                      color: ColorResources.white,
                    ),
                  )))
          : Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                  onTap: () {
                    Scaffold.of(context).closeDrawer();
                  },
                  child: SizedBox(
                    child: SvgPicture.asset(
                      Images.back_r,
                      fit: BoxFit.fitHeight,
                      color: ColorResources.white,
                    ),
                  )))
    ]);
    //);
  }
}
