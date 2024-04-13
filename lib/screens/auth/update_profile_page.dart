import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:learnjava/data/model/response/config_model.dart';
import 'package:learnjava/data/model/response/user_info_model.dart';
import 'package:learnjava/providers/profile_provider.dart';
import 'package:provider/provider.dart';

import '../../../../localization/language_constrants.dart';
import '../../../../providers/localization_provider.dart';
import '../../../../utill/color_resources.dart';
import '../../../../utill/custom_themes.dart';
import '../../../../utill/dimensions.dart';
import '../../data/model/body/register_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/splash_provider.dart';
import '../../utill/images.dart';
import '../base_widgets/customTextFieldContainer.dart';
import '../base_widgets/custom_app_bar.dart';
import '../base_widgets/drawer/Drawer.dart';
import '../base_widgets/passwordHideShowButton.dart';

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});
  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> with TickerProviderStateMixin {
  GlobalKey<FormState>? _formKey;

  final TextEditingController _userNameTextEditingController = TextEditingController(text: null); //default grNumber
  final TextEditingController _nameTextEditingController = TextEditingController(text: null); //default grNumber

  final TextEditingController _passwordTextEditingController = TextEditingController(text: null); //default password

  bool _hidePassword = true;
  RegisterModel register = RegisterModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _formKey = GlobalKey<FormState>();
    _userNameTextEditingController.text = Provider.of<ProfileProvider>(context,listen: false).userInfoModel!.username ?? "";
    _nameTextEditingController.text = Provider.of<ProfileProvider>(context,listen: false).userInfoModel!.name ?? "";

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
                        getTranslated("update_profile", context) ?? "Update User Info",
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
                ],
              ),
            ),
          ),
        ]));
  }

  Widget levelInfoWidget(BuildContext context) {
    String lang = Provider.of<LocalizationProvider>(context, listen: false).locale.languageCode;
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: ColorResources.white,
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 5)],
      ),
      child: Stack(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          // Product Image
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge, vertical: Dimensions.paddingSizeSmall),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildLoginForm(),
              ],
            ),
          ),
        ]),
      ]),
    );
  }

  Widget _buildLoginForm() {
    return Consumer<ProfileProvider>(builder: (context, profile, child) {
      return SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Text(
                getTranslated("update_profile", context) ?? "Update User Info",
                style: TextStyle(
                  fontSize: 24.0,
                  height: 1.5,
                  color: ColorResources.black,
                ),
              ),
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                        text: '${getTranslated("userPoints", context) ?? "User Points"} :',
                        style: beINNormal.copyWith(
                          fontSize: 14,
                          color: ColorResources.black,
                        ),
                        children: [
                          TextSpan(
                            text: '  ${int.parse(profile.userInfoModel!.total_points.toString())}\n',
                            style: droidNormal.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: ColorResources.primaryOrangeColor,
                            ),
                          ),
                          TextSpan(
                              text: '${getTranslated("playCount", context) ?? "Play Counts"} :',
                              style: beINNormal.copyWith(
                                fontSize: 14,
                                color: ColorResources.black,
                              )),
                          TextSpan(
                            text: '  ${int.parse(profile.userInfoModel!.play_count!.toString())}',
                            style: droidNormal.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: ColorResources.primaryOrangeColor,
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
              const SizedBox(
                height: Dimensions.paddingSizeDefault,
              ),
              const SizedBox(
                height: 30.0,
              ),
              CustomTextFieldContainer(
                hideText: false,
                hintTextKey: getTranslated("Name", context) ?? "Name",
                bottomPadding: 0,
                textEditingController: _nameTextEditingController,
                suffixWidget: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    Images.user,
                    colorFilter: ColorFilter.mode(
                      ColorResources.primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              CustomTextFieldContainer(
                hideText: false,
                hintTextKey: "User Name",
                bottomPadding: 0,
                textEditingController: _userNameTextEditingController,
                suffixWidget: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    Images.user,
                    colorFilter: ColorFilter.mode(
                      ColorResources.primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              CustomTextFieldContainer(
                textEditingController: _passwordTextEditingController,
                suffixWidget: PasswordHideShowButton(
                  hidePassword: _hidePassword,
                  onTap: () {
                    setState(() {
                      _hidePassword = !_hidePassword;
                    });
                  },
                ),
                hideText: _hidePassword,
                hintTextKey: getTranslated("PASSWORD", context) ?? "Password",
                bottomPadding: 0,
              ),
              const SizedBox(
                height: 30.0,
              ),
              Center(
                  child: Provider.of<ProfileProvider>(context).isLoading
                      ? Container(
                          height: 30,
                          margin: const EdgeInsets.symmetric(horizontal: 50, vertical: Dimensions.marginSizeExtraLarge),
                          child: const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                ColorResources.primaryColor,
                              ),
                            ),
                          ))
                      : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          //
                          alignment: Alignment.center,
                          height: 55.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: ColorResources.primaryColor,
                            border: Border.all(
                              color: ColorResources.primaryColor,
                            ),
                          ),
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: TextButton(
                            onPressed: () {
                              saveUser();
                            },
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Text(getTranslated('save', context) ?? "Save", style: titilliumSemiBold.copyWith(color: ColorResources.white, fontSize: Dimensions.fontSizeLarge)),
                            ),
                          ))),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * (0.035),
              ),
            ],
          ),
        ),
      );
    });
  }

  saveUser() async {
    if (_formKey!.currentState!.validate()) {
      _formKey!.currentState!.save();
      String password = _passwordTextEditingController.text.trim();
      if (_nameTextEditingController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('NAME_FIELD_MUST_BE_REQUIRED', context)!),
          backgroundColor: Colors.red,
        ));
      } else if (_userNameTextEditingController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('USER_NAME_FIELD_MUST_BE_REQUIRED', context)!),
          backgroundColor: ColorResources.primaryOrangeColor,
        ));
      } else if (password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated('PASSWORD_MUST_BE_REQUIRED', context)!),
          backgroundColor: ColorResources.primaryOrangeColor,
        ));
      } else {
        // register.fName = _firstNameController.text;
        // register.lName = _lastNameController.text;
        register.name = _nameTextEditingController.text;
        register.password = _passwordTextEditingController.text;
        register.username = _userNameTextEditingController.text;
        await Provider.of<ProfileProvider>(context, listen: false).updateProfile(register, route);
      }
    }
  }

  route(bool isRoute, UserInfoModel? user, String? Message) async {
    if (isRoute) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated(Message!, context) ?? Message), backgroundColor: ColorResources.primaryOrangeColor));
      await Provider.of<ProfileProvider>(context, listen: false).getProfile(context);
      await Provider.of<SplashProvider>(context, listen: false).initConfig(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated(Message!, context) ?? Message), backgroundColor: ColorResources.primaryOrangeColor));
    }
  }
}
