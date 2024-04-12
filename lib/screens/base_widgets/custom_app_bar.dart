import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learnjava/providers/profile_provider.dart';
import 'package:learnjava/screens/auth/update_profile_page.dart';
import 'package:learnjava/screens/scores/users_scores_page.dart';
import 'package:learnjava/utill/custom_themes.dart';
import 'package:provider/provider.dart';
import '../../../utill/color_resources.dart';
import '../../localization/language_constrants.dart';
import '../../providers/localization_provider.dart';
import '../../utill/dimensions.dart';
import '../../utill/images.dart';
import 'borderedProfilePictureContainer.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? child;
  final bool? homeBar;
  final Color? color;
  final double? height;
  final Color? iconColor;
  final Color? textColor;
   CustomAppBar({Key? key, this.title, this.homeBar, this.color, this.height, this.iconColor, this.textColor, this.child}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(400, 250);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top - Dimensions.screenContentTopPadding,
        ),
        alignment: Alignment.topCenter,
        width: MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height>600?  MediaQuery.of(context).size.height * 0.28:MediaQuery.of(context).size.height*0.33,
        decoration: BoxDecoration(
          color: ColorResources.primaryColor,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        child:
        // Consumer<ProfileProvider>(
        //     builder: (context, auth, child) =>
            LayoutBuilder(
          builder: (context, boxConstraints) {
            return
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge, vertical: Dimensions.paddingSizeExtraLarge),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
                    IconButton(
                      icon: SvgPicture.asset(
                        Images.menu,
                        fit: BoxFit.fill,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                    SizedBox(width: 25,),
                        Container(
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
                            height: 40,
                            child:Center(
                              child: Consumer<ProfileProvider>(
                                builder: (BuildContext context, ProfileProvider profile, Widget? child) {
                                  return RichText(
                                    text: TextSpan(text: '${(profile.userInfoModel!.total_points ?? 0).toString()} ', style: droidNormal.copyWith(color: ColorResources.red, fontSize: 12,fontWeight: FontWeight.bold,  ), children: [
                                      TextSpan(
                                        text:getTranslated('points', context) ??'points',
                                        style: droidNormal.copyWith(fontSize: 12),
                                      ),
                                    ]),
                                  //
                                  //
                                  //   Text(
                                  // '${profile.totalPoints.toString()??""} points',
                                  // style: beINNormal.copyWith(
                                  //   fontSize: 12,
                                  //   color: ColorResources.black
                                  // ),

                                );
                                }
                              ),
                            ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    (widget.homeBar??false)?
                    BorderedProfilePictureContainer(
                          boxConstraints: boxConstraints,
                          imageUrl: '',
                      icon:const Icon(Icons.score),
                      onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const UsersscorePage()));
                          },
                        ):const SizedBox.shrink(),
                    SizedBox(width: 5,),
                    (widget.homeBar??false)?
                    BorderedProfilePictureContainer(
                      boxConstraints: boxConstraints,
                      imageUrl: '',
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const UpdateProfilePage()));
                      },
                      // context
                      //     .read<AuthCubit>()
                      //     .getStudentDetails()
                      //     .image,
                    ):
                    IconButton(
                      icon:Provider.of<LocalizationProvider>(context, listen: false).locale.languageCode != "ar" ?
                      SvgPicture.asset(Images.back_r) : SvgPicture.asset(Images.back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ]),
                  const Divider(
                    color: ColorResources.pagecolor, // color of divider
                    thickness: 0.25, // thickness of divider line
                  ),
                ],
              ),
            )
            ;
          },
        )
    //)
    );
  }
}
