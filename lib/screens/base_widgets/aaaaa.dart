// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/widgets.dart';
// // import 'package:flutter_svg/svg.dart';
// // import 'package:intl/intl.dart';
// // import 'package:learnjava/data/model/response/config_model.dart';
// // import 'package:provider/provider.dart';
// //
// // import '../../../../localization/language_constrants.dart';
// // import '../../../../providers/localization_provider.dart';
// // import '../../../../utill/color_resources.dart';
// // import '../../../../utill/custom_themes.dart';
// // import '../../../../utill/dimensions.dart';
// // import '../../../base_widgets/custom_app_bar.dart';
// // import '../../../base_widgets/drawer/Drawer.dart';
// //
// // class OfflineLevelsPage extends StatefulWidget {
// //   const OfflineLevelsPage({super.key, this.level});
// //   final OfflineLevels? level;
// //
// //   @override
// //   State<OfflineLevelsPage> createState() => _OfflineLevelsPageState();
// // }
// //
// // class _OfflineLevelsPageState extends State<OfflineLevelsPage> {
// //   @override
// //   void initState() {
// //     // TODO: implement initState
// //     super.initState();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     double height = MediaQuery.of(context).size.height;
// //     return Scaffold(
// //         backgroundColor: ColorResources.pagecolor,
// //         drawer: const Drawer(
// //           child: CustomDrawer(),
// //         ),
// //         body: Stack(children: [
// //           Align(alignment: Alignment.topCenter, child: CustomAppBar()),
// //           Positioned(
// //             top: Dimensions.appBarBodyStackTop, // Adjust this value to overlap from point 100
// //             left: Dimensions.appBarStackedContainerPadding,
// //             right: Dimensions.appBarStackedContainerPadding,
// //             //bottom:-51,
// //             child: SizedBox(
// //               height: height,
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                     children: [
// //                       Text(
// //                         getTranslated("trip_info", context) ?? "Your Booked Trip Info",
// //                         style: beINNormal.copyWith(
// //                           fontSize: 14,
// //                           color: ColorResources.white,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   const SizedBox(
// //                     height: Dimensions.paddingSizeDefault,
// //                   ),
// //                   tripInfoWidget(context),
// //                   const SizedBox(
// //                     height: Dimensions.paddingSizeDefault,
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ),
// //           Positioned(
// //               left: Dimensions.appBarStackedContainerPadding,
// //               right: Dimensions.appBarStackedContainerPadding,
// //               bottom: Dimensions.paddingSizeExtraExtraSmall,
// //               child: TextButton(
// //                 onPressed: () async {
// //                   // PageRouteBuilder(
// //                   //     transitionDuration: const Duration(milliseconds: 500),
// //                   //     pageBuilder: (context, anim1, anim2) => PaymentPage(
// //                   //       company: widget.trip!.company,
// //                   //     ));
// //                 },
// //                 style: ButtonStyle(
// //                   overlayColor: MaterialStateProperty.resolveWith<Color>(
// //                         (Set<MaterialState> states) {
// //                       return ColorResources.primaryOrangeColor.withOpacity(0.09); // Set overlay color to transparent
// //                     },
// //                   ),
// //                 ),
// //                 child: Container(
// //                   width: MediaQuery.of(context).size.width * Dimensions.homeButtonsPercentage,
// //                   padding: const EdgeInsets.symmetric(vertical: 8),
// //                   decoration: BoxDecoration(shape: BoxShape.rectangle, color: ColorResources.primaryOrangeColor, borderRadius: const BorderRadius.all(Radius.circular(6))),
// //                   child: Align(
// //                     alignment: Alignment.center,
// //                     child: Text(
// //                       getTranslated('Pay', context) ?? "Payment",
// //                       style: beINNormal.copyWith(color: ColorResources.white, fontSize: 14),
// //                     ),
// //                   ),
// //                 ),
// //               ))
// //         ]));
// //   }
// //
// //   Widget tripInfoWidget(BuildContext context) {
// //     String lang = Provider.of<LocalizationProvider>(context, listen: false).locale.languageCode;
// //     return Container(
// //       height: Dimensions.cardHeight,
// //       margin: const EdgeInsets.symmetric(vertical: 5),
// //       decoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(12),
// //         color: ColorResources.primaryColor,
// //         //boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)],
// //       ),
// //       child: Stack(children: [
// //         Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
// //           // Product Image
// //           Container(
// //             height: Dimensions.cardHeight - 60,
// //             decoration: const BoxDecoration(
// //               color: ColorResources.white,
// //               borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(12)),
// //             ),
// //             child: Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge, vertical: Dimensions.paddingSizeExtraLarge),
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [],
// //               ),
// //             ),
// //           ),
// //           // Trip Details
// //           Padding(
// //             padding: const EdgeInsets.only(left: Dimensions.paddingSizeExtraLarge, right: Dimensions.paddingSizeExtraLarge, top: Dimensions.paddingSizeDefault),
// //             child: Row(
// //                 crossAxisAlignment: CrossAxisAlignment.center,
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: lang == "ar"
// //                     ? [
// //                   Text('ali  ل.س', style: droidNormal.copyWith(fontSize: Dimensions.fontSizeSmall, color: ColorResources.white, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
// //                 ]
// //                     : [
// //                   Text('alaa', style: droidNormal.copyWith(fontSize: Dimensions.fontSizeSmall, color: ColorResources.white, fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis),
// //                 ]),
// //           ),
// //         ]),
// //         (widget.level!.points == 1)
// //             ? Positioned(
// //             top: 0,
// //             left: 0,
// //             child: Container(
// //               height: 20,
// //               padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
// //               decoration: BoxDecoration(
// //                 color: ColorResources.primaryColor,
// //                 borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
// //               ),
// //               child: Center(
// //                 child: Text(
// //                   getTranslated("vip", context) ?? "VIP",
// //                   style: robotoRegular.copyWith(
// //                       color: Colors.white, //Theme.of(context).highlightColor,
// //                       fontSize: Dimensions.fontSizeSmall),
// //                 ),
// //               ),
// //             ))
// //             : const SizedBox(),
// //         (widget.level!.points == 0)
// //             ? Positioned(
// //             top: 0,
// //             right: 0,
// //             child: Container(
// //               height: 20,
// //               padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
// //               decoration: BoxDecoration(
// //                 color: ColorResources.primaryOrangeColor,
// //                 borderRadius: const BorderRadius.only(topRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
// //               ),
// //               child: Center(
// //                 child: Text(
// //                   getTranslated("full", context) ?? "Full",
// //                   style: robotoRegular.copyWith(
// //                       color: Colors.white, //Theme.of(context).highlightColor,
// //                       fontSize: Dimensions.fontSizeSmall),
// //                 ),
// //               ),
// //             ))
// //             : const SizedBox()
// //       ]),
// //     );
// //   }
// //
// // }
// //
// // class PaymentType {
// //   String title;
// //   Widget image;
// //   PaymentType({required this.title, required this.image});
// // }
//
//
//
//
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:intl/intl.dart';
// import 'package:learnjava/data/model/response/config_model.dart';
// import 'package:provider/provider.dart';
//
// import '../../../../localization/language_constrants.dart';
// import '../../../../providers/localization_provider.dart';
// import '../../../../utill/color_resources.dart';
// import '../../../../utill/custom_themes.dart';
// import '../../../../utill/dimensions.dart';
// import '../../../base_widgets/custom_app_bar.dart';
// import '../../../base_widgets/drawer/Drawer.dart';
//
// class OfflineLevelsPage extends StatefulWidget {
//   const OfflineLevelsPage({super.key, this.level});
//   final OfflineLevels? level;
//
//   @override
//   State<OfflineLevelsPage> createState() => _OfflineLevelsPageState();
// }
//
// class _OfflineLevelsPageState extends State<OfflineLevelsPage> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     return Scaffold(
//         backgroundColor: ColorResources.pagecolor,
//         drawer: const Drawer(
//           child: CustomDrawer(),
//         ),
//         body: Stack(children: [
//           Align(alignment: Alignment.topCenter, child: CustomAppBar()),
//           Positioned(
//             top: Dimensions.appBarBodyStackTop, // Adjust this value to overlap from point 100
//             left: Dimensions.appBarStackedContainerPadding,
//             right: Dimensions.appBarStackedContainerPadding,
//             //bottom:-51,
//             child: SizedBox(
//               height: height,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         getTranslated("level_info", context) ?? "Level Info",
//                         style: beINNormal.copyWith(
//                           fontSize: 14,
//                           color: ColorResources.white,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: Dimensions.paddingSizeDefault,
//                   ),
//                   levelInfoWidget(context),
//                   const SizedBox(
//                     height: Dimensions.paddingSizeDefault,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ]));
//   }
//
//   Widget levelInfoWidget(BuildContext context) {
//     String lang = Provider.of<LocalizationProvider>(context, listen: false).locale.languageCode;
//     return Container(
//       height: Dimensions.cardHeight-50,
//       margin: const EdgeInsets.symmetric(vertical: 5),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         color: ColorResources.white,
//         boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)],
//       ),
//       child: Stack(children: [
//         Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//           // Product Image
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge, vertical: Dimensions.paddingSizeExtraLarge),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [],
//             ),
//           ),
//         ]),
//
//       ]),
//     );
//   }
//
// }
