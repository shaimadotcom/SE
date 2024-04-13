import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:learnjava/data/model/response/config_model.dart';
import 'package:learnjava/screens/home/widget/learn_questions/question_view.dart';
import 'package:provider/provider.dart';

import '../../../../localization/language_constrants.dart';
import '../../../../providers/localization_provider.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../../base_widgets/custom_app_bar.dart';
import '../../../base_widgets/drawer/Drawer.dart';

class OnlineLevelsPage extends StatefulWidget {
  const OnlineLevelsPage({super.key, this.level});
  final OnlineLevels? level;
  @override
  State<OnlineLevelsPage> createState() => _OnlineLevelsPageState();
}

class _OnlineLevelsPageState extends State<OnlineLevelsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                        getTranslated("level_info", context) ?? "Level Info",
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
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        QuestionView(level: widget.level!,online: true,)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ]));
  }

  Widget levelInfoWidget(BuildContext context) {
    String lang = Provider.of<LocalizationProvider>(context, listen: false).locale.languageCode;
    return Container(
      height: Dimensions.cardHeight-75,
      margin: const EdgeInsets.symmetric(vertical: 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: ColorResources.white,
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)],
      ),
      child: Stack(children: [
        SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            // Product Image
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge, vertical: Dimensions.paddingSizeSmall),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text(widget.level!.title ?? "",
                      style: beINNormal.copyWith(
                          color: ColorResources.primaryOrangeColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),

                  SizedBox(height: Dimensions.paddingSizeExtraLarge,),
                  RichText(
                    text: TextSpan(text: '${getTranslated("levelPoints", context) ?? "Level Points"} :', style: beINNormal.copyWith(fontSize: 12,color: ColorResources.primaryOrangeColor,), children: [
                      TextSpan(
                        text: '  ${int.parse(widget.level!.points.toString())*4}',
                        style: droidNormal.copyWith(fontWeight: FontWeight.bold, fontSize: 14,color: ColorResources.primaryOrangeColor,),
                      ),
                    ]),
                  ),
                  RichText(
                    text: TextSpan(text: '${getTranslated("ernedPoints", context) ?? "Progress"} :', style: beINNormal.copyWith(fontSize: 12,color: ColorResources.primaryOrangeColor,), children: [
                      TextSpan(
                        text: '  ${widget.level!.progress!=null?widget.level!.progress!.points:0}',
                        style: droidNormal.copyWith(fontWeight: FontWeight.bold, fontSize: 14,color: ColorResources.primaryOrangeColor,),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ]),
        ),
        Positioned(
            top: 0,
            left: 0,
            child: Container(
              height: 20,
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
              decoration: BoxDecoration(
                color: ColorResources.primaryOrangeColor.withOpacity(0.8),
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), bottomRight: Radius.circular(10)),
              ),
              child: Center(
                child: Text(
                  (widget.level!.progress!=null)?
                  int.parse(widget.level!.progress!.points!)<int.parse(widget.level!.points!)?
                  getTranslated("partiallyPlayed", context) ?? "Partially Played":getTranslated("Played", context) ?? "Played"
                      :getTranslated("notPlayed", context) ?? "Not Played"
                  ,
                  style: robotoRegular.copyWith(
                      color: Colors.white, //Theme.of(context).highlightColor,
                      fontSize: Dimensions.fontSizeSmall),
                ),
              ),
            ))
      ]),
    );
  }

}
