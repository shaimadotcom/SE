import 'package:flutter/material.dart';

import '../../utill/color_resources.dart';
import '../../utill/dimensions.dart';
import 'customUserProfileImageWidget.dart';

class BorderedProfilePictureContainer extends StatelessWidget {
  final BoxConstraints boxConstraints;
  final String imageUrl;
  final Function? onTap;
  final Icon? icon;
  final double? heightAndWidthPercentage;
  const BorderedProfilePictureContainer({
    Key? key,
    this.icon,
    required this.boxConstraints,
    required this.imageUrl,
    this.heightAndWidthPercentage,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      // borderRadius: BorderRadius.circular(
      //   boxConstraints.maxWidth *
      //       (heightAndWidthPercentage == null
      //           ? Dimensions.defaultProfilePictureHeightAndWidthPercentage * (0.5)
      //           : heightAndWidthPercentage! * (0.5)),
      // ),
      onTap: () {
        onTap?.call();
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(13)),
          color: ColorResources.white,
          border: Border.all(
            width: 1,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        width: boxConstraints.maxWidth *
            (heightAndWidthPercentage ??
                Dimensions.defaultProfilePictureHeightAndWidthPercentage),
        height: boxConstraints.maxWidth *
            (heightAndWidthPercentage ??
                Dimensions.defaultProfilePictureHeightAndWidthPercentage),
        child: CustomUserProfileImageWidget(profileUrl: imageUrl,icon:icon),
      ),
    );
  }
}
