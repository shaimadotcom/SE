import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:learnjava/utill/color_resources.dart';
import 'package:provider/provider.dart';

import '../../../localization/language_constrants.dart';
import '../../../providers/splash_provider.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../custom_app_bar.dart';
import 'Drawer.dart';

class UserManualScreen extends StatefulWidget {
  const UserManualScreen({super.key});

  @override
  State<UserManualScreen> createState() => _UserManualScreenState();
}

class _UserManualScreenState extends State<UserManualScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserManual();
  }
  Future<void> getUserManual()async {
    Provider.of<SplashProvider>(context, listen: false).getUserManual(context);
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
          Provider.of<SplashProvider>(context, listen: true).userManual!.isNotEmpty?
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
                        getTranslated("User Manual", context) ?? "User Manual",
                        style: beINNormal.copyWith(
                          fontSize: 14,
                          color: ColorResources.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                  Container(
                      height: height*0.82,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: ColorResources.white,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge, vertical: Dimensions.paddingSizeExtraLarge),
                        child: SingleChildScrollView(
                          child: Html(data: Provider.of<SplashProvider>(context, listen: false).userManual, style: {'html': Style(color: ColorResources.black, fontSize: FontSize.xLarge, whiteSpace: WhiteSpace.normal, fontWeight: FontWeight.normal, display: Display.inlineBlock, textDecoration: TextDecoration.none)}),
                        ),
                      )),
                  const SizedBox(
                    height: Dimensions.paddingSizeDefault,
                  ),
                ],
              ),
            ),
          ):
          const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(ColorResources.black))),
        ]));
  }
}
