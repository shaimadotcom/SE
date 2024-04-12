import 'package:flutter/material.dart';
import 'package:learnjava/localization/language_constrants.dart';
import 'package:learnjava/utill/color_resources.dart';

class CustomTextFieldContainer extends StatelessWidget {
  final String hintTextKey;
  final bool hideText;
  final double? bottomPadding;
  final Widget? suffixWidget;
  final TextEditingController? textEditingController;
  const CustomTextFieldContainer(
      {Key? key,
      this.bottomPadding,
      this.suffixWidget,
      required this.hideText,
      required this.hintTextKey,
      this.textEditingController,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.only(bottom: bottomPadding ?? 20.0),
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ColorResources.primaryColor),),
      child: TextFormField(
        controller: textEditingController,
        obscureText: hideText,
        decoration: InputDecoration(
            suffixIcon: suffixWidget,
            hintStyle:
                TextStyle(color: ColorResources.primaryColor),
            hintText: getTranslated(hintTextKey,context )??hintTextKey,
            border: InputBorder.none,),
      ),
    );
  }
}
