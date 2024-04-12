import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:learnjava/providers/sound_provider.dart';
import 'package:learnjava/screens/auth/login_screen.dart';
import 'package:learnjava/screens/base_widgets/drawer/profile_Drawer_header.dart';
import 'package:learnjava/screens/base_widgets/drawer/separator.dart';

import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';
import '../../../providers/localization_provider.dart';
import '../../../utill/app_constants.dart';
import '../../../utill/color_resources.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/images.dart';
import '../../dashboard/dashboard_screen.dart';
import 'drawerItem.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String selected_lang = "en";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool switchval=Provider.of<SoundProvider>(context).isSoundPlaying;
    return SafeArea(
      child: Container(
        color: ColorResources.white,
        child: Stack(children: [
          Padding(
            padding: EdgeInsets.only( bottom: 50),
            child: Column(children: [
              Container(
                height: MediaQuery.of(context).size.height>600?MediaQuery.of(context).size.height*0.25:MediaQuery.of(context).size.height*0.35,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius:
                        const BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12)),
                    color: ColorResources.primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: ColorResources.primaryColor.withOpacity(0.4),
                        blurRadius: 8,
                        offset: Offset(1, 6), // Shadow position
                      ),
                    ]),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const UserProfileDrawerHeader(),
                ),
              ),
              SizedBox(
                height: 25,
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        DrawerItemWidget(
                            title: "Play Sound",
                            svgimage: Images.help,
                            color: ColorResources.primaryColor,
                            onPress: () {
                            },
                          withtrail: true,
                          trail:Switch(
                            value: switchval,
                            activeColor: ColorResources.primaryColor,
                            onChanged: (value) {
                              Provider.of<SoundProvider>(context,listen: false).toggleSound();
                              switchval=!Provider.of<SoundProvider>(context,listen: false).isSoundPlaying;
                              setState(() {
                              });
                            },
                          )
                        ),
                        DrawerItemWidget(
                          title: "Language",
                          svgimage: Images.languageDrawer,
                          color: ColorResources.primaryColor,
                          onPress: () {

                          },
                          withtrail: true,
                          trail: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              dropdownStyleData: DropdownStyleData(
                                  width: 100, offset: const Offset(-50, 10)),
                              value:Provider.of<LocalizationProvider>(context, listen: false).getLanguageByCode(Provider.of<LocalizationProvider>(context, listen: false).locale.languageCode).languageName,// selected_lang.toUpperCase(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  Provider.of<LocalizationProvider>(context, listen: false).setLanguage(Locale(
                                    Provider.of<LocalizationProvider>(context, listen: false).getLanguageByName(newValue!).languageCode!,
                                    Provider.of<LocalizationProvider>(context, listen: false).getLanguageByName(newValue).countryCode,
                                  ));
                                });
                              },
                              items: AppConstants.languages.map((value) {
                                return DropdownMenuItem<String>(
                                    value: value.languageName!,
                                    child: Text(value.languageName??"",style: beINNormal.copyWith(
                                      color: ColorResources.drawertext,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    )));
                              }).toList(),
                            ),
                          ),
                        ),
                        Container(
                          color: Theme.of(context).drawerTheme.backgroundColor,
                          height: 10, //height of container
                          child: MySeparator(
                              color: ColorResources.primaryColor.withOpacity(0.2)),
                        ),
                        DrawerItemWidget(
                            title:"Logout",
                            svgimage: Images.logout,
                            color: ColorResources.primaryColor,
                            onPress: () async {
                              await Provider.of<AuthProvider>(context, listen: false).logout();
                              setState(() {
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
                              });
                              // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),

        ]),
      ),
    );
  }
}