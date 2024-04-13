import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../localization/language_constrants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
class MenuItem {
  final String? image;
  final String? title;

  MenuItem({
    required this.image,
    required this.title,
  });
}
class MenuItemContainer extends StatelessWidget {
  const MenuItemContainer({super.key, required this.onTap, this.index, this.selected, this.item});
  final MenuItem? item;
  final Function onTap;
  final int? index;
  final bool?selected;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        onTap(index);
      },
      child: SizedBox(
        width:Dimensions.homeMenuItemWidth+20 ,
        height:Dimensions.homeMenuItemHeight+11,
        child: Column(
          children: [
            Container(
              width: Dimensions.paddingSizeFortyFive,
              height:Dimensions.paddingSizeFortyFive,
              padding:index==1?const EdgeInsets.all(0): const EdgeInsets.all(9),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color:(selected??false)?ColorResources.primaryColor: ColorResources.menuItem
              ),
              child: SvgPicture.asset(item!.image!,color: ColorResources.white,),
            ),
            const SizedBox(height: 1,),
            Text(getTranslated(item!.title??"", context)??item!.title??"",style: droidNormal.copyWith(fontSize: 14,color: ColorResources.textblack),)
            //Text("Departure and\ndestination",style: droidNormal.copyWith(fontSize: 9,color: ColorResources.textblack),)
          ],
        ),
      ),
    );
  }
}
