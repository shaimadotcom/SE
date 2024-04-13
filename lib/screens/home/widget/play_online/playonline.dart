import 'package:flutter/material.dart';
import 'package:learnjava/data/model/response/config_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../localization/language_constrants.dart';
import '../../../../providers/splash_provider.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import 'OnlineLevelsPage.dart';

class PlayOnLineWidget extends StatefulWidget {
  const PlayOnLineWidget({super.key,this.index});
  final int? index;

  @override
  State<PlayOnLineWidget> createState() => _PlayOnLineWidgetState();
}

class _PlayOnLineWidgetState extends State<PlayOnLineWidget> {
    final ScrollController _scrollController = ScrollController();
    bool showActions = false;
    bool _isClicked = false;
    OnlineLevels? selectedLevel;

    @override
    Widget build(BuildContext context) {
      return
        // Consumer<TripsProvider>(
        //   builder: (context, trip, child) =>
        Container(
          width: double.infinity,
          //height:MediaQuery.of(context).size.height,
          color: ColorResources.pagecolor,
          child: Column(
            children: [
              //SelectSrcDstWidget(),
              const SizedBox(
                height: Dimensions.paddingSizeDefault,
              ),
              StepsWidget(context)
            ],
          ),
          //)
        );
    }

    Widget StepsWidget(BuildContext context) {
      return Consumer<SplashProvider>(builder: (context, splashProvider, child) {
        return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: Dimensions.paymentcardHeight+50,
            ),
            itemCount: splashProvider
                .configModel!
                .data!
                .onlineLevels!
                .length,
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return gridItem(splashProvider.configModel!.data!.onlineLevels![index]);
            });
      });}

    void _handleClick(OnlineLevels level) {
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) =>  OnlineLevelsPage(
        level: level,

      )));

    }

    Widget gridItem(OnlineLevels level ){
      return GestureDetector(
          onTap:(){
            final option = level;
            setState(() {
              selectedLevel != null
                  ? selectedLevel == option
                  ? selectedLevel=null
                  : selectedLevel=level:
              selectedLevel=level
              ;//
              // showActions = !showActions;
            });},
        child: Stack(
          children: [Container(
            margin: const EdgeInsets.all(5),
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
            child: Stack(
              children: [Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(flex: 1,),
                    Center(
                      child: Text(level.title ?? "",
                        style: beINNormal.copyWith(
                            color: ColorResources.primaryOrangeColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    Spacer(flex: 1,),
                    RichText(
                      text: TextSpan(text: '${getTranslated("levelPoints", context) ?? "Level Points"} :', style: beINNormal.copyWith(fontSize: 12,color: ColorResources.black,), children: [
                        TextSpan(
                          text: '  ${int.parse(level.points!.toString())*4}',
                          style: droidNormal.copyWith(fontWeight: FontWeight.bold, fontSize: 14,color: ColorResources.primaryOrangeColor,),
                        ),
                      ]),
                    ),
                    RichText(
                      text: TextSpan(text: '${getTranslated("ernedPoints", context) ?? "Progress"} :', style: beINNormal.copyWith(fontSize: 12,color: ColorResources.black,), children: [
                        TextSpan(
                          text: '  ${(level.progress!=null)?level.progress!.points:0}',
                          style: droidNormal.copyWith(fontWeight: FontWeight.bold, fontSize: 14,color: ColorResources.primaryOrangeColor,),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
                Positioned(
                    top: 3,
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
                          (level.progress!=null)?
                          // int.parse(level.progress!.points!)<int.parse(level.points!)?
                          //getTranslated("partiallyPlayed", context) ?? "Partially Played":
                          getTranslated("Played", context) ?? "Played"
                              :getTranslated("notPlayed", context) ?? "Not Played"
                          ,
                          style: robotoRegular.copyWith(
                              color: Colors.white, //Theme.of(context).highlightColor,
                              fontSize: Dimensions.fontSizeSmall),
                        ),
                      ),
                    )),
              ],
            ),
          ),
           ( selectedLevel!=null&&selectedLevel==level)
                ? Positioned(
                bottom: 0,
                left: 5,
                right: 5,
                child: Container(
                  padding: EdgeInsets.only(bottom: 0),
                  height: 40,
                  decoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.only(bottomRight: Radius.circular(13),bottomLeft:Radius.circular(13) ), color: ColorResources.primaryOrangeColor),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () async {
                            _handleClick(level);
                          },
                          child: Text(
                            getTranslated('Play', context) ?? "Play",
                            style: beINNormal.copyWith(color: ColorResources.white, fontSize: 11),
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: Colors.white,
                        ),
                        TextButton(
                          onPressed: () async {
                            _launchInBrowserView(Uri.parse(level.vidoeUrl!));
                          },
                          child: Text(
                            getTranslated('Watch', context) ?? "Watch",
                            style: beINNormal.copyWith(color: ColorResources.white, fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
                : const SizedBox(),

          ],
        ),
      );
    }
    Future<void> _launchInBrowserView(Uri url) async {
      if (!await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {
        throw Exception('Could not launch $url');
      }
    }
}

