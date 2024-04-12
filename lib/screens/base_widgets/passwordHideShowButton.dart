import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learnjava/utill/images.dart';

class PasswordHideShowButton extends StatelessWidget {
  final bool hidePassword;
  final Function onTap;
  final double? allSidePadding;
  const PasswordHideShowButton({
    Key? key,
    required this.hidePassword,
    required this.onTap,
    this.allSidePadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(allSidePadding ?? 12.0),
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: SvgPicture.asset(
          hidePassword ? Images.hidepass :Images.showpass,
          ),
          // colorFilter: ColorFilter.mode(
          //     UiUtils.getColorScheme(context).secondary, BlendMode.srcIn),
        ),

    );
  }
}
