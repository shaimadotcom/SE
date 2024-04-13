import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:learnjava/localization/language_constrants.dart';
import 'package:learnjava/screens/auth/register_screen.dart';
import 'package:learnjava/utill/animationConfiguration.dart';
import 'package:learnjava/utill/color_resources.dart';
import 'package:learnjava/utill/custom_themes.dart';
import 'package:learnjava/utill/dimensions.dart';
import 'package:learnjava/utill/images.dart';
import 'package:lottie/lottie.dart';

import 'login_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  late final AnimationController _bottomMenuHeightAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
  );

  late final Animation<double> _bottomMenuHeightUpAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
    CurvedAnimation(
      parent: _bottomMenuHeightAnimationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
    ),
  );
  late final Animation<double> _bottomMenuHeightDownAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
    CurvedAnimation(
      parent: _bottomMenuHeightAnimationController,
      curve: const Interval(0.6, 1.0, curve: Curves.easeInOut),
    ),
  );

  Future<void> startAnimation() async {
    //cupertino page transtion duration
    await Future.delayed(const Duration(milliseconds: 300));

    _bottomMenuHeightAnimationController.forward();
  }

  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  @override
  void dispose() {
    _bottomMenuHeightAnimationController.dispose();
    super.dispose();
  }

  Widget _buildLottieAnimation() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: ColorResources.primaryColor,
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + MediaQuery.of(context).size.height * (0.05),
        ),
        height: MediaQuery.of(context).size.height * (0.4),
        child: Lottie.asset("assets/animations/onboarding.json"),
      ),
    );
  }

  Widget _buildBottomMenu() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedBuilder(
        animation: _bottomMenuHeightAnimationController,
        builder: (context, child) {
          final height = MediaQuery.of(context).size.height * (0.6) * _bottomMenuHeightUpAnimation.value - MediaQuery.of(context).size.height * (0.05) * _bottomMenuHeightDownAnimation.value;
          return Container(
            width: MediaQuery.of(context).size.width,
            height: height,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: AnimatedSwitcher(
              switchInCurve: Curves.easeInOut,
              duration: const Duration(milliseconds: 400),
              child: _bottomMenuHeightAnimationController.value != 1.0
                  ? const SizedBox()
                  : LayoutBuilder(
                      builder: (context, boxConstraints) {
                        return SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: MediaQuery.of(context).size.width * (0.1),
                                ),
                                child: Animate(
                                  effects: customItemZoomAppearanceEffects(
                                    delay: const Duration(
                                      milliseconds: 10,
                                    ),
                                    duration: const Duration(
                                      seconds: 1,
                                    ),
                                  ),
                                  child: Image.asset(
                                    Images.settings,
                                    height: 175,
                                  ),

                                  // SvgPicture.asset(
                                  //   UiUtils.getImagePath("appLogo.svg"),
                                  // ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: MediaQuery.of(context).size.width * (0.1),
                                ),
                                child: Text(getTranslated("Welcome To Java Learning", context) ?? "Welcome To Java Learning",
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w600,
                                    color: ColorResources.primaryOrangeColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: boxConstraints.maxHeight * (0.05),
                              ),
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
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      child: Text(getTranslated('Login', context) ?? "Login", style: titilliumSemiBold.copyWith(color: ColorResources.white, fontSize: Dimensions.fontSizeLarge)),
                                    ),
                                  )),

                              SizedBox(
                                height: boxConstraints.maxHeight * (0.04),
                              ),
                              Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 15.0), //
                                  alignment: Alignment.center,
                                  height: 55.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: ColorResources.white,
                                    border: Border.all(
                                      color: ColorResources.primaryColor,
                                    ),
                                  ),
                                  width: MediaQuery.of(context).size.width * 0.7,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RegisterScreen()));
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      child: Text(getTranslated('SignUp', context) ?? "SignUp", style: titilliumSemiBold.copyWith(color: ColorResources.primaryColor, fontSize: Dimensions.fontSizeLarge)),
                                    ),
                                  )),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.primaryColor,
      body: Stack(
        children: [
          _buildLottieAnimation(),
          _buildBottomMenu(),
        ],
      ),
    );
  }
}
