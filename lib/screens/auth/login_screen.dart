import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learnjava/localization/language_constrants.dart';
import 'package:learnjava/providers/auth_provider.dart';
import 'package:learnjava/providers/splash_provider.dart';
import 'package:learnjava/screens/auth/register_screen.dart';
import 'package:learnjava/screens/base_widgets/customTextFieldContainer.dart';
import 'package:learnjava/screens/base_widgets/passwordHideShowButton.dart';
import 'package:learnjava/utill/app_constants.dart';
import 'package:learnjava/utill/color_resources.dart';
import 'package:learnjava/utill/custom_themes.dart';
import 'package:learnjava/utill/dimensions.dart';
import 'package:learnjava/utill/images.dart';
import 'package:provider/provider.dart';

import '../../data/model/body/login_model.dart';
import '../../providers/localization_provider.dart';
import '../../providers/profile_provider.dart';
import '../dashboard/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1000),
  );

  late final Animation<double> _patterntAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
    ),
  );

  late final Animation<double> _formAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
    ),
  );

  final TextEditingController _userNameTextEditingController = TextEditingController(text: null); //default grNumber

  final TextEditingController _passwordTextEditingController = TextEditingController(text: null); //default password

  bool _hidePassword = true;
  GlobalKey<FormState>? _formKeyLogin;
  LoginModel loginBody = LoginModel();

  @override
  void initState() {
    super.initState();
    _animationController.forward();
    _formKeyLogin = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _userNameTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }

  Future<void> _route(bool isRoute, String? token, String? temporaryToken, String? errorMessage) async {
    if (isRoute) {
      await Provider.of<ProfileProvider>(context, listen: false).getProfile(context);

      await Provider.of<SplashProvider>(context, listen: false).initConfig(context);
      if(context.mounted){}
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const DashBoardScreen()), (route) => false);
      //}
    } else
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getTranslated(errorMessage!, context)??errorMessage ), backgroundColor: ColorResources.primaryOrangeColor));
    }
  }

  Future<void> _signInStudent() async {
    if (_formKeyLogin!.currentState!.validate()) {
      _formKeyLogin!.currentState!.save();
      if (_userNameTextEditingController.text
          .trim()
          .isEmpty) {
        AppConstants.showCustomSnackBar(
          context: context,
          errorMessage: getTranslated("please Enter User Name", context) ?? "please Enter User Name",
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .error,
        );
        return;
      }

      if (_passwordTextEditingController.text
          .trim()
          .isEmpty) {
        AppConstants.showCustomSnackBar(
          context: context,
          errorMessage: getTranslated("please Enter Passsword", context) ?? "please Enter Password",
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .error,
        );
        return;
      }
      loginBody.username = _userNameTextEditingController.text;
      loginBody.password = _passwordTextEditingController.text;
      await Provider.of<AuthProvider>(context, listen: false).login(loginBody, _route);
    }
  }

  Widget _buildRequestResetPasswordContainer() {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        // child: GestureDetector(
        //   onTap: () {
        //     // if (UiUtils.isDemoVersionEnable()) {
        //     //   UiUtils.showFeatureDisableInDemoVersion(context);
        //     //   return;
        //     // }
        //     AppConstants.showBottomSheet(
        //       child: BlocProvider(
        //         create: (_) => RequestResetPasswordCubit(AuthRepository()),
        //         child: const RequestResetPasswordBottomsheet(),
        //       ),
        //       context: context,
        //     ).then((value) {
        //       if (value != null && !value['error']) {
        //         AppConstants.showCustomSnackBar(
        //           context: context,
        //           errorMessage: "Error",
        //           backgroundColor: Theme.of(context).colorScheme.onPrimary,
        //         );
        //       }
        //     });
        //   },
        child: Text(
          getTranslated("FORGET_PASSWORD", context) ?? "FORGET_PASSWORD",
          style: TextStyle(color: ColorResources.primaryColor),
        ),
        // ),
      ),
    );
  }

  Widget _buildUpperPattern() {
    return Align(
      alignment:Provider.of<LocalizationProvider>(context,listen: false).locale.languageCode=="ar"? AlignmentDirectional.topStart:AlignmentDirectional.topEnd,
      child: FadeTransition(
        opacity: _patterntAnimation,
        child: SlideTransition(
          position: _patterntAnimation.drive(
            Tween<Offset>(begin: const Offset(0.0, -1.0), end: Offset.zero),
          ),
          child: Image.asset(Images.upper),
        ),
      ),
    );
  }

  Widget _buildLowerPattern() {
    return Align(
      alignment:Provider.of<LocalizationProvider>(context,listen: false).locale.languageCode=="ar"? AlignmentDirectional.bottomEnd:AlignmentDirectional.bottomStart,
      child: FadeTransition(
        opacity: _patterntAnimation,
        child: SlideTransition(
          position: _patterntAnimation.drive(
            Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero),
          ),
          child: Image.asset(Images.lower),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    double height = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.topCenter,
      child: FadeTransition(
        opacity: _formAnimation,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: NotificationListener(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * (0.075),
                right: MediaQuery.of(context).size.width * (0.075),
                top: MediaQuery.of(context).size.height * (0.15),
              ),
              child: Form(
                key: _formKeyLogin,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * (0.5),
                          //height: MediaQuery.of(context).size.height * (0.5),
                          child: Image.asset(
                            Images.loginLogo,
                            height: 150,
                          )),
                    ),
                    Text(
                      getTranslated("Lets Sign in", context) ?? "Lets Sign in",
                      style: const TextStyle(
                        fontSize: 34.0,
                        fontWeight: FontWeight.bold,
                        color: ColorResources.black,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "${getTranslated("Are You ready?", context) ?? "Are You ready?"} \n${getTranslated("Lets Sign in", context) ?? "Lets Sign in!"}",
                      style: TextStyle(
                        fontSize: 24.0,
                        height: 1.5,
                        color: ColorResources.black,
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    CustomTextFieldContainer(
                      hideText: false,
                      hintTextKey:getTranslated("User Name", context) ?? "User Name",
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
                      hintTextKey:getTranslated("PASSWORD", context) ?? "Passsword",
                      bottomPadding: 0,
                    ),
                    _buildRequestResetPasswordContainer(),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Center(
                        child: Provider.of<AuthProvider>(context).isLoading
                            ? Container(
                            height: height * 0.07,
                            margin: const EdgeInsets.symmetric(horizontal: 50, vertical: Dimensions.marginSizeExtraLarge),
                            child: const Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  ColorResources.primaryColor,
                                ),
                              ),
                            ))
                            :
                         Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0), //
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
                                _signInStudent();
                              },
                              child: Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: Text(getTranslated('Login', context) ?? "Login", style: titilliumSemiBold.copyWith(color: ColorResources.white, fontSize: Dimensions.fontSizeLarge)),
                              ),
                            ))),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const RegisterScreen()));
                        },
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: ColorResources.primaryColor,
                                ),
                                text: getTranslated(
                                      "Don't Have Account?",
                                      context,
                                    ) ??
                                    "Don't Have Account?",
                              ),
                              const TextSpan(text: " "),
                              TextSpan(
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                  color: ColorResources.primaryOrangeColor,
                                ),
                                text:getTranslated(
                                  "Sign up",
                                  context,
                                ) ??
                                    "Sign up",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * (0.025),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildLowerPattern(),
          _buildUpperPattern(),
          _buildLoginForm(),
        ],
      ),
    );
  }
}
