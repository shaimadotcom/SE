import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../localization/language_constrants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';

class DrawerItemWidget extends StatelessWidget {
  DrawerItemWidget(
      {Key? key,
      required this.title,
      this.svgimage,
      required this.onPress,
      this.icon,
      this.width,
      this.trail,
      this.color,
      this.withtrail})
      : super(key: key);

  final String title;
  final bool? withtrail;
  final String? svgimage;
  final VoidCallback onPress;
  final IconData? icon;
  final Color? color;
  final Widget? trail;
  final bool? width;
  String? selectedLang;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: onPress,
        leading: icon != null
            ? Icon(
                icon,
                color:color?? ColorResources.primaryColor,
              )
            : (width ?? false)
                ? SizedBox(
                    width: 30,
                    height: 30,
                    child: SvgPicture.asset(
                      svgimage!,
                      // width: 25.w,
                      // height: 25.h,
                      color: color ?? ColorResources.primaryColor,
                    ),
                  )
                : SvgPicture.asset(
                    svgimage!,
                    // width: 25.w,
                    // height: 25.h,
                    color: color ?? ColorResources.primaryColor,
                  ),
        title: Text(getTranslated(title, context)??title,style:beINNormal.copyWith(
          color: ColorResources.drawertext,
          fontSize: 15,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal
        )
        ),
        titleAlignment: ListTileTitleAlignment.titleHeight,
        trailing: (withtrail ?? false)
            ? trail
            :
            const SizedBox(
                width: 0,
                height: 0,
              ));
  }
}
